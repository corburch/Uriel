#!/usr/bin/env bash

# Stop executing if any individual command fails
set -e

echo "========================================"
echo " Running Module 1: Package Installation "
echo "========================================"

# Checking for MacOS
if [ "$OSTYPE" = "darwin"* ]; then
    echo "▶ Deteced MacOS environment."

    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found! Please install it first at https://brew.sh"
        exit 1
    fi

    echo "📦 Installing Vim, ZSH, and Fastfetch via Homebrew..."
    brew install vim zsh fastfetch

# Check for Linux Environments
elif [ "$(uname)" = "Linux" ]; then
    echo "▶ Detected Linux environment."

    if [ -f /etc/arch-release ]; then
        echo "📦 Distribution: Arch Linux. Using Pacman..."
        sudo pacman -S --noconfirm vim zsh fastfetch

    elif [ -f /etc/fedora-release ] || grep -q "fedora" /etc/os-release 2>/dev/null; then
        echo "📦 Distribution: Fedora. Using DNF..."
        sudo dnf install -y vim zsh fastfetch

    elif [ -f /etc/debain_version ] || grep -q "debian\|ubuntu" /etc/os-release 2>/dev/null; then
        echo "📦 Distribution: Debian/Ubuntu. Using APT..."
        sudo apt-get update
        sudo apt-get install -y vim zsh fastfetch

    else
        echo "⚠️ Unknown Linux distribution. Skipping automatic package installation."
    fi

else
    echo "❌ Unsupported Operating System layout."
    exit 1
fi

echo "✅ Module 1 Complete: All foundational packages verified!"
