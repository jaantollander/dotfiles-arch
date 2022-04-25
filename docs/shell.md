## Shell
It is useful to understand the execution order of configuration files for the login shell. After booting the computer we arrive to the login menu. By logging in, we start the login shell, `zsh` in our case.

Setup similar to xsh standard.

First, the login shell sets the environment variables.

- `/etc/zsh/zshenv` : system-wide env for zsh
- `@env.sh` : user-specific env for all posix shells
- `@env.zsh` (linked to `$ZDOTDIR.zshenv`) : user-specific env for zsh

Next, the login shell runs the login shell scripts.

- `/etc/profile`
  - `/etc/profile.d/*.sh`
- `/etc/zsh/zprofile`
- `@login.sh`
  - `startx` -> `xinit`
    - `/etc/X11/xinitrc`
      - `/etc/X11/xinitrc.d/*.sh`
    - `.xinitrc` (`xinitrc.sh`)
      - `exec i3` -> `i3`'s `config`
- `@login.zsh` (linked to `$ZDOTDIR.zprofile`)

Finally, when we run the the shell interactively, it executes the script for interactive shell.

- `/etc/zsh/zshrc/`
- `@interactive.sh`
- `@interactive.zsh` (linked to `$ZDOTDIR.zshrc`)

