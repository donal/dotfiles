#!/bin/bash

mv ~/.gitconfig ~/.gitconfig.orig
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

sudo apt install -y zsh

set_zsh() {
  USER=$1
  if grep -q "$USER" /etc/passwd && ! grep -q "$USER.*zsh" /etc/passwd; then
    echo "set shell to zsh for $USER"
    sudo usermod --shell /usr/bin/zsh "$USER"
  fi
}

set_zsh "root"
set_zsh "build"
