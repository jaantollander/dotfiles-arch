# Modules 
I aim to structure the configuration files into modules. Each module contains its configuration and data files, and (indempotent) scripts for installing the packages and configuring the program as below.

```text
<module>
├── config
│   └── <config-files> 
├── data 
│   └── <data-files> 
├── packages 
│   ├── aur
│   └── official 
├── config.sh
└── dependencies
```

Configurations for each program are located in `<module>` directory, named after the program, such as `nvim` for Neovim. 

- The `config` directory contains the config files for the module.

- The `data` directory contains the data files for the module. 

- The `packages` directory contains the lists of required official and AUR packages for the module.

- The `dependencies` contains list of other modules that current module depends on.

- The `config.sh` script, which creates configuration and data directories and copies or links the configuration and data files to their appropriate locations such as `$HOME` or `$XDG_CONFIG_HOME` for configuration files or `$XDG_DATA_HOME` for data files.

