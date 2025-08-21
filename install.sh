#!/bin/bash

# 0x96f.nvim Installation Script
# Author: Filip Janevski
# Description: Automated installation script for 0x96f Neovim theme

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
PLUGIN_MANAGER=""
FORCE_INSTALL=false

# Helper functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

show_help() {
    cat << EOF
0x96f.nvim Installation Script

USAGE:
    ./install.sh [OPTIONS]

OPTIONS:
    -d, --dir DIR           Neovim configuration directory (default: ~/.config/nvim)
    -m, --manager MANAGER   Plugin manager (lazy, packer, plug)
    -f, --force            Force installation (overwrite existing files)
    -h, --help             Show this help message

EXAMPLES:
    ./install.sh                                    # Auto-detect setup
    ./install.sh -m lazy                           # Install for lazy.nvim
    ./install.sh -d ~/.config/nvim-custom          # Custom config directory
    ./install.sh -m packer -f                     # Force install for packer.nvim

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--dir)
            NVIM_CONFIG_DIR="$2"
            shift 2
            ;;
        -m|--manager)
            PLUGIN_MANAGER="$2"
            shift 2
            ;;
        -f|--force)
            FORCE_INSTALL=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check if Neovim is installed
check_nvim() {
    if ! command -v nvim &> /dev/null; then
        print_error "Neovim is not installed. Please install Neovim first."
        exit 1
    fi
    
    local nvim_version=$(nvim --version | head -n1 | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+')
    print_info "Found Neovim $nvim_version"
}

# Detect plugin manager
detect_plugin_manager() {
    if [[ -n "$PLUGIN_MANAGER" ]]; then
        print_info "Using specified plugin manager: $PLUGIN_MANAGER"
        return
    fi
    
    print_info "Auto-detecting plugin manager..."
    
    if [[ -f "$NVIM_CONFIG_DIR/lazy-lock.json" ]] || grep -r "lazy\.nvim" "$NVIM_CONFIG_DIR" &>/dev/null; then
        PLUGIN_MANAGER="lazy"
        print_info "Detected lazy.nvim"
    elif grep -r "packer\.nvim" "$NVIM_CONFIG_DIR" &>/dev/null; then
        PLUGIN_MANAGER="packer"
        print_info "Detected packer.nvim"
    elif grep -r "vim-plug" "$NVIM_CONFIG_DIR" &>/dev/null; then
        PLUGIN_MANAGER="plug"
        print_info "Detected vim-plug"
    else
        print_warning "Could not detect plugin manager. Please specify with -m option."
        echo "Supported managers: lazy, packer, plug"
        exit 1
    fi
}

# Create backup of existing config
create_backup() {
    local config_file="$1"
    if [[ -f "$config_file" ]] && [[ "$FORCE_INSTALL" == false ]]; then
        local backup_file="${config_file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$config_file" "$backup_file"
        print_info "Created backup: $backup_file"
    fi
}

# Generate configuration based on plugin manager
generate_config() {
    local config_snippet=""
    
    case $PLUGIN_MANAGER in
        lazy)
            config_snippet='  {
    "filipjanevski/0x96f.nvim",
    priority = 1000,
    config = function()
      require("0x96f").setup()
      vim.cmd.colorscheme("0x96f")
    end,
  },'
            ;;
        packer)
            config_snippet='  use {
    "filipjanevski/0x96f.nvim",
    config = function()
      require("0x96f").setup()
      vim.cmd.colorscheme("0x96f")
    end
  }'
            ;;
        plug)
            config_snippet="Plug 'filipjanevski/0x96f.nvim'"
            ;;
    esac
    
    echo "$config_snippet"
}

# Install theme configuration
install_theme() {
    local init_lua="$NVIM_CONFIG_DIR/init.lua"
    local lua_dir="$NVIM_CONFIG_DIR/lua"
    local plugins_dir="$lua_dir/plugins"
    
    # Ensure directories exist
    mkdir -p "$NVIM_CONFIG_DIR" "$lua_dir"
    
    # Generate configuration snippet
    local config_snippet=$(generate_config)
    
    case $PLUGIN_MANAGER in
        lazy)
            # For lazy.nvim, create or update plugins configuration
            mkdir -p "$plugins_dir"
            local plugins_file="$plugins_dir/colorscheme.lua"
            
            if [[ ! -f "$plugins_file" ]] || [[ "$FORCE_INSTALL" == true ]]; then
                create_backup "$plugins_file"
                cat > "$plugins_file" << EOF
-- Colorscheme configuration
return {
$config_snippet
}
EOF
                print_success "Created $plugins_file"
            else
                print_warning "$plugins_file already exists. Use -f to overwrite or add manually:"
                echo "$config_snippet"
            fi
            
            # Ensure lazy.nvim is set up in init.lua
            if [[ -f "$init_lua" ]] && ! grep -q "lazy\.nvim" "$init_lua"; then
                print_info "Add this to your init.lua to set up lazy.nvim:"
                cat << EOF

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins")
EOF
            fi
            ;;
            
        packer)
            if [[ -f "$init_lua" ]]; then
                create_backup "$init_lua"
                print_info "Add this to your packer configuration:"
                echo "$config_snippet"
            else
                print_info "Creating basic packer configuration in init.lua"
                cat > "$init_lua" << EOF
-- Packer configuration
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  
$config_snippet

  if packer_bootstrap then
    require('packer').sync()
  end
end)
EOF
                print_success "Created basic packer configuration"
            fi
            ;;
            
        plug)
            if [[ -f "$init_lua" ]]; then
                create_backup "$init_lua"
                print_info "Add this to your vim-plug configuration:"
                echo "$config_snippet"
                echo ""
                echo "And add this after plug#end():"
                echo "lua require('0x96f').setup()"
                echo "colorscheme 0x96f"
            else
                print_info "Creating basic vim-plug configuration"
                cat > "$init_lua" << EOF
-- vim-plug configuration
vim.cmd [[
call plug#begin()
$config_snippet
call plug#end()
]]

-- Load theme
require('0x96f').setup()
vim.cmd.colorscheme('0x96f')
EOF
                print_success "Created basic vim-plug configuration"
            fi
            ;;
    esac
}

# Show post-installation instructions
show_instructions() {
    print_success "0x96f.nvim installation completed!"
    echo ""
    print_info "Next steps:"
    
    case $PLUGIN_MANAGER in
        lazy)
            echo "1. Restart Neovim or run :Lazy sync"
            echo "2. The theme should load automatically"
            ;;
        packer)
            echo "1. Restart Neovim or run :PackerSync"
            echo "2. Run :PackerCompile if needed"
            ;;
        plug)
            echo "1. Restart Neovim or run :PlugInstall"
            echo "2. The theme should load automatically"
            ;;
    esac
    
    echo ""
    print_info "Manual activation:"
    echo "  :colorscheme 0x96f"
    echo ""
    print_info "Configuration directory: $NVIM_CONFIG_DIR"
    echo ""
    print_info "For more information, visit: https://github.com/filipjanevski/0x96f.nvim"
}

# Main installation process
main() {
    echo "0x96f.nvim Installation Script"
    echo "=============================="
    echo ""
    
    check_nvim
    
    if [[ ! -d "$NVIM_CONFIG_DIR" ]]; then
        print_info "Creating Neovim configuration directory: $NVIM_CONFIG_DIR"
        mkdir -p "$NVIM_CONFIG_DIR"
    fi
    
    detect_plugin_manager
    install_theme
    show_instructions
}

# Run main function
main "$@"