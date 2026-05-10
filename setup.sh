#!/usr/bin/env bash

BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m"

msg()  { printf "%b:: %s%b\n" "$1" "$2" "$NC"; }

detect_pkg_manager() {
    for pm in apt dnf zypper pacman; do
        command -v "$pm" &>/dev/null && echo "$pm" && return
    done
    echo "none"
}

install_if_missing() {
    local pkg="$1" pm="$2"
    command -v "$pkg" &>/dev/null && { msg "$GREEN" "$pkg is already installed."; return; }
    msg "$RED" "$pkg not found. Installing..."
    case "$pm" in
        apt)    sudo apt update && sudo apt install -y "$pkg" ;;
        dnf)    sudo dnf install -y "$pkg" ;;
        zypper) sudo zypper install -y "$pkg" ;;
        pacman) sudo pacman -S --noconfirm "$pkg" ;;
        *)      msg "$RED" "No supported package manager. Install $pkg manually."; exit 1 ;;
    esac
}

PM=$(detect_pkg_manager)
[ "$PM" = "none" ] && { msg "$RED" "No supported package manager found. Exiting."; exit 1; }

msg "$BLUE" "Checking dependencies..."
install_if_missing "nvim" "$PM"
install_if_missing "git"    "$PM"

CONFIG_DIR="$HOME/.config/nvim"
if [ -d "$CONFIG_DIR" ]; then
    BACKUP="$HOME/Documents/nvim-backup-$(date +%Y%m%d%H%M%S)"
    msg "$YELLOW" "Backing up existing config to $BACKUP"
    mv "$CONFIG_DIR" "$BACKUP"
fi

msg "$BLUE" "Cloning chadnvim..."
CLONE_DIR=$(mktemp -d)
git clone https://github.com/harilvfs/chadnvim "$CLONE_DIR" || {
    msg "$RED" "Failed to clone repository. Exiting."
    exit 1
}

[ ! -d "$CLONE_DIR/nvim" ] && { msg "$RED" "No 'nvim' folder found in repo. Exiting."; exit 1; }

cp -r "$CLONE_DIR/nvim" "$HOME/.config/"
rm -rf "$CLONE_DIR"

msg "$GREEN" "NvChad configuration done!"
