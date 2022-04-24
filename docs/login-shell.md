## Login Shell
It is useful to understand the execution order of configuration files for the login shell. Here is a summary:

1) After booting the computer we arrive to the login menu. By logging in, we start the login shell, `zsh` in our case.

2) Starting zsh first sets environment variables from [`zshenv`](../zsh/config/zshenv) file. 

3) Then, it executes the [`zprofile`](../zsh/config/zprofile) file, which contains code to run `xinit` via `startx` to start X11. 

4) The `startx` command runs programs configured in [`xinitrc`](../X11/config/xinitrc) such as setting key maps and starting background processes and daemons. 

5) Finally, the last command in `xinitrc` starts `i3` window manager with i3's [`config`](../i3/config/config).

