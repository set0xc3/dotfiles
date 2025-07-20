#!/bin/sh

export PATH=$HOME/.local/bin:$PATH

# --- Zinit (менеджер плагинов Zsh) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Плагины Zsh
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# Горячие клавиши history-substring-search на стрелки вверх/вниз
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# Добавляем сниппеты Oh My Zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Инициализация автозавершения
autoload -Uz compinit && compinit

# Oh My Posh (если используете для подсветки prompt)
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# Режим редактирования: emacs
bindkey -e

# Альтернативные горячие клавиши для истории
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Перемещение курсора по словам через Ctrl+h/l
bindkey '^H' backward-word
bindkey '^L' forward-word

# Основные опции истории
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory        # дозапись истории в файл
setopt sharehistory         # общий буфер истории между сессиями
setopt hist_ignore_space    # игнорировать команды с пробелом в начале
setopt hist_ignore_all_dups # игнорировать дублирующиеся записи
setopt hist_save_no_dups    # не сохранять дубли при записи в файл
setopt hist_ignore_dups     # не делать дубли в памяти
setopt hist_find_no_dups    # при поиске в истории не показывать дубли

# Стиль автодополнения
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Редактор по умолчанию
EDITOR="nvim"
VISUAL="nvim"

# Алиасы
alias l='eza --icons'
alias la='l -a'
alias lal='l -al'
alias ~='cd ~'
alias ..='cd ..'
alias v='nvim'
alias vi='v'
alias vim='v'
alias c='clear'
alias srm='gio trash'

# Интеграция с fzf в zsh
eval "$(fzf --zsh)"

# Автоматический вход в tmux-сессию "Савок" при старте терминала
if [[ -z "$TMUX" ]]; then
    if tmux has-session -t Савок 2>/dev/null; then
        tmux attach-session -t Савок
    else
        tmux new-session -s Савок
    fi
fi
