#!/bin/bash

# ==============================================================================
# INSTALL-GLOBAL-LINKS (Antigo copy_agcao_files.sh)
# ==============================================================================
# Este script configura o ambiente GLOBAL do usuário para usar as regras deste Hub.
# Ele cria links simbólicos nas pastas de configuração das ferramentas (~/.codex, etc)
# apontando para o arquivo MESTRE gerado pelo AlignTrue neste repositório.
# ==============================================================================

# Descobrir o caminho absoluto deste repositório
SCRIPT_DIR="$(dirname "$0")"
REPO_ROOT="$(readlink -f "$SCRIPT_DIR")"

# O arquivo fonte é o AGENTS.md gerado pelo aligntrue sync na raiz deste repo
SOURCE_RULES="$REPO_ROOT/AGENTS.md"

if [ ! -f "$SOURCE_RULES" ]; then
    echo "❌ Erro: $SOURCE_RULES não encontrado."
    echo "   Por favor, rode 'aligntrue sync' neste repositório antes de instalar."
    exit 1
fi

echo "🚀 Configurando links globais para apontar para: $SOURCE_RULES"

# --- Funções Auxiliares ---
create_link() {
    local target="$1"
    local link_path="$2"
    local dir_path="$(dirname "$link_path")"

    mkdir -p "$dir_path"
    rm -f "$link_path" # Remove arquivo ou link anterior
    ln -sf "$target" "$link_path"
    echo "   ✅ Link criado: $link_path -> AGENTS.md"
}

# --- 1. Configuração dos Agentes ---

# Codex
create_link "$SOURCE_RULES" "$HOME/.codex/AGENTS.md"

# Gemini CLI (Global)
create_link "$SOURCE_RULES" "$HOME/.gemini/GEMINI.md"

# Cline (Global)
# Nota: Cline geralmente usa regras por projeto, mas este link serve como fallback global
create_link "$SOURCE_RULES" "$HOME/.clinerules"

# Aider (Global)
# O Aider precisa de um arquivo de config apontando para o arquivo de regras
AIDER_CONF="$HOME/.aider.conf.yml"
echo "read: $SOURCE_RULES" > "$AIDER_CONF"
echo "   ✅ Aider configurado: $AIDER_CONF aponta para AGENTS.md"

# Opencode
create_link "$SOURCE_RULES" "$HOME/.config/opencode/AGENTS.md"


# --- 2. Backup de Configurações (Opcional - Mantido do script original) ---

echo ""
echo "📦 Executando backup de configurações locais para o repositório..."

backup_file() {
    local src="$1"
    local dest_dir="$2"
    if [ -f "$src" ]; then
        mkdir -p "$dest_dir"
        cp "$src" "$dest_dir/"
        echo "   ok: $(basename "$src") -> $dest_dir"
    fi
}

backup_dir() {
    local src="$1"
    local dest="$2"
    if [ -d "$src" ]; then
        mkdir -p "$dest"
        cp -r "$src"/* "$dest/" 2>/dev/null || true
        echo "   ok: $(basename "$src") -> $dest"
    fi
}

# Prompts e Extensões
backup_dir "$HOME/.codex/prompts" "./prompts_backup"
backup_dir "$HOME/.gemini/extensions" "./extensions_backup"

# Configurações JSON/TOML (MCPs e Settings)
backup_file "$HOME/.codex/config.toml" "./mcps_backup/codex"
backup_file "$HOME/.gemini/settings.json" "./mcps_backup/gemini"
backup_file "$HOME/.cline/config.json" "./mcps_backup/cline"
backup_file "$HOME/.aider/config.json" "./mcps_backup/aider"
backup_file "$HOME/.config/opencode/opencode.json" "./mcps_backup/opencode"

echo ""
echo "✨ Instalação e Backup concluídos com sucesso!"
echo "   Seus agentes globais agora obedecem às regras deste Hub Central."