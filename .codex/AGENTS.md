# AI Environment & File System Context
> System: Lubuntu (Linux) | Mount: GVFS (Koofr WebDAV)

## 📂 Mapeamento do Google Drive
O acesso ao Google Drive é feito via montagem de rede (WebDAV/Koofr). Utilize estritamente o caminho absoluto abaixo.

**Caminho Base (Root):**
```bash
"/run/user/1000/gvfs/dav:host=app.koofr.net,ssl=true,user=lucascamr107%40gmail.com,prefix=%2Fdav/Google Drive/"
```

**📍 Subdiretórios Relevantes**
- Gemini Gems: .../Google Drive/Gemini Gems/

**⚠️ Protocolos de Leitura e Execução**

1. Tratamento de Arquivos .gem (ou sem extensão)  
   Identificação: arquivos na pasta Gemini Gems podem ter extensão `.gem` ou nenhuma extensão, com mime-type `application/vnd.google-gemini.gem`.  
   Ação Obrigatória: usar comando `cat`.  
   Comando:
   ```bash
   cat "Nome do Arquivo.gem"
   ```
   Interpretação: o retorno será um JSON (`{"url": "...", "resource_id": "..."}`). Extraia `url` se precisar acessar o recurso; ignore se a intenção for ler o conteúdo do chat (ele não está no arquivo).

2. Sintaxe de Caminhos  
   Espaços: o caminho contém espaços; sempre use aspas duplas (`""`) ao redor do caminho completo.  
   Caracteres Especiais: arquivos podem iniciar com emojis (ex.: ❗). Use tab-completion ou wildcards (`*`) para referenciar.

3. Nomeação ao criar novas estruturas/gems  
   Ao criar arquivos na pasta Gemini Gems, use o padrão `❗ Estrutura {Nome do prompt}` (ex.: `❗ Estrutura Otimização de textos para apresentações memoráveis`), mantendo o prefixo e o espaço após o emoji.

4. Criação e alteração de arquivos  
   Não criar nem modificar arquivos sem extensão. Para leitura de arquivos sem extensão, use apenas `cat` conforme item 1. Quando for necessário escrever, crie arquivos com extensões explícitas (ex.: `.txt`, `.json`, `.md`) e mantenha o padrão de nomenação do item 3.

5. Exemplo de Navegação Segura
   ```bash
   # 1. Definir variável (opcional para facilitar)
   export GDRIVE="/run/user/1000/gvfs/dav:host=app.koofr.net,ssl=true,user=lucascamr107%40gmail.com,prefix=%2Fdav/Google Drive/"

   # 2. Listar arquivos
   ls "$GDRIVE/Gemini Gems/"

   # 3. Inspecionar um Gem
   cat "$GDRIVE/Gemini Gems/❗ Estrutura Exemplo.gem"
   ```
