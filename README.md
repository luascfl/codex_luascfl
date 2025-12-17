# Instruções para baixar skills como prompts do Codex

## 1. Slash commands no Codex CLI
No Codex CLI, digite `/` no composer para abrir a janela de comandos rápidos. Você consegue controlar a sessão sem sair do terminal: trocar modelos (`/model`), ajustar aprovações (`/approvals`), revisar mudanças (`/review` ou `/diff`), compactar histórico (`/compact`), mencionar arquivos (`/mention`), conferir o estado (`/status`) e encerrar (`/quit` ou `/exit`).  
Também vale abrir `/mcp` para ver ferramentas externas (MCPs) ativadas, ou `/feedback` para enviar logs em caso de problemas.

## 2. Convertendo skills existentes em prompts reutilizáveis
Slash commands customizados não dependem mais de `~/.codex/skills/`; eles são apenas prompts Markdown guardados em `~/.codex/prompts/` (ou `.codex/prompts/` no repositório). Neste repositório já existem os prompts `confidence-check`, `anthropics-frontend-design`, `obra-brainstorming` e `alex-hormozi-pitch` como exemplos de como migrar skills. Para cada skill que você ainda tiver instalada em `~/.codex/skills/`:

1. **Liste os arquivos de skill:**
   ```bash
   ls ~/.codex/skills
   ```
   Cada pasta contém um `SKILL.md` (e possivelmente binários/handlers). Use essas instruções como base para o prompt.

2. **Crie o diretório de prompts (se ainda não existir):**
   ```bash
   mkdir -p ~/.codex/prompts
   ```

3. **Reescreva o `SKILL.md` como prompt Markdown:**
   - Copie o frontmatter (`name`, `description`, etc.) e use-o como `description:` no novo prompt.
   - Adapte o texto de uso, as orientações e exemplos para o corpo do Markdown no prompt.
   - Mantenha a estrutura de seções (propósito, passos, exemplos) e inclua placeholders como `$1` ou `$ARGUMENTOS` conforme necessário.
   - Exemplo do prompt `confidence-check` (já preparado aqui): converteu a skill em um comando com `argument-hint` e passos claros para revisar afirmações, atribuir confiança e sugerir checagens.
   - Salve o prompt com nome claro, como `confidence-check.md`, diretamente dentro de `~/.codex/prompts/`.

4. **Copie a lógica adicional se precisar** (scripts, bibliotecas ou trechos de `confidence.ts`) para a mesma pasta ou reescreva como parte do prompt; o foco é que todo o contexto necessário esteja no Markdown.
5. **Remova a skill antiga** (pasta em `~/.codex/skills/`) depois de confirmar que o prompt funciona, para evitar duplicidade.
6. **Reinicie o Codex CLI** (ou abra uma nova sessão) para carregar os prompts. O Codex procura por esses Markdown dentro de `~/.codex/prompts/`, mas você também pode mantê-los sob `.codex/prompts/` neste repositório se quiser versionar ou compartilhar as instruções. Confirme com `/status` que a raiz `~/.codex/prompts/` está disponível como “writable” antes de invocar os novos comandos.
   ```bash
   mkdir -p ~/.codex/prompts
   ```
2. **Baixe a skill como prompt:**
   - Copie o conteúdo de `https://github.com/SuperClaude-Org/SuperClaude_Framework/blob/master/plugins/superclaude/skills/confidence-check/` para uma pasta temporária.
   - Resuma o propósito da skill no corpo do prompt e mantenha as instruções de uso, exemplos ou títulos relevantes naquele Markdown.

3. **Crie o prompt com frontmatter:**
   ```markdown
   ---
   description: Revisar outra resposta com níveis de confiança e sugestões de validação
   argument-hint: [TEXTO="<trecho>"]
   ---

   Use esta skill para revisar o texto em $TEXTO e liste afirmações principais com uma nota de confiança (0-100%) para cada uma, indicando verificações adicionais quando necessário.
   ```
   - Use placeholders `$1`–`$9` para argumentos posicionais e `$ARGUMENTS` ou `KEY=value` para argumentos nomeados.
   - Guarde o arquivo como `confidence-check.md` (ou outro nome claro) diretamente dentro de `~/.codex/prompts/`.

