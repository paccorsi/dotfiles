#!/usr/bin/env bash

# ZSH
ln -svf ~/dotfiles/zsh/zshenv ~/.zshenv
ln -svf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -svf ~/dotfiles/zsh/aliases.zsh ~/.aliases
ln -svf ~/dotfiles/zsh/exports.zsh ~/.exports
ln -svf ~/dotfiles/zsh/functions.zsh ~/.functions

# GIT
ln -svf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -svf ~/dotfiles/git/gitignore ~/.gitignore

# VIM
ln -svf ~/dotfiles/vim/vimrc ~/.nvimrc
ln -svf ~/dotfiles/vim/nvim ~/nvim
ln -svf ~/dotfiles/vim/ideavimrc ~/.ideavimrc

# Postgres
ln -svf ~/dotfiles/psqlrc ~/.psqlrc
