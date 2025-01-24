#!/bin/bash

BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

echo -e "${BLUE}Setting up NvChad Neovim configuration with tweaks...${RESET}"

detect_package_manager() {
  if command -v apt &> /dev/null; then
    echo "apt"
  elif command -v dnf &> /dev/null; then
    echo "dnf"
  elif command -v zypper &> /dev/null; then
    echo "zypper"
  elif command -v pacman &> /dev/null; then
    echo "pacman"
  else
    echo "none"
  fi
}

install_if_missing() {
  local package=$1
  local package_manager=$2

  if ! command -v "$package" &> /dev/null; then
    echo -e "${RED}$package is not installed. Installing...${RESET}"
    case "$package_manager" in
      apt)
        sudo apt update && sudo apt install -y "$package"
        ;;
      dnf)
        sudo dnf install -y "$package"
        ;;
      zypper)
        sudo zypper install -y "$package"
        ;;
      pacman)
        sudo pacman -S "$package" --noconfirm
        ;;
      *)
        echo -e "${RED}No supported package manager found. Please install $package manually.${RESET}"
        exit 1
        ;;
    esac
  else
    echo -e "${GREEN}$package is already installed.${RESET}"
  fi
}

PACKAGE_MANAGER=$(detect_package_manager)
if [ "$PACKAGE_MANAGER" = "none" ]; then
  echo -e "${RED}No supported package manager found on this system. Exiting...${RESET}"
  exit 1
fi

echo -e "\n${BLUE}:: Checking required dependencies...${RESET}"
install_if_missing "neovim" "$PACKAGE_MANAGER"
install_if_missing "vim" "$PACKAGE_MANAGER"

CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/Documents/nvim-backup-$(date +%Y%m%d%H%M%S)"
if [ -d "$CONFIG_DIR" ]; then
  echo -e "${YELLOW}:: Existing Neovim configuration detected.${RESET}"
  echo ":: Backing up old configuration to $BACKUP_DIR..."
  mv "$CONFIG_DIR" "$BACKUP_DIR"
else
  echo -e "${GREEN}No existing Neovim configuration found.${RESET}"
fi

echo -e "\n${BLUE}:: Cloning NvChad Neovim configuration repository...${RESET}"
REPO_URL="https://github.com/harilvfs/chadnvim"
CLONE_DIR="$HOME/chadnvim"
if [ -d "$CLONE_DIR" ]; then
  echo -e "${YELLOW}:: Cleaning up old clone directory...${RESET}"
  rm -rf "$CLONE_DIR"
fi

git clone "$REPO_URL" "$CLONE_DIR" || {
  echo -e "${RED}Failed to clone the repository. Exiting...${RESET}"
  exit 1
}

echo -e "\n${BLUE}:: Applying Neovim configuration...${RESET}"
if [ -d "$CLONE_DIR/nvim" ]; then
  cp -r "$CLONE_DIR/nvim" "$HOME/.config"
else
  echo -e "${RED}Error: The cloned repository does not contain an 'nvim' folder.${RESET}"
  exit 1
fi

echo -e "\n${GREEN}Neovim configuration applied successfully! Enjoy!${RESET}"
