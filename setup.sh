#!/bin/bash
echo -ne "

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ███████╗███████╗████████╗██╗   ██╗██████╗ 
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    ███████╗█████╗     ██║   ██║   ██║██████╔╝
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
-----------------------------------------------------------------------------------------------
                      Nvchad Neovim Setup With Some Tweaks & Improvements
-----------------------------------------------------------------------------------------------

"

install_if_missing() {
  if ! command -v "$1" &> /dev/null; then
    echo "$1 not found. Installing..."
    sudo pacman -S "$1" --noconfirm
  else
    echo "$1 is already installed."
  fi
}

# Ensure Neovim and Vim are installed
install_if_missing "nvim"
install_if_missing "vim"

# Backup existing Neovim configuration if it exists
echo -e "\033[1;33mExisting Neovim configuration detected.\033[0m"
echo "Moving old configuration to Documents..."
 cd $HOME/.config/
 mv nvim $HOME/Documents/nvim-backup-old

# Clone the Neovim configuration repository
echo -e "\033[1;34mCloning Neovim configuration repository...\033[0m"
 cd $HOME
 git clone https://github.com/aayushx402/nvim.git
 cd nvim 
 cp -r nvim "$HOME/.config"

echo -e "\033[1;32mApplying new Neovim configuration...\033[0m"
echo "Neovim configuration applied successfully!"
