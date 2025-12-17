#!/usr/bin/env bash
set -euo pipefail

# Script para atualizar o Codex em duas modalidades:
#   ./update-codex.sh user  -> atualiza no NVM (usuário)
#   ./update-codex.sh sudo  -> atualiza globalmente (root/sudo)
# Ajuste a versão do Node/NVM se necessário.

NVM_NODE_VERSION="v22.21.1"

user_prefix="$HOME/.nvm/versions/node/$NVM_NODE_VERSION"
sudo_prefix="/usr/local"

ensure_codex_not_running() {
  local context="$1"
  local warning="[$context] detectado uso do codex; finalize as instâncias em execução antes de atualizar."

  if command -v pgrep >/dev/null 2>&1; then
    if pgrep -x codex >/dev/null 2>&1; then
      echo "$warning"
      exit 1
    fi
  elif ps -eo comm | grep -x codex >/dev/null 2>&1; then
    echo "$warning"
    exit 1
  fi
}

run_user() {
  ensure_codex_not_running "user"
  echo "[user] limpando dirs quebrados..."
  rm -rf "$user_prefix/lib/node_modules/@openai/codex" \
         "$user_prefix/lib/node_modules/@openai/.codex-"*

  echo "[user] corrigindo cache npm..."
  mkdir -p "$HOME/.npm"
  chown -R "$(id -u)":"$(id -g)" "$HOME/.npm"
  rm -rf "$HOME/.npm/_cacache" || true
  mkdir -p "$HOME/.npm/_cacache/tmp"
  chown -R "$(id -u)":"$(id -g)" "$HOME/.npm"

  echo "[user] instalando @openai/codex..."
  npm install -g @openai/codex

  echo "[user] ajustando permissão do binário..."
  chmod +x "$user_prefix/lib/node_modules/@openai/codex/bin/codex.js" || true
  if [ ! -L "$user_prefix/bin/codex" ]; then
    ln -sf "$user_prefix/lib/node_modules/@openai/codex/bin/codex.js" "$user_prefix/bin/codex"
  fi

  echo "[user] versão instalada:"
  "$user_prefix/bin/codex" --version
}

run_sudo() {
  echo "[sudo] limpando dirs quebrados..."
  sudo rm -rf "$sudo_prefix/lib/node_modules/@openai/codex" \
              "$sudo_prefix/lib/node_modules/@openai/.codex-"*

  echo "[sudo] corrigindo cache npm (root)..."
  sudo mkdir -p /root/.npm
  sudo chown -R root:root /root/.npm
  sudo rm -rf /root/.npm/_cacache || true
  sudo mkdir -p /root/.npm/_cacache/tmp
  sudo chown -R root:root /root/.npm

  echo "[sudo] instalando @openai/codex..."
  sudo npm install -g @openai/codex

  echo "[sudo] ajustando permissão do binário..."
  sudo chmod +x "$sudo_prefix/lib/node_modules/@openai/codex/bin/codex.js" || true
  if ! sudo test -L "$sudo_prefix/bin/codex"; then
    sudo ln -sf "$sudo_prefix/lib/node_modules/@openai/codex/bin/codex.js" "$sudo_prefix/bin/codex"
  fi

  echo "[sudo] versão instalada:"
  sudo "$sudo_prefix/bin/codex" --version
}

case "${1:-}" in
  user) run_user ;;
  sudo) run_sudo ;;
  *)
    echo "uso: $0 {user|sudo}"
    exit 1
    ;;
esac
