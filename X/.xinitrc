#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# removes variable content so as to have tmux running in term emulators too
# otherwise $TMUX affects the whole X session
unset TMUX

xsetroot -cursor_name left_ptr # sets cursor to pointer (not cross)
xscreensaver -no-splash &  # starts xscreensaver daemon
feh --bg-scale ~/Pictures/backgrounds/theredtower.jpg # sets "desktop" bg
urxvtd -q -f -o  # starts rxvt-unicode daemon
exec xmonad
