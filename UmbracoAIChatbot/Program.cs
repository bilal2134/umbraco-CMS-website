using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Models.Blocks;
using Umbraco.Cms.Core.Web;
using Umbraco.Extensions;

using Umbraco.Cms.Core.PublishedCache;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.Configure<ChatbotOptions>(builder.Configuration.GetSection("Chatbot"));
builder.Services.AddHttpClient("AzureOpenAI");

builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddComposers()
    .Build();

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

app.MapPost("/api/chatbot", async (
    ChatRequest request,
    IOptions<ChatbotOptions> options,
    IHttpClientFactory httpClientFactory,
    IUmbracoContextFactory umbracoContextFactory) =>
{
    if (string.IsNullOrWhiteSpace(request.Message))
    {
        return Results.BadRequest(new { error = "Message is required." });
    }

    ChatbotOptions config = options.Value;
    if (string.IsNullOrWhiteSpace(config.Endpoint) ||
        string.IsNullOrWhiteSpace(config.ApiKey) ||
        string.IsNullOrWhiteSpace(config.DeploymentName))
    {
        return Results.Problem("Chatbot is not configured.", statusCode: 500);
    }

    List<ChatMessage> messages = new();
    if (!string.IsNullOrWhiteSpace(config.SystemPrompt))
    {
        messages.Add(new ChatMessage("system", config.SystemPrompt));
    }

    string? siteContext = BuildSiteContext(umbracoContextFactory);
    if (!string.IsNullOrWhiteSpace(siteContext))
    {
        messages.Add(new ChatMessage("system", siteContext));
    }

    if (request.History != null)
    {
        foreach (ChatMessage item in request.History)
        {
            if (string.IsNullOrWhiteSpace(item.Content))
            {
                continue;
            }

            string role = item.Role?.Trim().ToLowerInvariant() ?? "user";
            if (role is "user" or "assistant")
            {
                messages.Add(new ChatMessage(role, item.Content));
            }
        }
    }

    messages.Add(new ChatMessage("user", request.Message));

    object payload = new
    {
        model = config.DeploymentName,
        messages = messages.Select(m => new { role = m.Role, content = m.Content }),
        temperature = config.Temperature,
        max_tokens = config.MaxTokens
    };

    string endpoint = config.Endpoint.Trim();
    if (!endpoint.EndsWith("/"))
    {
        endpoint += "/";
    }

    Uri url = new(new Uri(endpoint), "chat/completions");
    HttpClient httpClient = httpClientFactory.CreateClient("AzureOpenAI");
    using HttpRequestMessage httpRequest = new(HttpMethod.Post, url);
    httpRequest.Headers.Add("api-key", config.ApiKey);
    httpRequest.Content = new StringContent(JsonSerializer.Serialize(payload), Encoding.UTF8, "application/json");

    using HttpResponseMessage response = await httpClient.SendAsync(httpRequest);
    string responseBody = await response.Content.ReadAsStringAsync();

    if (!response.IsSuccessStatusCode)
    {
        return Results.Problem(responseBody, statusCode: (int)response.StatusCode);
    }

    string? reply = ExtractReply(responseBody);
    return Results.Ok(new ChatResponse(reply ?? ""));
});


app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseBackOffice();
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.UseBackOfficeEndpoints();
        u.UseWebsiteEndpoints();
    });

await app.RunAsync();

static string? ExtractReply(string responseBody)
{
    try
    {
        using JsonDocument doc = JsonDocument.Parse(responseBody);
        if (doc.RootElement.TryGetProperty("choices", out JsonElement choices) &&
            choices.ValueKind == JsonValueKind.Array &&
            choices.GetArrayLength() > 0)
        {
            JsonElement choice = choices[0];
            if (choice.TryGetProperty("message", out JsonElement message) &&
                message.TryGetProperty("content", out JsonElement content))
            {
                return content.GetString();
            }
        }
    }
    catch
    {
        // ignore parse errors
    }

    return null;
}

static string? BuildSiteContext(IUmbracoContextFactory umbracoContextFactory)
{
    using var ctx = umbracoContextFactory.EnsureUmbracoContext();
    var content = ctx.UmbracoContext.Content;
    if (content == null)
    {
        return null;
    }

    var homepage = content.GetById(false, Guid.Parse("8953e311-9ce4-46f8-a065-195fa60d5170"));

    if (homepage == null)
    {
        return null;
    }

    List<string> services = homepage
        .Value<BlockListModel>("servicesItems")?
        .Select(item => item.Content.Value<string>("title"))
        .Where(title => !string.IsNullOrWhiteSpace(title))
        .ToList() ?? new List<string>();

    List<string> products = homepage
        .Value<BlockListModel>("featuredProducts")?
        .Select(item => item.Content.Value<string>("title"))
        .Where(title => !string.IsNullOrWhiteSpace(title))
        .ToList() ?? new List<string>();

    string contactEmail = homepage.Value<string>("contactEmail") ?? string.Empty;

    StringBuilder context = new();
    context.AppendLine("Live site context:");

    if (services.Count > 0)
    {
        context.AppendLine($"Services: {string.Join(", ", services)}");
    }

    if (products.Count > 0)
    {
        context.AppendLine($"Featured products: {string.Join(", ", products)}");
    }

    if (!string.IsNullOrWhiteSpace(contactEmail))
    {
        context.AppendLine($"Contact: {contactEmail}");
    }

    context.AppendLine("Sections: hero, services, products, about, contact.");
    return context.ToString().Trim();
}

sealed record ChatRequest(string Message, List<ChatMessage>? History);
sealed record ChatMessage(string Role, string Content);
sealed record ChatResponse(string Reply);

sealed class ChatbotOptions
{
    public string Endpoint { get; set; } = string.Empty;
    public string ApiKey { get; set; } = string.Empty;
    public string DeploymentName { get; set; } = string.Empty;
    public string SystemPrompt { get; set; } = "You are a helpful assistant.";
    public int MaxTokens { get; set; } = 800;
    public float Temperature { get; set; } = 0.7f;
}
