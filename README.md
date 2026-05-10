<p align="center"> <strong>NEOVIM</strong>  </p>

<p align="center">
<strong>My Neovim setup, based on NvChad but with my own tweaks and optimizations.</strong>  </p>

![NVIM](https://raw.githubusercontent.com/harilvfs/assets/refs/heads/main/nvim/nvim.png)

## Features

- **NvChad Base**: A modern, fast Neovim setup using Lua for a smooth experience.
- **Custom Tweaks**: Personalized keybindings, plugins, and UI changes to match my workflow.
- **Performance-Driven**: A minimalist setup that keeps things speedy and efficient.

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
├── init.lua
├── lua
│   ├── chadrc.lua
│   ├── configs
│   │   ├── conform.lua
│   │   ├── lazy.lua
│   │   ├── lspconfig.lua
│   │   └── null-ls.lua
│   ├── mappings.lua
│   ├── options.lua
│   └── plugins
│       └── init.lua
```

