#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo not found"
  exit 1
fi

echo "[1/7] Updating package list..."
paru -Sy

echo "[2/7] Installing zsh and basic tools..."
paru -S --noconfirm --needed zsh git curl fzf

echo "[3/7] Installing zsh plugins..."
paru -S --noconfirm --needed zsh-autosuggestions zsh-syntax-highlighting

echo "[4/7] Installing fzf-tab..."
if [ ! -d "$HOME/.fzf-tab" ]; then
  git clone --depth 1 https://github.com/Aloxaf/fzf-tab "$HOME/.fzf-tab"
fi

echo "[5/7] Setting zsh as default shell..."
ZSH_PATH="$(command -v zsh)"
if [ -n "$ZSH_PATH" ]; then
  chsh -s "$ZSH_PATH" "$USER" || true
fi

echo "[6/7] Writing .zshrc..."
cat >"$HOME/.zshrc" <<'EOF'
# ---------- Basic ----------
bindkey -e

# ---------- History ----------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# ---------- Completion ----------
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'
setopt AUTO_MENU
setopt AUTO_LIST

# ---------- fzf-tab ----------
if [ -f "$HOME/.fzf-tab/fzf-tab.plugin.zsh" ]; then
  source "$HOME/.fzf-tab/fzf-tab.plugin.zsh"
  zstyle ':fzf-tab:complete:*' fzf-pad 4
  zstyle ':fzf-tab:complete:*' fzf-flags --height=40% --reverse
fi

# ---------- History search with arrows ----------
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[[1;5A' up-line-or-beginning-search
bindkey '^[[1;5B' down-line-or-beginning-search

# ---------- fzf key bindings ----------
if command -v fzf >/dev/null 2>&1; then
  if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  elif [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
  if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
    source /usr/share/doc/fzf/examples/completion.zsh
  elif [ -f /usr/share/fzf/completion.zsh ]; then
    source /usr/share/fzf/completion.zsh
  fi
fi

# ---------- Prompt ----------
PROMPT='
%F{cyan}%~%f
%F{white}# %f'

# ---------- Plugins ----------
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
EOF

echo
