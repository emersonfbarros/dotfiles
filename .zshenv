#Enverironment variables
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATAFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export XDG_CURRENT_DESKTOP=hyprland
export XDG_SESSION_DESKTOP=hyprland
export MOZ_ENABLE_WAYLAND=1

# Default Apps
export EDITOR=nvim
export READER=zathura
export VISUAL=nvim
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
