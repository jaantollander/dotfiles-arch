# Key Bindings
## X11
We define key bindings for X11 in [xinitrc](./X11/config/xinitrc).

- `Caps Lock` is remapped to `Escape`


## i3 
We define key bindings for i3 in [i3's config](./i3/config/config). Additionally, the configuration files included with the `include` directive may define key bindings.

### General

- `WIN` : Modifier key, denote as MOD
- `MOD+ENTER` : Open a new terminal
- `MOD+SHIFT+q` : Quit the focused window
- `MOD+SHIFT+c` : Reload i3's configuration
- `MOD+SHIFT+r` : Restart i3
- `MOD+BACKSPACE` : Lock, shutdown, or reboot menu
- `MOD+CTRL+SHIFT+l` : Lock the system

### Moving

- `MOD+[h,j,k,l]` : Focus window left (h), down (j), up (k), right (l)
- `MOD+SHIFT+[h,j,k,l]` : Move window
- `MOD+r` : Switch to resize mode, use h,j,k,l to resize
- `MOD+CTRL+h` : Split container horizontally
- `MOD+CTRL+v` : Split container vertically
- `MOD+<number>` : Move to workspace <number>
- `MOD+SHIFT+<number>` : Move container to workspace <number>

### Container Layout

- `MOD+e` : Switch to split layout
- `MOD+s` : Switch to stacked layout
- `MOD+w` : Switch to tabbed layout

### Manage Displays
xrandr, [i3.conf](./xrandr/config/i3.conf)

- `MOD+x` : Open the screen management menu

### Application Launcher
Rofi, [i3.conf](./rofi/config/i3.conf)

- `MOD+d` : Open the application launcher

### Audio
PulseAudio, [i3.conf](./pulse/config/i3.conf)

- `XF86AudioRaiseVolume` : Raise volume
- `XF86AudioLowerVolume` : Lower volume
- `XF86AudioMute` : Mute on/off audio
- `XF86AudioMicMute` : Mute on/off microphone

### Backlights
Brightnessctl, [i3.conf](./brightnessctl/config/i3.conf)

- `XF86MonBrightnessUp` : Increase monitor brightness
- `XF86MonBrightnessDown` : Decrease monitor brightness

### Screenshot
Maim, [i3.conf](./maim/config/i3.conf)

- `Print` : Take a screenshot


## URxvt
We define key bindings for URxvt in [xresources](./X11/config/xresources).

Copy and paste

- `CTRL+ALT+c` : Copy
- `CTRL+ALT+v` : Paste

Resize font

- `CTRL++` : Increase font size
- `CTRL+-` : Decrease font size
- `CTRL+=` : Reset font size to default
- `CTRL+?` : See current font settings


## Zsh
We define key bindings for zsh in [zshrc](./zsh/config/zshrc).

Clearing shell

- `CTRL+g` : Clear shell's output

Search with fzf 

- `CTRL+r` : Search command history
- `CTRL+t` : Search filesystem 


## Neovim
We define key bindings for neovim in [init.vim](./nvim/config/init.vim).

Basic horizontal motions

- `[h,j,k,l]` : Move cursor: left (h), down (j), up(k), right (l)
- `w` : Move to the next word
- `b` : Move backward to the previous work
- `0` : Move to the beginning of the current line
- `^` : Move to the first non-blank character on the current line
- `$` : Move to the end of the current line

Basic vertical motions

- `gg` : Move to the first line of the current buffer
- `SHIFT+g` : Move to the last line of the current buffer
- `<number> SHIFT+g` : Move at line <number>
- `%` : Move to the matching bracket if the cursor is on bracket

From NORMAL to INSERT mode and back

- `i` : Switch to INSERT mode before the character under the cursor
- `a` : Switch to INSERT mode after the character under the cursor
- `A` : Switch to INSERT mode after the end of the current line
- `o` : open a new line below the current one, and switch to INSERT mode
- `O` : Open a new line above the current one, and switch to INSERT mode
- `ESC` : Switch back to NORMAL mode

Scrolling

- `CTRL+u` : Move half a screen upward
- `CTRL+d` : Move half a screen downward

Undo and redo

- `u` : Undo
- `CTRL+r` : Redo

Operators (followed with a motion)

- `d` : Delete
- `c` : Change
- `y` : Yank (copy)

Text objects

- `diw` : Delete inside word
- `ciw` : Change inside word
- `caw` : Change a word
- `ci'` : change inside '

Creating and navigating windows

- `CTRL+[h,j,k,l]` : Navigate windows
- `CTRL+w v` : Split vertically the current window
- `CTRL+w h` : Split horizontally the current window
- `CTRL+w n` : Split horizontally the current window, and open a new buffer
- `CTRL+w ^` : Split the current window with the alternate buffer

Resizing and moving windows

- `CTRL+W r` : Rotate the windows
- `CTRL+W x` : Exchange the focused window with the next window
- `CTRL+W [-,+]` : Decrease (-) or increase (+) window's height
- `CTRL+W [<,>]` : Decrease (<) or increase (>) window's width
- `CTRL+W =` : Resize windows equally for them to fit screen

Writing buffers and closing windows

- `:w` : Write the current buffer into the file
- `:q` : Quit the current window, close Neovim if there is no more window open
- `:q!` : Quit the current window, and ignore the buffer's modifications
- `:qa` : Quit all the windows
- `:wqa` : Quit and write all the windows


## tmux
We define key bindings for tmux in [tmux.conf](./tmux/config/tmux.conf).

General

- `CTRL+SPACE` : Prefix key, denote as PREFIX
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


## Dunst
We define key bindings for Dunst in [`dunstrc`](./dunst/config/dunstrc).
