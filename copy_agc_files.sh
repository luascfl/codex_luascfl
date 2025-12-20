#!/bin/bash

# Script para copiar os arquivos AGC para as pastas corretas no sistema

# Caminhos de origem
SOURCE_CLINERULES=".clinerules"
SOURCE_AGENTS=".codex/AGENTS.md"
SOURCE_GEMINI="GEMINI.md"
SOURCE_AIDER=".aider.conf.yml"

# Caminhos de destino
DEST_CLINERULES="$HOME/.clinerules"
DEST_AGENTS="$HOME/.codex/AGENTS.md"
DEST_GEMINI="$HOME/.gemini/GEMINI.md"
DEST_AIDER="$HOME/.aider.conf.yml"

# Cria os diretórios de destino se não existirem
mkdir -p "$HOME/.codex"
mkdir -p "$HOME/.gemini"

# Copia os arquivos
echo "Copiando .clinerules para $DEST_CLINERULES..."
cp "$SOURCE_CLINERULES" "$DEST_CLINERULES"

echo "Copiando AGENTS.md para $DEST_AGENTS..."
cp "$SOURCE_AGENTS" "$DEST_AGENTS"

echo "Copiando GEMINI.md para $DEST_GEMINI..."
cp "$SOURCE_GEMINI" "$DEST_GEMINI"

echo "Copiando .aider.conf.yml para $DEST_AIDER..."
cp "$SOURCE_AIDER" "$DEST_AIDER"

echo "Arquivos AGC copiados com sucesso!"
