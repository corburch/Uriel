#!/usr/bin/env bash

# Stop executing if any individual command fails
set -e

echo "      __   __  ______    ___   _______  ___     " 
echo "     |  | |  ||    _ |  |   | |       ||   |    "
echo "     |  | |  ||   | ||  |   | |    ___||   |    "
echo "     |  |_|  ||   |_||_ |   | |   |___ |   |    "
echo "     |       ||    __  ||   | |    ___||   |___ "
echo "     |       ||   |  | ||   | |   |___ |       |"
echo "     |_______||___|  |_||___| |_______||_______|"
echo ""
echo ""


echo "Running Module 1: Package Installation"

# Checking for MacOS
if [[ "$OSTYPE" = "darwin"* ]]; then
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

    elif [ -f /etc/debian_version ] || grep -q "debian\|ubuntu" /etc/os-release 2>/dev/null; then
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
echo "Running Module 2: Frameworks & Themes"

# Define target installation paths
OMZ_DIR="$HOME/.oh-my-zsh"
P10K_DIR="$OMZ_DIR/custom/themes/powerlevel10k"
VIM_THEME_DIR="$HOME/.vim/pack/themes/start/tokyonight"

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





echo ""
echo "Running Module 3: Font Asset Automator"

# Define where are fonts are stored
REPO_FONTS_DIR="$(dirname "$0")/assets/fonts"

# Check if the repo folder exists and actually contains files
if [ -d "$REPO_FONTS_DIR" ] && [ "$(ls -A "$REPO_FONTS_DIR" 2>/dev/null)" ]; then

    # MacOS Font Deployment
    if [[ "$OSTYPE" == "darwin"* ]]; then
        TARGET_FONT_DIR="$HOME/Library/Fonts"
        echo "📥 Copying custom fonts to macOS User Font Library..."

        mkdir -p "$TARGET_FONT_DIR/"
        cp "$REPO_FONTS_DIR"/* "$TARGET_FONT_DIR/"

        echo "✅ Fonts copied to macOS directory."
    
    elif [ "$(uname)" = "Linux" ]; then
        TARGET_FONT_DIR="$HOME/.local/share/fonts"
        echo "📥 Copying custom fonts to Linux user font directory..."
        
        mkdir -p "$TARGET_FONT_DIR"
        cp "$REPO_FONTS_DIR"/* "$TARGET_FONT_DIR/"
        
        # Ensure the operating system has absolute clearance to read the files
        echo "🔒 Adjusting font file permissions (chmod 644)..."
        chmod 644 "$TARGET_FONT_DIR"/*
        
        # Force Linux to rebuild its active font database cache
        echo "🔄 Refreshing system font cache..."
        fc-cache -f
        echo "✅ Fonts deployed and cache refreshed."
    fi

else
    echo "ℹ️ No custom fonts found in assets/fonts/. Skipping font installation."
fi

echo "✅ Module 3 Complete: Fonts are deployed!"






echo ""
echo "Running Module 4: Symlink Deployment"

# Define base directories
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_TARGET="$HOME/.config"
THEME_TARGET="$CONFIG_TARGET/themes/tokyonight"

echo "🔗 Creating system portals via symbolic links..."

# Ensure the system ~/.config directory exists
mkdir -p "$CONFIG_TARGET"
mkdir -p "$CONFIG_TARGET/themes"

# Automate Global Tokyo Night Asset Download
if [ ! -d "$THEME_TARGET" ]; then
    echo "📥 Tokyo Night asset repository not found. Downloading palette database..."
    git clone --depth=1 https://github.com/folke/tokyonight.nvim.git "$THEME_TARGET"
    echo "✅ Tokyo Night assets stored at $THEME_TARGET"
else
    echo "ℹ️ Tokyo Night assets already present. Skipping download."
fi

# Helper Function to Safley Link Files
link_file() {
    local source_file="$1"
    local target_file="$2"

    # If a real file already exists and is NOT a symlink, back it up
    if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "⚠️  Found existing config at $target_file. Backing up to ${target_file}.bak"
        mv "$target_file" "${target_file}.bak"
    # If a broken or old symlink is already there, delete it
    elif [ -L "$target_file" ]; then
        rm "$target_file"
    fi

    # Create the parent directory for the target if it doesn't exist
    mkdir -p "$(dirname "$target_file")"

    # Create the symbolic link
    ln -s "$source_file" "$target_file"
    echo "✅ Linked: $target_file -> $source_file"
}

# Deploy Home Dotfiles
link_file "$BASE_DIR/home/.zshrc" "$HOME/.zshrc"
link_file "$BASE_DIR/home/.vimrc" "$HOME/.vimrc"

# Deploy .config Subdirectories (Fastfetch & LSD)
if [ -d "$BASE_DIR/config/fastfetch" ]; then
    link_file "$BASE_DIR/config/fastfetch/config.jsonc" "$CONFIG_TARGET/fastfetch/config.jsonc"
fi

if [ -d "$BASE_DIR/config/lsd" ]; then
    link_file "$BASE_DIR/config/lsd/config.yaml" "$CONFIG_TARGET/lsd/config.yaml"
fi

echo "✅ Module 4 Complete: All configuration profiles active!"






echo "🎉 ALL SYSTEMS CONFIGURED SUCCESSFULLY! 🎉"