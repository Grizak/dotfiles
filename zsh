if [ -f ~/.shell/common ]; then
    source ~/.shell/common
fi

# Enable colors in terminal
autoload -U colors && colors

setopt histignorealldups sharehistory
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Git status for prompt
git_prompt() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    local git_status
    git_status=$(git status --porcelain 2>/dev/null)
    local state
    if [[ -z "$git_status" ]]; then
        state="%F{green}✓%f"
    elif echo "$git_status" | grep -q "^??"; then
        state="%F{yellow}?%f"
    elif echo "$git_status" | grep -q "^[MADRCU]"; then
        state="%F{red}✗%f"
    else
        state="%F{yellow}~%f"
    fi
    echo " %F{245}on%f %F{141} $branch%f $state"
}

# Prompt
setopt PROMPT_SUBST
PROMPT='%F{245}%D{%H:%M:%S}%f  %F{110}%~%f$(git_prompt)
%(?.%F{green}❯%f.%F{red}❯%f) '
