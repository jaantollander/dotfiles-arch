We define key bindings [`config/i3.conf`](../config/i3.conf) file. Additionally, the configuration files included with the `include` directive may define key bindings.

General

- `WIN` : Modifier key, denote as `MOD`
- `MOD+ENTER` : Open a new terminal
- `MOD+SHIFT+q` : Quit the focused window
- `MOD+SHIFT+c` : Reload i3's configuration
- `MOD+SHIFT+r` : Restart i3
- `MOD+SHIFT+BACKSPACE` : Lock, shutdown, or reboot menu

Moving

- `MOD+[h,j,k,l]` : Focus window left (h), down (j), up (k), right (l)
- `MOD+SHIFT+[h,j,k,l]` : Move window
- `MOD+r` : Switch to resize mode, use `h,j,k,l` to resize
- `MOD+CTRL+h` : Split container horizontally
- `MOD+CTRL+v` : Split container vertically
- `MOD+<number>` : Move to workspace `<number>`
- `MOD+SHIFT+<number>` : Move container to workspace `<number>`

Container Layout

- `MOD+e` : Switch to split layout
- `MOD+s` : Switch to stacked layout
- `MOD+w` : Switch to tabbed layout
