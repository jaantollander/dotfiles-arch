# Config Files
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

