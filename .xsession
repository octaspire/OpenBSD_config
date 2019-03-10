export LC_CTYPE="en_US.UTF-8"

xset -b                                 # Disable bell
xsetroot -solid black &

setxkbmap -option ""                    # Clear existing options
setxkbmap -option "caps:none"           # Make CapsLock into Ctrl
setxkbmap -option "caps:ctrl_modifier"  # ...
setxkbmap -option "lv3:none"            # Make AltGr into Alt
setxkbmap -option "lv3:lalt_modifier"   # ...

if [ -f ~/.fehbg ]; then
    ~/.fehbg &
fi

exec cwm                                # Start window manager

