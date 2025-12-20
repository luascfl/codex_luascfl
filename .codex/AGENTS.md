Instruções do ambiente de ia e sistema de arquivos
Este documento centraliza a configuração do ambiente de inteligência artificial no Lubuntu, definindo o padrão AGC (Agents.md, Gemini.md, Cline rules) e o uso de recursos específicos como skills, gems e extensões CLI.
1. Visão geral e definições
O objetivo é manter a consistência entre Codex, Gemini e Cline. Utilizamos a sigla AGC para o conjunto de arquivos de instruções mestras.
Definição do AGC:
Agents.md (Codex)
Gemini.md (Contexto do Gemini)
Cline rules (.clinerules)
Além do AGC, o Codex suporta Agent Skills nativas e o Cline opera como um agente autônomo com suporte avançado a MCP.
2. Instruções personalizadas pessoais e de estilo
Estas diretrizes compõem o núcleo do AGC e devem ser obedecidas por todos os assistentes.
Estilo de escrita e tom
Escreva de forma fluida e articulada, conectando as ideias logicamente, mas utilize um registro de linguagem natural e acessível, evitando estritamente o academicismo excessivo, jargões complexos ou orações labirínticas que prejudiquem a leitura. Busque um equilíbrio rítmico: combine frases articuladas com pausas claras e vocabulário cotidiano, garantindo que a sofisticação esteja na clareza do raciocínio e não na dificuldade das palavras, tornando o texto envolvente sem ser denso ou cansativo.
Evite estruturas de frase que criem uma expectativa para depois negá-la ou expandi-la. Em vez disso, use afirmações diretas e positivas. Sinta-se à vontade para ser criativo na construção das frases e nos estilos de expressão.
Regras de formatação
Não use maiúscula para fins estilísticos, use sentence case sempre que possível.
Não use emojis.
Não use em dashes, travessões ou hífens no lugar de vírgula.
Perfil do usuário
Nome: Lucas Camilo Carvalho.
Localização: Salvador, Bahia.
Idiomas: Português (Primário), Inglês (Secundário).
3. Instruções sobre o google drive e gemini gems
O sistema utiliza Lubuntu com montagem de rede via GVFS (Koofr WebDAV). Utilize caminhos absolutos.
Caminho base (root)
"/run/user/1000/gvfs/dav:host=app.koofr.net,ssl=true,user=lucascamr107%40gmail.com,prefix=%2Fdav/Google Drive/"


Diretório de gemini gems (Interface Web)
Localização: .../Google Drive/Gemini Gems/
Nota: As orientações desta seção aplicam-se exclusivamente à gestão de Gems criados e utilizados na interface web do Gemini. O Gemini CLI não interage nativamente com arquivos .gem.
Protocolos de leitura e execução
Arquivos .gem: arquivos na pasta Gemini Gems podem ter extensão .gem ou nenhuma. Use o comando cat "Nome do Arquivo.gem" para ler o JSON e extrair a url se necessário.
Sintaxe: o caminho contém espaços, sempre use aspas duplas. Arquivos podem iniciar com emojis (ex.: ❗).
Criação de gems: use o padrão ❗ Estrutura {Nome do prompt}. Crie arquivos com extensões explícitas (.txt, .json, .md) para conteúdo legível.
Navegação: defina a variável $GDRIVE com o caminho base para facilitar o acesso.
4. Sincronização do AGC e instruções persistentes
Para unificar o comportamento, os arquivos de instruções devem estar sincronizados. Crie um arquivo mestre (ex.: AGC_Master.md) e linque aos locais de destino.
Hierarquia de configuração do Gemini CLI
As configurações do Gemini são mescladas a partir de quatro fontes, em ordem de precedência (do menor para o maior autoridade). Listas e objetos (como mcpServers) são combinados, enquanto valores únicos são sobrescritos.
System Defaults: Padrão do sistema (system-defaults.json).
User Settings: Configuração pessoal (~/.gemini/settings.json).
Workspace Settings: Configuração do projeto (<projeto>/.gemini/settings.json).
System Overrides: Definição global mandatória (settings.json).
Locais de configuração (targets AGC)
Codex (Agents.md): arquivo principal em ~/.codex/AGENTS.md. Overrides podem ser feitos com AGENTS.override.md na raiz do repositório.
Cline (.clinerules): arquivo .clinerules na raiz do diretório de trabalho.
Gemini (Gemini.md): insira o conteúdo nas "System Instructions" via configurações do usuário ou no preâmbulo dos Gems.
Verificação no Codex
Use codex --ask-for-approval never "Show which instruction files are active.".
5. Como adicionar mcp e extensões
Ferramentas externas expandem a interatividade das IAs, permitindo que editem arquivos e executem comandos.
Gemini CLI Extensions
A maneira preferencial de adicionar funcionalidades ao Gemini é instalando extensões prontas diretamente pelo CLI.
Instalação: utilize o comando gemini extensions install <url-do-repositorio>.
Exemplo: gemini extensions install https://github.com/gemini-cli-extensions/workspace
Gemini (Configuração Manual de MCP)
Para ferramentas locais específicas que não estão empacotadas como extensões, edite diretamente os arquivos de configuração (preferencialmente ~/.gemini/settings.json).
Sintaxe:
{
  "mcpServers": {
    "nome-da-ferramenta": {
      "command": "comando-de-execucao",
      "args": ["argumento1", "argumento2"]
    }
  }
}


