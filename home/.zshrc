if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Exporting GPG_TTY
export GPG_TTY=$TTY

# Add to PATH
export PATH=~/.local/bin:$PATH
export PATH=~/go/bin:$PATH

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "romkatv/powerlevel10k"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"

# Source at start
eval "$(zoxide init zsh)"
source "$HOME/.cargo/env"
source /usr/share/nvm/init-nvm.sh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Setting up SSH and GPG keys
eval $(keychain --eval --agents ssh --quiet id_ed25519 ~/.ssh/id_ed25519)
source $HOME/.keychain/$HOST-sh

# Aliases
alias -g cat="bat"
alias getpath="fd -tf --exclude .git | fzf | tr -d '\n' | wl-copy"

# Custom functions
fcd() {
  cd "$(fd -td -H --exclude .git --exclude node_modules | fzf)"
}

open() {
  xdg-open "$(fd -tf -H --exclude .git --exclude node_modules | fzf)"
}

v() {
    local file
    file=$(
      fd -tf -H --exclude .git --exclude node_modules \
        | fzf --height 40% --reverse --border \
        # --preview 'bat --color=always --style=header,grid --line-range :500 {}'
      )
    if [ -n "$file" ]; then
        nvim "$file"
    fi
}

# Fzf theme
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# Load and initialise completion system
autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
