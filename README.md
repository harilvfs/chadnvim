<p align="center"> <strong>NEOVIM</strong>  </p>

<p align="center">
<strong>My Neovim setup, based on NvChad but with my own tweaks and optimizations.</strong>  </p>

![NVIM](https://raw.githubusercontent.com/harilvfs/assets/refs/heads/main/nvim/nvim.png)

## Features

- **NvChad Base**: A modern, fast Neovim setup using Lua for a smooth experience.
- **Custom Tweaks**: Personalized keybindings, plugins, and UI changes to match my workflow.
- **Performance-Driven**: A minimalist setup that keeps things speedy and efficient.

> [!NOTE]  
> Ensure you download the Lua language server from your distribution's package manager.  
> Then, add the following to your `~/.zshrc` or `~/.bashrc` to include the Lua language server in your environment:  
> ```sh
> export PATH="$PATH:/path/to/lua-language-server"
> ```
> Replace `/path/to/lua-language-server/bin` with the actual path to the Lua language server's `bin` directory.

## Installation

To install my Neovim configuration, clone this repository and run the setup script:

```shell
git clone https://github.com/harilvfs/chadnvim
cd chadnvim/
chmod +x setup.sh
./setup.sh
```

Or, Simply Run This Curl Command:

```shell
curl -fsSL https://raw.githubusercontent.com/harilvfs/chadnvim/main/setup.sh | sh
```

<p align="center"> <strong>Quick overview of the Nvim Dir:</strong>  </p>

```shell
nvim
├── init.lua                    # Main entry point for Neovim configuration.
├── lazy-lock.json              # Auto-generated lock file for plugins managed by Lazy.nvim.
└── lua                         # Lua directory for modular configuration.
    ├── chadrc.lua              # User-specific settings and overrides for the configuration.
    ├── configs                 # Directory for specific plugin configurations.
    │   ├── conform.lua         # Configuration for Conform (formatting plugin).
    │   ├── lazy.lua            # Plugin manager (Lazy.nvim) configuration.
    │   ├── lspconfig.lua       # LSP (Language Server Protocol) configuration for Neovim.
    │   └── null-ls.lua         # Configuration for Null-ls (code linting/formatting integration).
    ├── mappings.lua            # Key mappings and shortcuts for Neovim.
    ├── options.lua             # General Neovim options/settings.
    └── plugins                 # Directory for plugin definitions and configurations.
        └── init.lua            # List of plugins and their initialization/configuration.
```
