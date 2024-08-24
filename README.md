# My Neovim Configuration

This repository contains my customized Neovim setup, built on top of NvChad with my personal tweaks and optimizations.

## Features

- **NvChad Base**: A modern, fast Neovim configuration that leverages the power of Lua.
- **Personal Tweaks**: Custom keybindings, plugins, and UI enhancements tailored to my workflow.
- **Optimized for Performance**: Minimalistic setup with a focus on speed and efficiency.

## Installation

To install my Neovim configuration, clone this repository and run the setup script:

```shell
git clone https://github.com/aayushx402/nvim
cd nvim/
chmod +x setup.sh
./setup.sh
```

```shell
nvim-config/

├── base46/                       <strong> Theme and color configurations </strong> 
│   ├── integrations/             Integrations with other plugins or tools
│   ├── themes/                   Collection of theme files
│   ├── colors.lua                Main color configuration file
│   ├── glassy.lua                Glassy effect configurations
│   ├── init.lua                  Initialization script for base46
|   └── term.lua                  Terminal color settings
├── init.lua                      Main Neovim configuration file
├── lua/                          Lua configuration files and modules
│   ├── configs/                  Directory for various configuration files
│   ├── conform.lua               Configuration for formatting tools
│   ├── lazy.lua                  Lazy loading configuration for plugins
│   ├── lspconfig.lua             LSP configurations
│   ├── themes/                   Additional themes and theme configurations
│   ├── chadrc.lua                Main configuration file for NvChad customizations
│   ├── mapping.lua               Key mappings and shortcuts
│   ├── options.lua               General Neovim options and settings
│   ├── plugins/                  Plugin configurations
│   └── init.lua                  Initialization script for Lua modules
├── .stylua.toml                  StyLua configuration file for formatting Lua code
└── lazy-lock.json                Lock file for lazy-loaded plugins
```

