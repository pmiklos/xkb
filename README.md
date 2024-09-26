# Linux keyboard layouts

## Foreword

Keyboard layouts can be easily customized by using various `xkb` options.
For example, the `xps13:mac` layout can be achieved as well by running the command below:

```bash
setxkbmap -layout us \
    -option 'ctrl:rctrl_ralt' \
    -option 'caps:ctrl_modifier' \
    -option 'altwin:swap_alt_win' \
    -print | xkbcomp - $DISPLAY
```

or on Gnome:

```bash
gsettings set org.gnome.desktop.input-sources \
    xkb-options "['altwin:swap_alt_win', 'ctrl:rctrl_ralt', 'ctrl:nocaps']"
```

## Installation

Clone the repository under `~/.config/xkb`:

```bash
git clone https://github.com/pmiklos/xkb.git ~/.config/xkb
```

Run the merge script which merges the system xkb rules with the ones from this project.

```bash
~/.config/xkb/merge.sh
```

This is needed because `setxkbmap` does not recognize the `! include` stanza and so it would not be able to generate the full keyboard layout.
As a workaround the merge script merges all rules so `setxkbmap` can resolve an RMLVO (Rule, Model, Layout, Variant, Option) configuration into the correct KcCGST (Key codes, Compat, Geometry, Symbols, Types) output that can be fed to `xkbcompat`.

The merged rules are saved in a rule file called `evdev-local` which can be used as below:

```bash
setxkbmap -I $HOME/.config/xkb -rules evdev-local -print
```
```text
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete"	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+us+hu:2+us:3+inet(evdev)"	};
	xkb_geometry  { include "pc(pc104)"	};
};
```

The keymap config can be loaded using `xkbcomp` (this example just loads the default US layout)
```bash
setxkbmap -layout us -I $HOME/.config/xkb -rules evdev-local -print | xkbcomp -I$HOME/.config/xkb/ - $DISPLAY
```

NOTE: if the merged file was called `evdev`, `setxkbmap` would resolve it from `/usr/share/X11/rules/evdev` and ignored the local config. Apparently, `setxkbmap` tries to resolve rule files from `./rules` first then `/usr/share/X11/rules` and only if the rule file was not found in those folders will it try the folder passed in the `-I` argument. At least, it works like that on Ubuntu 24.04.

## Apple Magic Keyboard for Dell XPS13 (`xps13:mac`)

This is implemented as an xkb option so it can extends various layouts. The option name is `xps13:mac`.

Modfier keys on XPS13 US keyboard:
```monospace
┌────┬────┬─────┬─────┬─────────────┬─────┬────┐
│Ctrl│ Fn │ Win │ Alt │    Space    │ Alt │Ctrl│
└────┴────┴─────┴─────┴─────────────┴─────┴────┘
```

Modifier keys on Apple Magic Keyboard:
```monospace
┌────┬────┬─────┬─────┬─────────────┬─────┬────┐
│ Fn │Ctrl│ Opt │ Cmd │    Space    │ Cmd │ Opt│
└────┴────┴─────┴─────┴─────────────┴─────┴────┘
```

The Option keys translate to Alt, the Command keys translate to Meta. For my use case, Switching up Fn an Ctrl was not important, I also did not change the Win key.

The resulting keys with `xps13:mac` option is:

```monospace
┌────┬────┬─────┬─────┬─────────────┬─────┬────┐
│Ctrl│ Fn │ Win │ Cmd │    Space    │ Cmd │ Opt│
└────┴────┴─────┴─────┴─────────────┴─────┴────┘
```

Activating these modifiers on top of the US keyboard layout can be done as below:
```bash
setxkbmap -layout us -option 'xps13:mac' -I $HOME/.config/xkb -rules evdev-local -print | xkbcomp -I$HOME/.config/xkb/ - $DISPLAY
```

