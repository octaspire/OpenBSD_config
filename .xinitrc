xset -b                                   # Disable bell
xsetroot -solid black &

setxkbmap -option ""                   \  # Clear existing options
          -option "caps:none"          \  # Make CapsLock into Ctrl
          -option "caps:ctrl_modifier" \  # ...
          -option "lv3:none"           \  # Make AltGr into Alt
          -option "lv3:lalt_modifier"     # ...

exec cwm                                  # Start window manager