Cline
O Cline permite gerenciar ferramentas MCP através de uma interface dedicada ou edição manual de arquivos JSON.
Instalação via interface: clique no ícone MCP na barra de ferramentas do Cline, selecione o servidor desejado (ex.: Slack) e clique para instalar. O Cline tentará configurar o ambiente automaticamente.
Configuração manual (cline_mcp_settings.json): caso a configuração automática falhe ou precise de ajustes, edite o arquivo cline_mcp_settings.json.
Exemplo prático (Slack no Linux):
Siga as instruções de setup do repositório oficial do Slack MCP para obter seus tokens.
Adicione a configuração ao JSON:
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-seu-token",
        "SLACK_TEAM_ID": "T01234567"
      }
    }
  }
}


Nota: em ambientes Windows, o comando pode exigir cmd e argumentos /c antes do npx, mas no Lubuntu use a sintaxe acima.
Compartilhamento: servidores personalizados podem ser compartilhados via ~/Documents/Cline/MCP.
Codex
Digite /mcp para ver ferramentas ativas.
Edite ~/.codex/config.toml e adicione a tabela [mcp_servers] seguindo a sintaxe TOML.
Exemplo:
[mcp_servers.filesystem]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-filesystem", "/home/lucas"]


6. Como adicionar skills
As skills funcionam de maneira diferente dependendo da plataforma. O Codex possui suporte nativo a Agent Skills, enquanto Gemini e Cline utilizam abordagens distintas.
Codex
O Codex utiliza skills para executar fluxos de trabalho específicos. Uma skill é uma pasta contendo obrigatoriamente um arquivo SKILL.md com instruções e metadados, podendo incluir scripts e assets opcionais.
Instalação: para expandir a lista de skills nativas, baixe novas skills de um conjunto curado no GitHub usando o comando $skill-installer. Exemplo: $skill-installer linear.
Criação automática: utilize a skill nativa $skill-creator. Descreva o que deseja e o Codex iniciará o processo. Se combinar com a skill $plan, o Codex criará primeiro um plano de execução.
Criação manual: crie uma pasta dentro de um local válido (preferencialmente ~/.codex/skills) contendo um arquivo SKILL.md. Este arquivo deve conter nome e descrição no frontmatter para auxiliar a seleção pelo Codex:
---
name: nome-da-skill
description: Descrição que ajuda o Codex a selecionar a skill
metadata:
  short-description: Descrição opcional para o usuário
---

Logo após o frontmatter, insira as instruções que o agente deve seguir.
Invocação: pode ser explícita (usando /skills ou digitando $) ou implícita (o Codex decide usar baseando-se na descrição).
Armazenamento global: utilize sempre a pasta pessoal do usuário (~/.codex/skills) para garantir disponibilidade em qualquer projeto.
Cline e Gemini
O Gemini e o Cline não suportam o padrão de Agent Skills do Codex.
Cline: Descreva capacidades específicas no arquivo .clinerules ou crie ferramentas MCP via linguagem natural conforme descrito na seção 5.
7. Como adicionar prompts
Prompts reutilizáveis servem para tarefas rápidas e repetitivas.
Codex
Crie um arquivo Markdown em ~/.codex/prompts/.
Use frontmatter YAML para descrição e dicas de argumentos.
Invoque com /prompts:nome-do-arquivo.
