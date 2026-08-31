# === OMZSH CORE ===
export ZSH="$HOME/.oh-my-zsh"

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

ZSH_THEME="powerlevel10k/powerlevel10k"  # use p10k

plugins=(
  git          # aliases + branch completion
  fzf          # Ctrl+R, Ctrl+T fuzzy search
  zsh-autosuggestions  # ghost text
  zsh-syntax-highlighting  # red/green commands
)

source $ZSH/oh-my-zsh.sh
# === END OMZSH CORE ===

# === AUTOMATIC FETCH ===
autoload -Uz add-zsh-hook
_shell_auto_reload() {
  if [ -d ~/.shell/.git ]; then
    git -C ~/.shell pull --ff-only --quiet 2>/dev/null
    # if HEAD changed, reload
    if [ "$(git -C ~/.shell rev-parse HEAD)" != "$_SHELL_HEAD" ]; then
      _SHELL_HEAD=$(git -C ~/.shell rev-parse HEAD)
      source ~/.zshrc
    fi
  fi
}
_SHELL_HEAD=$(git -C ~/.shell rev-parse HEAD 2>/dev/null)
add-zsh-hook precmd _shell_auto_reload

# === YOUR SHARED CONFIG, UNTOUCHED ===
if [ -f ~/.shell/common ]; then
  source ~/.shell/common
fi

if [[ "$TERM" != "linux" ]]; then
  # === ZSH-ONLY STUFF ===
  source ~/.p10k.zsh   # p10k config. Must be AFTER oh-my-zsh.sh
fi

# === RUN LAST ===
[[ $- == *i* ]] && fastfetch
