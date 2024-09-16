#!/bin/bash
#

XKB_SYSTEM_DIR="/usr/share/X11/xkb"
XKB_LOCAL_DIR="$HOME/.config/xkb"

rules=(
	"${XKB_SYSTEM_DIR}/rules/evdev"
	"${XKB_LOCAL_DIR}/rules/xps13"
)

cat "${rules[@]}" > "${XKB_LOCAL_DIR}/rules/evdev-local"
cat "${rules[@]/%/.lst}" > "${XKB_LOCAL_DIR}/rules/evdev-local.lst"

