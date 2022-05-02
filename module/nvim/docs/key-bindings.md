We define key bindings for neovim in [`init.vim`](../nvim/config/init.vim).

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
