#!/usr/bin/env bash

path="$(pwd)"

# Brew
brew update
brew bundle

go get -u github.com/justjanne/powerline-go

# ZSH
ln -svf "$path/zsh/zshenv" ~/.zshenv
ln -svf "$path/zsh/zshrc" ~/.zshrc
ln -svf "$path/zsh/aliases.zsh" ~/.aliases
ln -svf "$path/zsh/exports.zsh" ~/.exports
ln -svf "$path/zsh/functions.zsh" ~/.functions
touch ~/.hushlogin # Avoid "Last Login: xyz"

# GIT
ln -svf "$path/git/gitconfig" ~/.gitconfig
ln -svf "$path/git/gitignore" ~/.gitignore

# VIM
mkdir -p ~/.config/nvim
ln -svf "$path/vim/nvim/config/nvim" ~/.config/nvim
ln -svf "$path/vim/ideavimrc" ~/.ideavimrc

# Postgres
ln -svf "$path/psqlrc" ~/.psqlrc

# Additional scripts
ln -svf "$path/startup.py" ~/startup.py

# Antigen
antibody bundle <"$path/bundles.txt" > ~/.zsh_plugins
antibody update

