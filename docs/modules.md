# Modules 
In this repository, we structure the configuration files into modules. Each module contains the configuration and data files and scripts for installing the packages and configurations of one or more programs or for a collection of other modules.

```text
<module>
├── config
│   └── <user-config-files>
├── etc
│   └── <system-wide-config-files>
├── data 
│   └── <user-data-files>
├── packages
│   ├── aur
│   └── official
├── config.sh
├── etc.sh
└── dependencies
```

Configurations for each program are located in the `<module>` directory. The module name can be anything. However, we should prefer a name that describes the module's contents, such as the program name.

- The `config/` directory contains user-specific configuration files.

- The `data/` directory contains the user-specific data files.

- The `etc/` directory contains the system-wide configurations.

- The `packages/` directory contains the lists of required packages.

  1) The `packages/official` file contains a newline-separated list of official packages.
  2) The `packages/aur` file contains a newline-separated list of packages from the Arch User Repository (AUR).

- The `dependencies` contain a newline-separated list of modules that the current module depends on.

- The `config.sh` script created the user-specific configurations.

- The `etc.sh` script creates the system-wide configurations.

- We can define other configuration files and scripts for modules if need to.

Configuration scripts create appropriate directories for the configurations and link or copy configuration files to these locations.
