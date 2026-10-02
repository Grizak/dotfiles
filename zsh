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
zmodload zsh/system

typeset -g _SHELL_FETCH_PID=""
typeset -gi _SHELL_LAST_FETCH=0
typeset -gi _SHELL_FETCH_INTERVAL=300  # 5 minutes
typeset -g _SHELL_HEAD=""

typeset -g _SHELL_FETCH_LOCK="/tmp/shell-dotfiles-fetch.lock"

_SHELL_HEAD=$(git -C ~/.shell rev-parse HEAD 2>/dev/null)

_shell_fetch_lock_active() {
  local pid

  [[ -d "$_SHELL_FETCH_LOCK" ]] || return 1

  if [[ -f "$_SHELL_FETCH_LOCK/pid" ]]; then
    read -r pid < "$_SHELL_FETCH_LOCK/pid"

    if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
      return 0
    fi
  fi

  # Stale lock
  rm -rf "$_SHELL_FETCH_LOCK"
  return 1
}

_shell_auto_reload() {
  local now=$EPOCHSECONDS

  # Did another shell update the dotfiles?
  local current_head
  current_head=$(git -C ~/.shell rev-parse HEAD 2>/dev/null)

  if [[ -n "$current_head" && "$current_head" != "$_SHELL_HEAD" ]]; then
    echo "Dotfiles updated, resourcing"
    exec "$SHELL"
    return
  fi

  # Check if this shell's background fetch has completed
  if [[ -n "$_SHELL_FETCH_PID" ]] &&
     ! kill -0 "$_SHELL_FETCH_PID" 2>/dev/null; then

    wait "$_SHELL_FETCH_PID" 2>/dev/null
    _SHELL_FETCH_PID=""

    local local_head remote_head

    local_head=$(git -C ~/.shell rev-parse HEAD 2>/dev/null)
    remote_head=$(git -C ~/.shell rev-parse '@{u}' 2>/dev/null)

    if [[ -n "$remote_head" && "$local_head" != "$remote_head" ]]; then
      if git -C ~/.shell merge --ff-only --quiet 2>/dev/null; then
        _SHELL_HEAD="$remote_head"
        echo "Remote repo updated, resourcing"
        exec "$SHELL"
      fi
    fi
  fi

  # Start a new background fetch if:
  #  - this shell isn't already fetching
  #  - enough time has elapsed
  #  - another shell isn't already fetching
  if [[ -z "$_SHELL_FETCH_PID" ]] &&
     (( now - _SHELL_LAST_FETCH >= _SHELL_FETCH_INTERVAL )); then

    _SHELL_LAST_FETCH=$now

    if ! _shell_fetch_lock_active; then
      # mkdir is atomic, so only one shell can acquire the lock
      if mkdir "$_SHELL_FETCH_LOCK" 2>/dev/null; then
        (
          # This is the actual background process PID
          echo "$sysparams[pid]" > "$_SHELL_FETCH_LOCK/pid"

          trap 'rm -rf "$_SHELL_FETCH_LOCK"' EXIT

          git -C ~/.shell fetch --quiet 2>/dev/null
        ) &!

        _SHELL_FETCH_PID=$!
      fi
    fi
  fi
}

add-zsh-hook precmd _shell_auto_reload

# === RESET CURSOR ===
add-zsh-hook precmd cr

# === SHARED CONFIG ===
if [ -f ~/.shell/common ]; then
  source ~/.shell/common
fi

if [[ "$TERM" != "linux" ]]; then
  # === ZSH-ONLY STUFF ===
  source ~/.p10k.zsh   # p10k config. Must be AFTER oh-my-zsh.sh
fi

# === RUN LAST ===
[[ $- == *i* ]] && fastfetch
