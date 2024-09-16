# Mac modifier keyboard layout for XPS13

```bash
setxkbmap -layout us -option 'xps13:mac' -I $HOME/.config/xkb -rules evdev-local -print | xkbcomp -I$HOME/.config/xkb/ - $DISPLAY
```

