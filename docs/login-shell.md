## Login Shell
It is useful to understand the execution order of configuration files for the login shell. After booting the computer we arrive to the login menu. By logging in, we start the login shell, `zsh` in our case.

- `/etc/zsh/zshenv`
- `$ZDOTDIR.zshenv` (`@env.zsh`)
  - `@env.sh`
- `/etc/profile`
  - `/etc/profile.d/*.sh`
- `/etc/zsh/zprofile`
- `@login.sh`
  - `startx` -> `xinit`
    - `/etc/X11/xinitrc`
      - `/etc/X11/xinitrc.d/*.sh`
    - `.xinitrc` (`xinitrc.sh`)
      - `exec i3` -> `i3`'s `config`
- `$ZDOTDIR.zprofile` (`@login.zsh`)
- `/etc/zsh/zshrc/
- `@interactive.sh`
- `$ZDOTDIR.zshrc` (`@interactive.zsh`)

---

- Starting zsh first sets environment variables from [`zshenv`](../zsh/config/zshenv) file. 

- Then, it executes the [`zprofile`](../zsh/config/zprofile) file, which contains code to run `xinit` via `startx` to start X11. 

- The `startx` command runs programs configured in [`xinitrc`](../X11/config/xinitrc) such as setting key maps and starting background processes and daemons. 

- Finally, the last command in `xinitrc` starts `i3` window manager with i3's [`config`](../i3/config/config).