4. **Adicione conteúdo de suporte se precisar** (trechos de `SKILL.md`, exemplos ou checklists) logo abaixo do frontmatter, desde que permaneçam dentro da mesma pasta.

5. **Reinicie o Codex CLI** (ou abra uma nova sessão) para que o prompt seja carregado.

## 3. Evocando a skill via slash command
- Abra o popup com `/` e digite `prompts:confidence-check` (ou o nome do arquivo) para ver a descrição.  
- Preencha os argumentos sugeridos no `argument-hint`, por exemplo:  
  ```
  /prompts:confidence-check TEXTO="Revisar a resposta que acabei de dar..."
  ```
- O Codex expande o prompt com o texto preparado. Revise a saída e, se precisar de ajustes, invoque novamente com outra entrada ou abra `/status`/`/diff` para verificar o contexto.

## 4. Manutenção de prompts personalizados
- Edite ou exclua o Markdown dentro de `~/.codex/prompts/` para mudar o comando.  
- Use metadados como `argument-hint:` e descrições para facilitar a invocação.  
- Depois de alterar qualquer prompt, reinicie o Codex ou inicie um novo chat para recarregar o cache.  
- O Codex ignora subpastas nesse diretório; mantenha cada prompt diretamente no nível superior (`~/.../prompts/meu-comando.md`).

## 5. Instruções persistentes com AGENTS.md
Codex monta a cadeia de instruções a cada inicialização combinando orientação global e regras do projeto.

- **Descoberta e precedência**: verifica o diretório `CODEX_HOME` (padrão `~/.codex`) e usa `AGENTS.override.md` se existir; caso contrário, `AGENTS.md` (ignora arquivos vazios). Em seguida sobe do root do repositório até o diretório atual e inclui no máximo um arquivo por pasta, priorizando `AGENTS.override.md`, `AGENTS.md` e os nomes em `project_doc_fallback_filenames`. Os arquivos são concatenados do root para o diretório atual, então itens mais próximos do trabalho sobrescrevem os anteriores. A busca para quando o tamanho combinado atinge `project_doc_max_bytes` (32 KiB por padrão).
- **Criar orientação global**: garanta `mkdir -p ~/.codex` e mantenha ali seu `AGENTS.md` com acordos padrão (ex.: “sempre rode `npm test` para JS”, “prefira `pnpm`”, “peça confirmação antes de dependências de produção”). Use `AGENTS.override.md` para uma substituição global temporária sem apagar o base.
- **Camadas por projeto**: coloque `AGENTS.md` na raiz do repositório para normas gerais e adicione `AGENTS.override.md` em subpastas que precisem de regras diferentes (quanto mais perto da pasta de trabalho, maior a precedência). Se já existir outro nome no projeto (ex.: `TEAM_GUIDE.md`), liste-o em `project_doc_fallback_filenames` no `~/.codex/config.toml` e reinicie o Codex. Exemplo:
  ```toml
  project_doc_fallback_filenames = ["TEAM_GUIDE.md", ".agents.md"]
  project_doc_max_bytes = 65536
  ```
- **Perfis alternativos**: defina `CODEX_HOME=/caminho/para/perfil/.codex` antes de rodar o Codex para usar outro conjunto de instruções (útil para automação/usuários dedicados).
- **Verificação e auditoria**: na raiz do repo, rode `codex --ask-for-approval never "Summarize the current instructions."`. Em subpastas, use `codex --cd subdir --ask-for-approval never "Show which instruction files are active."` para ver a cadeia final. Logs detalhados ficam em `~/.codex/log/codex-tui.log` ou nos arquivos `session-*.jsonl`.
- **Solução rápida**: se nada carregar, confira se você está no root certo e se os arquivos têm conteúdo; se vier instrução errada, procure por `AGENTS.override.md` acima; se atingir o limite de bytes, aumente `project_doc_max_bytes` ou divida instruções em pastas mais profundas.

## Próximos passos
- Aprenda a escrever prompts eficazes com o guia oficial do Codex.  
- Padronize instruções persistentes em `AGENTS.md` via `/init`.  
- Configure modelos e políticas padrão em `~/.codex/config.toml` se quiser automatizar esse comportamento.
