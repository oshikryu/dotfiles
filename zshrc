# -----------------------------------------------------------------------------
# zsh core setup
# -----------------------------------------------------------------------------
autoload -U colors && colors
autoload -Uz compinit && compinit

# completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history hist_ignore_dups hist_ignore_space

# enable prompt command substitution
setopt prompt_subst

# -----------------------------------------------------------------------------
# prompt
# -----------------------------------------------------------------------------
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '['`basename $VIRTUAL_ENV`']'
}

function git_prompt_info {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    local dirty
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        dirty="%{$fg[red]%} ✗"
    else
        dirty="%{$fg[green]%} ✓"
    fi
    echo "%{$fg[yellow]%}${branch}${dirty}%{$reset_color%}"
}

PROMPT='%{$fg[green]%}%m:%{$fg[cyan]%}%~%{$fg[green]%}$(virtualenv_info) %{$fg[white]%}$(git_prompt_info)%{$reset_color%} ∴ %{$reset_color%}'
VIRTUAL_ENV_DISABLE_PROMPT=1

# -----------------------------------------------------------------------------
# plugins (native)
# -----------------------------------------------------------------------------
# direnv
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# pyenv
command -v pyenv &>/dev/null && eval "$(pyenv init -)"

# kubectl completions
command -v kubectl &>/dev/null && source <(kubectl completion zsh)

# history substring search (up/down arrow)
if [[ -f /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
elif [[ -f /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="$PATH:/usr/local/opt/privoxy/sbin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
