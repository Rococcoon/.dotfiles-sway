#!/bin/bash
# Script to symlink config files
# By: LRBM

set -e  # Exit on any error

# Function to remove existing configurations
remove_existing() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing $target..."
        rm -rf "$target"
    fi
}

# Remove existing configurations
remove_existing ~/.bashrc
remove_existing ~/.config/alacritty
remove_existing ~/.config/sway
remove_existing ~/.config/tmux
remove_existing ~/.config/zellij
remove_existing ~/.vimrc

# Configuration Files Symlinking

# Alacritty
ln -sf ~/.dotfiles-sway/configs/alacritty ~/.config/
echo "Old Alacritty configs removed and symlink created."

# bash
ln -sf ~/.dotfiles-sway/configs/bash/.bashrc ~/.bashrc
echo "Old .bashrc removed and symlink created."

# Sway
ln -sf ~/.dotfiles-sway/configs/sway ~/.config/
echo "Old tmux.conf removed and symlink created."

# Tmux
ln -sf ~/.dotfiles-sway/configs/tmux ~/.config/
echo "Old tmux.conf removed and symlink created."

# Vim
ln -sf ~/.dotfiles-sway/configs/vim/.vimrc ~/.vimrc
echo "Old vim configs removed and symlink created."

# Zellij
ln -sf ~/.dotfiles-sway/configs/zellij ~/.config/
echo "Old zellij configs removed and symlink created."

echo "All configuration files symlinked and plugins installed successfully."
