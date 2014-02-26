[ -x .xprofile ] && source .xprofile
if test `hostname -s` = ayumu
then
  setxkbmap -option compose:sclk -option ctrl:nocaps &&
  xrdb ~/.Xresources &&
  xscreensaver -no-splash &
  exec awesome
fi
