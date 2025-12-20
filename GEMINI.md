---
# GEMINI.md - Configuração baseada no README.md
# Este arquivo define as regras e configurações para o Gemini no ambiente AGC.

# 1. Visão geral e definições (conforme README.md)
visão_geral:
  objetivo: "Manter a consistência entre Codex, Gemini e Cline."
  definição_agc:
    - "Agents.md (Codex)"
    - "Gemini.md (Contexto do Gemini)"
    - "Cline rules (.clinerules)"
  suporte_adicional:
    - "Agent Skills nativas (Codex)"
    - "Cline como agente autônomo com suporte avançado a MCP"

# 2. Instruções personalizadas de estilo (conforme README.md)
estilo_escrita:
  - "Escreva de forma fluida e articulada, conectando ideias logicamente."
  - "Use linguagem natural e acessível, evitando academicismo excessivo ou jargões complexos."
  - "Busque equilíbrio rítmico: combine frases articuladas com pausas claras e vocabulário cotidiano."
  - "Evite estruturas de frase que criem expectativas para depois negá-las."
  - "Use afirmações diretas e positivas."
  - "Seja criativo na construção das frases e estilos de expressão."

formatação:
  - "Use 'sentence case' (apenas a primeira letra maiúscula)."
  - "Não use emojis."
  - "Não use dashes, travessões ou hífens no lugar de vírgulas."

# 3. Perfil do usuário (conforme README.md)
perfil_usuário:
  nome: "Lucas Camilo Carvalho"
  localização: "Salvador, Bahia"
  idiomas:
    - "Português (Primário)"
    - "Inglês (Secundário)"

# 4. Configurações do ambiente (conforme README.md)
ambiente:
  sistema_operacional: "Lubuntu"
  caminho_base_gdrive: "/run/user/1000/gvfs/dav:host=app.koofr.net,ssl=true,user=lucascamr107%40gmail.com,prefix=%2Fdav/Google Drive/"
  diretório_gemini_gems: "Gemini Gems/"

# 5. Protocolos de leitura e execução (conforme README.md)
protocolos:
  leitura_gems:
    comando: 'cat "Nome do Arquivo.gem"'
    observação: "Use sempre aspas duplas para caminhos com espaços."
  criação_gems:
    padrão_nome: "❗ Estrutura {Nome do prompt}"
    extensões: [".txt", ".json", ".md"]

# 6. Hierarquia de configuração (conforme README.md)
hierarquia_configuração:
  - "System Defaults (system-defaults.json)"
  - "User Settings (~/.gemini/settings.json)"
  - "Workspace Settings (<projeto>/.gemini/settings.json)"
  - "System Overrides (settings.json)"

# 7. Locais de configuração AGC (conforme README.md)
locais_agc:
  codex: "~/.codex/AGENTS.md"
  cline: ".clinerules"
  gemini: "System Instructions (via configurações do usuário ou Gems)"

# 8. Instruções para MCP (conforme README.md)
mcp:
  slack:
    comando: "npx"
    args: ["-y", "@modelcontextprotocol/server-slack"]
    env:
      SLACK_BOT_TOKEN: "xoxb-seu-token"
      SLACK_TEAM_ID: "T01234567"
  filesystem:
    comando: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/lucas"]

# 9. Instruções para Skills (conforme README.md)
skills:
  codex:
    local_padrão: "~/.codex/skills"
    estrutura:
      pasta: true
      arquivo_obrigatório: "SKILL.md"
      frontmatter:
        - name
        - description
        - metadata.short-description
    invocação:
      explícita: "/skills ou $"
      implícita: "Codex decide com base na descrição"

# 10. Instruções para Prompts (conforme README.md)
prompts:
  codex:
    local: "~/.codex/prompts/"
    formato: "Markdown com frontmatter YAML"
    invocação: "/prompts:nome-do-arquivo"

# 11. Variáveis de ambiente sugeridas (conforme README.md)
variáveis_ambiente:
  GDRIVE: "/run/user/1000/gvfs/dav:host=app.koofr.net,ssl=true,user=lucascamr107%40gmail.com,prefix=%2Fdav/Google Drive/"

# 12. Comandos úteis (conforme README.md)
comandos:
  verificação_codex: 'codex --ask-for-approval never "Show which instruction files are active."'
  instalação_extensões_gemini: "gemini extensions install <url-do-repositorio>"
  instalação_skills_codex: "$skill-installer <nome-da-skill>"
  criação_skills_codex: "$skill-creator"
