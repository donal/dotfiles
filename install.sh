#!/bin/bash

mv ~/.gitconfig ~/.gitconfig.orig
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

if [ "$SHELL" != "/usr/bin/zsh" ]; then
  sudo apt install -y zsh
  zsh
fi


