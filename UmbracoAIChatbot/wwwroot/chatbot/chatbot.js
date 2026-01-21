(() => {
  const panel = document.getElementById("chatbot-panel");
  const toggle = document.getElementById("chatbot-toggle");
  const form = document.getElementById("chatbot-form");
  const input = document.getElementById("chatbot-input");
  const messages = document.getElementById("chatbot-messages");
  const typing = document.getElementById("chatbot-typing");

  if (!panel || !toggle || !form || !input || !messages || !typing) {
    return;
  }

  const history = [];

  const sectionMap = [
    { id: "contact", keywords: ["contact", "email", "phone", "address", "reach", "call"] },
    { id: "services", keywords: ["service", "services", "consulting", "cloud", "automation", "analytics", "security"] },
    { id: "products", keywords: ["product", "products", "fanselector", "dynamics", "portal", "solution"] },
    { id: "about", keywords: ["about", "company", "greybeard", "who are you"] },
    { id: "hero", keywords: ["home", "top", "hero"] }
  ];

  const findSection = (text) => {
    const lower = text.toLowerCase();
    for (const section of sectionMap) {
      if (section.keywords.some((keyword) => lower.includes(keyword))) {
        return section.id;
      }
    }
    return null;
  };

  const scrollToSection = (sectionId) => {
    if (!sectionId) {
      return;
    }

    const target = document.getElementById(sectionId);
    if (target) {
      target.scrollIntoView({ behavior: "smooth", block: "start" });
    }
  };

  const cleanMarkdown = (text) =>
    text
      .replace(/^#{1,6}\s*/gm, "")
      .replace(/\*\*(.*?)\*\*/g, "$1")
      .replace(/__(.*?)__/g, "$1")
      .replace(/\*(.*?)\*/g, "$1")
      .replace(/_(.*?)_/g, "$1")
      .replace(/`([^`]+)`/g, "$1")
      .replace(/^\s*[-*+]\s+/gm, "• ")
      .replace(/^\s*\d+\.\s+/gm, "• ")
      .trim();

  const addMessage = (role, content) => {
    const bubble = document.createElement("div");
    bubble.className = `chatbot-message ${role}`;
    const safeText = role === "bot" ? cleanMarkdown(content) : content;
    bubble.textContent = safeText;
    messages.appendChild(bubble);
    messages.scrollTop = messages.scrollHeight;

    if (role === "bot") {
      const sectionId = findSection(safeText);
      scrollToSection(sectionId);
    }
  };

  const setTyping = (show) => {
    typing.style.display = show ? "block" : "none";
  };

  toggle.addEventListener("click", () => {
    panel.classList.toggle("open");
  });

  form.addEventListener("submit", async (event) => {
    event.preventDefault();
    const text = input.value.trim();
    if (!text) {
      return;
    }

    addMessage("user", text);
    history.push({ role: "user", content: text });
    input.value = "";

    scrollToSection(findSection(text));

    setTyping(true);
    try {
      const response = await fetch("/api/chatbot", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ message: text, history })
      });

      const data = await response.json();
      if (!response.ok) {
        const errorMessage = data?.error || "Sorry, something went wrong.";
        addMessage("bot", errorMessage);
        setTyping(false);
        return;
      }

      const reply = data?.reply || "";
      addMessage("bot", reply);
      history.push({ role: "assistant", content: reply });
    } catch {
      addMessage("bot", "Sorry, I couldn't reach the assistant right now.");
    } finally {
      setTyping(false);
    }
  });
})();
