# Dotfiles
![](./images/desktop.png)


## About
My installation and configuration scripts and files for [Arch Linux](https://archlinux.org/). They are largely influenced by [Matthieu Cneude](https://github.com/Phantas0s) and his book [Building your Mouseless Development Environment](https://themouseless.dev/).


## Arch Linux Setup
List of the Arch Linux setup, configured with VIM like [**key bindings**](./keybindings.md).

- Font: [*Inconsolata Nerd Font*](https://www.nerdfonts.com/)
- Desktop: 
    - Window system: [*X11*](https://www.x.org/)
    - Tiling window manager: [*i3*](https://i3wm.org/)
    - Application launcher: [*Rofi*](https://github.com/davatorium/rofi)
    - Notifications: [*Dunst*](https://dunst-project.org/)
    - Audio: *PulseAudio*
    - Backlights: *brightnessctl*
    - Bluetooth: *bluez*
- Terminal:
    - Emulator: [*rxvt-unicode*](https://wiki.archlinux.org/title/rxvt-unicode) with [resize-font](https://github.com/simmel/urxvt-resize-font) plugin
    - Multiplexer: [*tmux*](https://github.com/tmux/tmux)
- Shell: [*Zsh*](https://wiki.archlinux.org/title/zsh)
- Editor: [*Neovim*](https://neovim.io/)
- Fuzzy finder: [*fzf*](https://github.com/junegunn/fzf)
- Document viewer: *Zathura*
- Screen capture:
    - Screenshot: *scrot*


## Hardware
List of the hardware I am using with my setup.

- Laptop: *Lenovo Thinkpad T480s*
- Keyboard: [*Kinesis Advantage 2*](https://kinesis-ergo.com/keyboards/advantage2-keyboard/)
- Mouse: *Razer DeathAdder Elite*


## System Startup
It is useful to understand the execution order of configuration files on system startup. Here is a summary:

1) First, we boot the computer and login, which starts the login shell. We have set it to `zsh`. 
2) Starting zsh first sets environment variables from [`zshenv`](./zsh/config/zshenv) file. 
3) Then, it executes the [`zprofile`](./zsh/config/zprofile) file, which contains code to run `xinit` via `startx` to start X11. 
4) The `startx` command runs programs configured in [`xinitrc`](./X11/config/xinitrc) such as setting key maps and starting background processes and daemons. 
5) Finally, the last command in `xinitrc` starts `i3` window manager with i3's [`config`](./i3/config/config).


## Configuration Files
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


## Arch Linux Installation Scripts
I have also included my [**Arch Linux installation scripts**](./arch) in this repository.

