# Dotfiles
![](./images/desktop.png)


## About
My installation and configuration scripts and files for [Arch Linux](https://archlinux.org/). They are largely influenced by [Matthieu Cneude](https://github.com/Phantas0s) and his book [Building your Mouseless Development Environment](https://themouseless.dev/). If you are interested in building similar configuration, I recommend to read his book first!


## Philosophy
My configuration philosophy is to strive for simple, effective and ergonomic configuration by avoiding skeuomorphic design and accepting that such configuration requires effort to learn. Here are the main principles:

- **Keyboard over Mouse**: We should be able to use our configuration effectively without leaving the keyboard.

- **CLIs over GUIs**: CLIs are simpler, more composable and more effective than GUIs for most tasks.

- **Search over Navigation**: We should use search whenever possible instead of having to navigate through menus.

- **Text over Binary**: We should use text files over binary. Text files are simple, searchable and changes to them can be managed using version control.

- **Modular Configuration**: Modularity makes it easier to change components and reason about dependencies.

- **Security is Essential**: Your data could get lost, be stolen or hacked unless you protect it with encryption.

- **Automate Repetitive Tasks**: We should automate repetitive tasks by creating custom scripts which can be linked to a single location making them available throughout the system similar to built-in commands.


## Arch Linux Setup
List of the Arch Linux setup, configured with VIM like [**key bindings**](./key-bindings.md) and minimalistic, dark [**style**](./style.md).

Font: *Inconsolata* [*Nerd Font*](https://www.nerdfonts.com/) 

Desktop:

- Window system: [*X11*](https://www.x.org/)
- Tiling window manager: [*i3*](https://i3wm.org/)
- Application launcher: [*Rofi*](https://github.com/davatorium/rofi)
- Notifications: [*Dunst*](https://dunst-project.org/)
- Audio: *PulseAudio*
- Backlights: [*brightnessctl*](https://github.com/Hummer12007/brightnessctl)
- Bluetooth: [*bluez*](http://www.bluez.org/)
- Screenshot: [*maim*](https://github.com/naelstrof/maim)

Terminal:

- Emulator: [*rxvt-unicode*](https://wiki.archlinux.org/title/rxvt-unicode) with [*resize-font*](https://github.com/simmel/urxvt-resize-font) plugin
- Multiplexer: [*tmux*](https://github.com/tmux/tmux)
- Shell: [*Zsh*](https://wiki.archlinux.org/title/zsh)
- Editor: [*Neovim*](https://neovim.io/)
- Fuzzy finder: [*fzf*](https://github.com/junegunn/fzf)
- Improved ls: [*lsd*](https://github.com/Peltoche/lsd)

Document viewer: [*Zathura*](https://pwmt.org/projects/zathura/)


## Hardware Setup
List of the hardware I am using with my setup.

- Laptop: *Lenovo Thinkpad T480s*
- Keyboard: [*Kinesis Advantage 2*](https://kinesis-ergo.com/keyboards/advantage2-keyboard/)
- Mouse: *Razer DeathAdder Elite*


## Arch Linux Installation Scripts
You can read my instructions for installing Arch Linux in the [`arch`](./arch) directory. It includes instructions with and without encryption and the post installation steps.


## Configuration Files
### Structure
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

### System Startup
It is useful to understand the execution order of configuration files on system startup. Here is a summary:

1) First, we boot the computer and login, which starts the login shell. We have set it to `zsh`. 

2) Starting zsh first sets environment variables from [`zshenv`](./zsh/config/zshenv) file. 

3) Then, it executes the [`zprofile`](./zsh/config/zprofile) file, which contains code to run `xinit` via `startx` to start X11. 

4) The `startx` command runs programs configured in [`xinitrc`](./X11/config/xinitrc) such as setting key maps and starting background processes and daemons. 

5) Finally, the last command in `xinitrc` starts `i3` window manager with i3's [`config`](./i3/config/config).

### Style
Check out [**style**](./style.md) section for explanation of style configurations.

### Key Bindings
Check out [**key bindings**](./key-bindings.md) section for key binding configurations.


## Resources
Here is a list of some useful resources for developing dotfiles.

- *Matthieu Cneude* also has great [articles](https://thevaluable.dev/) on his website and his [dotfiles](https://github.com/Phantas0s/.dotfiles) are also useful. 

- An excellent [Bash scripting cheatsheet](https://devhints.io/bash) from *devhints*.

- [Efficient UEFI Encrypted Root and Swap Arch Linux Installation Procedure with an Encrypted Boot](https://gist.github.com/HardenedArray/ee3041c04165926fca02deca675effe1) by *HardenedArray*

- *Maxim Baz* has [dotfiles](https://github.com/maximbaz/dotfiles) for Arch Linux with Wayland, Kitty and Kakoune.
