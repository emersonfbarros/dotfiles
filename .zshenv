# Default Apps
export EDITOR=nvim
export VISUAL=nvim
export READER=zathura
export TERMINAL=alacritty
export BROWSER=firefox
export VIDEO=mpv
export IMAGE=swayimg
export COLORTERM=truecolor
export OPENER=xdg-open
export PAGER=less
export WM=hyprland
export MANPAGER="less -R --use-color -Dd+r -Du+b"

#lf icons
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
}
