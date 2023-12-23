# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add to PATH
export PATH=/home/emerson/.cargo/bin:$PATH
export PATH=/home/emerson/.local/bin:$PATH

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "romkatv/powerlevel10k"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"

# Source at start
eval $(keychain --eval --quiet id_ed25519 ~/.ssh/id_ed25519)
source $HOME/.keychain/$HOST-sh
eval "$(zoxide init zsh)"
source /usr/share/nvm/init-nvm.sh

# Aliases
alias -g cat="bat"
alias -g pup="sudo pacman -Syu && paru -Sua && paru -c && paru -Sc"
alias getpath="fd -tf --exclude .git | fzf | tr -d '\n' | wl-copy"
alias -g nf="neofetch"

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


# yt() {
#     mpv --ytdl-format="bestvideo[height<=?$1]+bestaudio/best" "$2" &
# }

# Load and initialise completion system
autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
