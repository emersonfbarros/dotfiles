brightness_level=$(brightnessctl | sed -En 's/.*\(([0-9]+)%\).*/\1/p')

echo "󰃝 $brightness_level%"
