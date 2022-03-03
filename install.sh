#!/bin/bash

ln -s ~/.dotfiles/.gitconfig ~/
ln -s ~/.dotfiles/.zshrc ~/
ln -s ~/.dotfiles/.vimrc ~/
ln -s ~/.dotfiles/.tmux.conf ~/

if [ "$SHELL" != "/usr/bin/zsh" ]; then
  sudo apt install -y zsh
  zsh
fi


