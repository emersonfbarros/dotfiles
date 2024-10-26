# Exporting GPG_TTY
export GPG_TTY=$TTY

# Setting up SSH key
eval $(keychain --eval --agents ssh --quiet id_ed25519 ~/.ssh/id_ed25519)
source $HOME/.keychain/$HOST-sh

# Add to PATH
export PATH=~/.local/bin:$PATH
export PATH=~/go/bin:$PATH
source "$HOME/.cargo/env" # Adds cargo on path
source /usr/share/nvm/init-nvm.sh # Init nvm

# Aliases
alias -g cat="bat"
alias getpath="fd -tf --exclude .git | fzf --height 40% --reverse --border | tr -d '\n' | wl-copy"
alias cl="unset NEW_LINE_BEFORE_PROMPT && clear" # Prevents new line before clear (cl) cmd
alias ls='eza --group-directories-first --icons=always'
alias ll='ls -lh --git'
alias la='ll -a'
alias lt='ll --tree --level=2'

bindkey -v # Vi mode

# Keybindings
bindkey -s '^x' '^usource $HOME/.zshrc\n'
bindkey "^R" history-incremental-search-backward
bindkey '^H' backward-kill-word # Ctrl + Backspace to delete a whole word.
bindkey "^?" backward-delete-char
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Colors
autoload -Uz colors && colors

# Completions
autoload -Uz compinit
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
zle_highlight=('paste:none')
for dump in "${ZDOTDIR:-$HOME}/.zcompdump"(N.mh+24); do
  compinit
done
compinit -C

# Options
unsetopt BEEP
setopt AUTO_CD
setopt GLOB_DOTS
setopt NOMATCH
setopt MENU_COMPLETE
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS

# History options
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Transient prompt
setopt prompt_subst

zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT="%{$fg_bold[green]%}❯ %{$reset_color%}"
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init

precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}

# Init tools
# Fzf rose-pine theme
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
eval "$(fzf --zsh)" # Fzf integrations
eval "$(zoxide init zsh)" # Init zoxide

# Load plugins
source ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.local/share/zsh/autoseggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)" # Init starship
