#!/bin/bash

if [ -f ~/.gitconfig ] && [ ! -f ~/.gitconfig.orig ]; then
  mv ~/.gitconfig ~/.gitconfig.orig
fi

if [ -f ~/.zshrc ] && [ ! -f ~/.zshrc.orig ]; then
  mv ~/.zshrc ~/.zshrc.orig
fi

if [ "$CODESPACES" = true ]; then
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/gitconfig ~/.gitconfig 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/zshrc ~/.zshrc 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/vimrc ~/.vimrc 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/tmux.conf ~/.tmux.conf 2>/dev/null
else
  ln -s ~/.dotfiles/gitconfig ~/.gitconfig 2>/dev/null
  ln -s ~/.dotfiles/zshrc ~/.zshrc 2>/dev/null
  ln -s ~/.dotfiles/vimrc ~/.vimrc 2>/dev/null
  ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf 2>/dev/null
fi

if [ ! -d ~/.vim ]; then
  mkdir -p ~/.vim
fi

git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -E -s +PlugInstall +qall

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
    sudo chsh "$USER" --shell "/usr/bin/zsh"
  fi
}

if [ "$CODESPACES" = true ]; then
  # /etc/environment sets the SHELL var, which overrides it being set to the shell field of passwd
  # so remove it
  echo "removing SHELL assignment from /etc/environment"
  sudo sed -i.orig '/^SHELL=/d' /etc/environment
  set_zsh "codespace"
else
  set_zsh "build"
fi
