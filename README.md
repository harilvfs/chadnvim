<p align="center"> <strong>NEOVIM</strong>  </p>

<p align="center"> <strong>My Neovim setup, based on NvChad but with my own tweaks and optimizations.</strong>  </p>

[NVIM](https://github.com/aayushx402/images/blob/main/nvim/2024-08-24_22-26.png)

## Features

- **NvChad Base**: A modern, fast Neovim setup using Lua for a smooth experience.
- **Custom Tweaks**: Personalized keybindings, plugins, and UI changes to match my workflow.
- **Performance-Driven**: A minimalist setup that keeps things speedy and efficient.

## Installation

To install my Neovim configuration, clone this repository and run the setup script:

```shell
git clone https://github.com/aayushx402/nvim
cd nvim/
chmod +x setup.sh
./setup.sh
```

<p align="center"> <strong>Quick overview of the repository structure:</strong>  </p>

```shell
nvim-config/
├── base46/                      # Theme and color configurations
│   ├── integrations/            # Integrations with other plugins or tools
│   ├── themes/                  # Collection of theme files
│   ├── colors.lua               # Main color configuration file
│   ├── glassy.lua               # Glassy effect configurations
│   ├── init.lua                 # Initialization script for base46
│   └── term.lua                 # Terminal color settings
├── init.lua                     # Main Neovim configuration file
├── lua/                         # Lua configuration files and modules
│   ├── configs/                 # Directory for various configuration files
│   ├── conform.lua              # Configuration for formatting tools
│   ├── lazy.lua                 # Lazy loading configuration for plugins
│   ├── lspconfig.lua            # LSP configurations
│   ├── themes/                  # Additional themes and theme configurations
│   ├── chadrc.lua               # Main configuration file for NvChad customizations
│   ├── mapping.lua              # Key mappings and shortcuts
│   ├── options.lua              # General Neovim options and settings
│   ├── plugins/                 # Plugin configurations
│   └── init.lua                 # Initialization script for Lua modules
├── .stylua.toml                 # StyLua configuration file for formatting Lua code
└── lazy-lock.json               # Lock file for lazy-loaded plugins
```
