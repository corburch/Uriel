#!/usr/bin/env bash

# Stop executing if any individual command fails
set -e

echo " Running Module 1: Package Installation "

# Checking for MacOS
if [ "$OSTYPE" = "darwin"* ]; then
    echo "▶ Deteced MacOS environment."

    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found! Please install it first at https://brew.sh"
        exit 1
    fi

    echo "📦 Installing Vim, ZSH, lsd, and Fastfetch via Homebrew..."
    brew install vim zsh fastfetch lsd

# Check for Linux Environments
elif [ "$(uname)" = "Linux" ]; then
    echo "▶ Detected Linux environment."

    if [ -f /etc/arch-release ]; then
        echo "📦 Distribution: Arch Linux. Using Pacman..."
        sudo pacman -S --noconfirm vim zsh fastfetch lsd

    elif [ -f /etc/fedora-release ] || grep -q "fedora" /etc/os-release 2>/dev/null; then
        echo "📦 Distribution: Fedora. Using DNF..."
        sudo dnf install -y vim zsh fastfetch lsd

    elif [ -f /etc/debain_version ] || grep -q "debian\|ubuntu" /etc/os-release 2>/dev/null; then
        echo "📦 Distribution: Debian/Ubuntu. Using APT..."
        sudo apt-get update
        sudo apt-get install -y vim zsh fastfetch lsd

    else
        echo "⚠️ Unknown Linux distribution. Skipping automatic package installation."
    fi

else
    echo "❌ Unsupported Operating System layout."
    exit 1
fi

echo "✅ Module 1 Complete: All foundational packages verified!"



echo ""
echo "=========================================="
echo " Running Module 2: Frameworks & Themes    "
echo "=========================================="

# Define target installation paths
OMZ_DIR="$HOME/.oh-my-zsh"
P10K_DIR="$OMZ_DIR/custom/themes/powerlevel10k"

# Automate Oh My ZSH Installation
if [ ! -d "$OMZ_DIR" ]; then
    echo "📥 Oh My ZSH not found. Downloading and installing silently..."

    # Run the official installer with automation flags injected
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

    echo "✅ Oh My ZSH installed successfully."
else
    echo "ℹ️ Oh My ZSH is already installed. Skipping download."
fi

# Automate Powerlevel10k Installation
if [ ! -d "$P10K_DIR" ]; then
    echo "📥 Powerlevel10k theme not found. Cloning repository..."

    # Clone the theme directly into the Oh My ZSH custom themes directory
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"

    echo "✅ Powerlevel10k theme downloaded successfully."
else
    echo "ℹ️ Powerlevel10k theme is already installed. Skipping download."
fi

echo "✅ Module 2 Complete: Styling frameworks are ready!"

