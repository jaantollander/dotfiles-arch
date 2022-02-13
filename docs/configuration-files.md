# Configuration Files
## Structure
I aim to structure the configuration files into modules. Each program contains its configuration and data files, and (indempotent) scripts for installing the packages and configuring the program as below.

```text
<program>
├── config
│   └── <config-files> 
├── data 
│   └── <data-files> 
├── config.sh
└── packages.sh
```

Configurations for each program are located in `<program>` directory, named after the program, such as `nvim` for Neovim. 

- The `config` (optional) subdirectory contains the config files.

- The `data` (optional) subdirectory contains the data files. 

- The `config.sh` script, which creates configuration and data directories and copies or links the configuration and data files to their appropriate locations such as `$HOME` or `$XDG_CONFIG_HOME` for configuration files or `$XDG_DATA_HOME` for data files.

- The `packages.sh` script installs the required packages for the program with `pacman` or `yay`.


## System Startup
It is useful to understand the execution order of configuration files on system startup. Here is a summary:

1) First, we boot the computer and login, which starts the login shell. We have set it to `zsh`. 

2) Starting zsh first sets environment variables from [`zshenv`](../zsh/config/zshenv) file. 

3) Then, it executes the [`zprofile`](../zsh/config/zprofile) file, which contains code to run `xinit` via `startx` to start X11. 

4) The `startx` command runs programs configured in [`xinitrc`](../X11/config/xinitrc) such as setting key maps and starting background processes and daemons. 

5) Finally, the last command in `xinitrc` starts `i3` window manager with i3's [`config`](../i3/config/config).

