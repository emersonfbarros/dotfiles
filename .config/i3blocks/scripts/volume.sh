audio_volume=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-volume)
audio_is_muted=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-mute)

if [ "$audio_is_muted" = "true" ]
then
    audio_active='󰝟'
else
    audio_active='󰕾'
fi

echo "$audio_active $audio_volume%"
