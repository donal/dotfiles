#!/bin/bash

if [ -f ~/.gitconfig ] && [ ! -f ~/.gitconfig.orig ]; then
  mv ~/.gitconfig ~/.gitconfig.orig
fi

if [ -f ~/.zshrc ] && [ ! -f ~/.zshrc.orig ]; then
  mv ~/.zshrc ~/.zshrc.orig
fi

if [ "$CODESPACES" = true ]; then
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/gitconfig ~/.gitconfig
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/zshrc ~/.zshrc
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/vimrc ~/.vimrc
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/tmux.conf ~/.tmux.conf
else
  ln -s ~/.dotfiles/gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/zshrc ~/.zshrc
  ln -s ~/.dotfiles/vimrc ~/.vimrc
  ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
fi

if [ ! -d ~/.vim ]; then
  mkdir -p ~/.vim
fi

git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

if [ ! -d ~/.src/zsh-git-prompt ]; then
  mkdir -p ~/.src/zsh-git-prompt
  if [ "$CODESPACES" = true ]; then
    ln -s /workspaces/.codespaces/.persistedshare/dotfiles/zsh-git-prompt/zshrc.sh ~/.src/zsh-git-prompt/zshrc.sh
  else
    ln -s ~/.dotfiles/zsh-git-prompt/zshrc.sh ~/.src/zsh-git-prompt/zshrc.sh
  fi
fi

sudo apt install -y zsh

set_zsh() {
  USER=$1
  if grep -q "$USER" /etc/passwd && ! grep -q "$USER.*zsh" /etc/passwd; then
    echo "set shell to zsh for $USER"
    sudo chsh "$(USER)" --shell "/usr/bin/zsh"
  fi
}

if [ "$CODESPACES" = true ]; then
  set_zsh "codespace"
else
  set_zsh "build"
fi
