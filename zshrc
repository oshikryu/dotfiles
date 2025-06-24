# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git kubectl direnv pyenv)

source $ZSH/oh-my-zsh.sh


# -----------------------------------------------------------------------------
# oshikryu

# helper for prompt
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '['`basename $VIRTUAL_ENV`']'
}

PROMPT='%{$fg[green]%}%m:%{$fg[cyan]%}%~%{$fg[green]%}$(virtualenv_info) %{$fg[white]%}$(vi_mode_prompt_info)$(git_prompt_info)%{$reset_color%} ∴ %{$reset_color%}'
VIRTUAL_ENV_DISABLE_PROMPT=1

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_colors%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✓"

source $ZSH/plugins/history-substring-search/history-substring-search.zsh
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#export PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$PATH:/Users/ryutaoshikiri/projects/platform-apps/bin"
export PATH="/Users/ryutaoshikiri/projects/platform-apps/bin/.binaries:$PATH"
# eval "$(pyenv init -)"
export PATH="$PATH:/usr/local/opt/privoxy/sbin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


. "$HOME/.local/bin/env"

# bun completions
[ -s "/Users/ryuta.oshikiri/.bun/_bun" ] && source "/Users/ryuta.oshikiri/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
