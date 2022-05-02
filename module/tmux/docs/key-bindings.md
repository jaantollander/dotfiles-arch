We define key bindings for tmux in [`config/tmux.conf`](../config/tmux.conf).

General

- `CTRL+SPACE` : Prefix key, denote as `PREFIX`
- `PREFIX r`

Panes

- `CTRL+[h,j,k,l]` : Navigate panes
- `PREFIX h` : Split window horizontally
- `PREFIX v` : Split window vertically
- `PREFIX ALT+<arrow key>` : Resize panes

Windows

- `PREFIX w` : Create a new window
- `PREXIX n` : Rename the current window
- `ALT+[k,j]` : Go to next window (k) or previous window (j)

Copy mode

- `PREFIX [` : Enter copy mode
- `CTRL+c` : Exit copy mode
- `[h,j,k,l]` : Navigate the shell in copy mode
- `CTRL+[u,d]` : Move half a page up (u) or down (d)
- `/` : Search
- `v` : Selection
- `y` : Copy selection

Plugins general

- `PREFIX SHIFT+i` : Install the pluging declared in tmux.conf

Plugin: copycat

- `PREFIX /` : Regex search
- `PREFIX CTRL+g` : Select files from Git status output 
- `PREFIX CTRL+u` : Select URLs from shell output
- `PREFIX CTRL+i` : Select IPs from shell output

Plugin: extrakto

- `PREFIX TAB` : Select and copy output with fzf
