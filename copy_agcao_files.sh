#!/bin/bash

# Script para copiar os arquivos AGCAO para as pastas corretas no sistema

# Descobrir o caminho da pasta onde o script está localizado
SCRIPT_DIR="$(dirname "$0")"
SCRIPT_DIR="$(readlink -f "$SCRIPT_DIR")"

# Caminhos de destino
DEST_CLINERULES="$HOME/.clinerules"
DEST_AGENTS="$HOME/.codex/AGENTS.md"
DEST_GEMINI="$HOME/.gemini/GEMINI.md"
DEST_AIDER="$HOME/.aider.conf.yml"
DEST_OPENCODE="$HOME/.config/opencode/AGENTS.md"

# Cria os diretórios de destino se não existirem
mkdir -p "$HOME/.codex"
mkdir -p "$HOME/.gemini"
mkdir -p "$HOME/.config/opencode"

# Remove symlinks existentes
echo "Removendo symlinks existentes..."
rm -f "$DEST_CLINERULES"
rm -f "$DEST_AGENTS"
rm -f "$DEST_GEMINI"
rm -f "$DEST_AIDER"
rm -f "$DEST_OPENCODE"

# Cria symlinks para os arquivos de configuração do AGCAO
echo "Criando symlinks para os arquivos de configuração do AGCAO..."

# Criar symlink para o Codex
echo "Criando symlink para o Codex..."
ln -sf "$SCRIPT_DIR/AGENTS.md" "$DEST_AGENTS"

# Criar symlink para o Gemini
echo "Criando symlink para o Gemini..."
ln -sf "$SCRIPT_DIR/AGENTS.md" "$DEST_GEMINI"

# Criar symlink para o Cline
echo "Criando symlink para o Cline..."
ln -sf "$SCRIPT_DIR/AGENTS.md" "$DEST_CLINERULES"

# Criar symlink para o Aider
echo "Criando symlink para o Aider..."
ln -sf "$SCRIPT_DIR/AGENTS.md" "$DEST_AIDER"

# Criar symlink para o Opencode
echo "Criando symlink para o Opencode..."
ln -sf "$SCRIPT_DIR/AGENTS.md" "$DEST_OPENCODE"

# Cria symlinks para sincronizar os arquivos
echo "Criando symlinks para sincronizar os arquivos..."
ln -sf "$DEST_OPENCODE" "$HOME/.clinerules"
ln -sf "$DEST_OPENCODE" "$HOME/.aider.conventions.md"

# Exportar prompts do Codex
echo "Exportando prompts do Codex..."
mkdir -p "./prompts_backup"
cp -r "$HOME/.codex/prompts/"* "./prompts_backup/"

# Exportar extensões do Gemini
echo "Exportando extensões do Gemini..."
mkdir -p "./extensions_backup"
cp -r "$HOME/.gemini/extensions/"* "./extensions_backup/" 2>/dev/null || echo "Alguns arquivos não puderam ser copiados devido a permissões."

# Exportar MCPs do AGCAO
echo "Exportando MCPs do AGCAO..."
mkdir -p "./mcps_backup/codex"
mkdir -p "./mcps_backup/gemini"
mkdir -p "./mcps_backup/cline"
mkdir -p "./mcps_backup/aider"
mkdir -p "./mcps_backup/opencode"

# Exportar JSONs de configuração do Codex
echo "Exportando JSONs de configuração do Codex..."
if [ -f "$HOME/.codex/config.toml" ]; then
    cp "$HOME/.codex/config.toml" "./mcps_backup/codex/"
else
    echo "Arquivo config.toml não encontrado em $HOME/.codex/."
fi

# Exportar JSONs de configuração do Gemini
echo "Exportando JSONs de configuração do Gemini..."
if [ -f "$HOME/.gemini/settings.json" ]; then
    cp "$HOME/.gemini/settings.json" "./mcps_backup/gemini/"
else
    echo "Arquivo settings.json não encontrado em $HOME/.gemini/."
fi

# Exportar JSONs de configuração do Cline
echo "Exportando JSONs de configuração do Cline..."
if [ -f "$HOME/.cline/config.json" ]; then
    cp "$HOME/.cline/config.json" "./mcps_backup/cline/"
else
    echo "Arquivo config.json não encontrado em $HOME/.cline/."
fi

# Exportar JSONs de configuração do Aider
echo "Exportando JSONs de configuração do Aider..."
if [ -f "$HOME/.aider/config.json" ]; then
    cp "$HOME/.aider/config.json" "./mcps_backup/aider/"
else
    echo "Arquivo config.json não encontrado em $HOME/.aider/."
fi

# Exportar JSONs de configuração do Opencode
echo "Exportando JSONs de configuração do Opencode..."
if [ -f "$HOME/.config/opencode/opencode.json" ]; then
    cp "$HOME/.config/opencode/opencode.json" "./mcps_backup/opencode/"
else
    echo "Arquivo opencode.json não encontrado em $HOME/.config/opencode/."
fi

echo "Arquivos AGCAO copiados e sincronizados com sucesso!"
