#Enverironment variables
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATAFORM=wayland
export XDG_SESSION_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1

# Default Apps
export EDITOR=lvim
export READER=zathura
export VISUAL=lvim
export TERMINAL=alacritty
export BROWSER=firefox
export VIDEO=mpv
export IMAGE=swayimg
export COLORTERM=truecolor
export OPENER=xdg-open
export PAGER=less
export WM=sway


#lf icons
[ -f ~/.config/lf/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/lf/LF_ICONS)" \
		&& export LF_ICONS
}
