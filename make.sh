#!/usr/bin/env bash

path="$(pwd)"

# Brew
brew update
brew install neovim
brew install zsh zsh-completions
brew install fzf
brew install wget
brew install getantibody/tap/antibody

# ZSH
chsh -s $(which zsh)

ln -svf $path/zsh/zshenv ~/.zshenv
ln -svf $path/zsh/zshrc ~/.zshrc
ln -svf $path/zsh/aliases.zsh ~/.aliases
ln -svf $path/zsh/exports.zsh ~/.exports
ln -svf $path/zsh/functions.zsh ~/.functions
touch ~/.hushlogin # Avoid "Last Login: xyz"

# GIT
ln -svf $path/git/gitconfig ~/.gitconfig
ln -svf $path/git/gitignore ~/.gitignore

# VIM
ln -svf $path/vim/nvim/config ~/.config
ln -svf $path/vim/ideavimrc ~/.ideavimrc

# Postgres
ln -svf $path/psqlrc ~/.psqlrc

# Additional scripts
ln -svf $path/startup.py ~/startup.py
