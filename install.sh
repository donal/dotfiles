#!/bin/bash

if [ -f "${HOME}"/.gitconfig ] && [ ! -f "${HOME}"/.gitconfig.orig ]; then
  mv "${HOME}"/.gitconfig "${HOME}"/.gitconfig.orig
fi

if [ -f "${HOME}"/.zshrc ] && [ ! -f "${HOME}"/.zshrc.orig ]; then
  mv "${HOME}"/.zshrc "${HOME}"/.zshrc.orig
fi

if [ "$CODESPACES" = true ]; then
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/gitconfig "${HOME}"/.gitconfig 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/zshrc "${HOME}"/.zshrc 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/vimrc "${HOME}"/.vimrc 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/tmux.conf "${HOME}"/.tmux.conf 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/fzf.bash "${HOME}"/.fzf.bash 2>/dev/null
  ln -s /workspaces/.codespaces/.persistedshare/dotfiles/fzf.zsh "${HOME}"/.fzf.zsh 2>/dev/null
else
  ln -s "${HOME}"/.dotfiles/gitconfig "${HOME}"/.gitconfig 2>/dev/null
  ln -s "${HOME}"/.dotfiles/zshrc "${HOME}"/.zshrc 2>/dev/null
  ln -s "${HOME}"/.dotfiles/vimrc "${HOME}"/.vimrc 2>/dev/null
  ln -s "${HOME}"/.dotfiles/tmux.conf "${HOME}"/.tmux.conf 2>/dev/null
  ln -s "${HOME}"/.dotfiles/fzf.bash "${HOME}"/.fzf.bash 2>/dev/null
  ln -s "${HOME}"/.dotfiles/fzf.zsh "${HOME}"/.fzf.zsh 2>/dev/null
fi

if [ ! -d "${HOME}"/.vim ]; then
  mkdir -p "${HOME}"/.vim
fi

BUNDLE_PATH="${HOME}/.vim/bundle"

BUNDLE_NAME="gruvbox"
BUNDLE_REPO="https://github.com/morhetz/gruvbox.git"
if [ ! -d "$BUNDLE_PATH/$BUNDLE_NAME" ] || [ ! "$(ls -A $BUNDLE_PATH/$BUNDLE_NAME)" ]; then
  git clone "$BUNDLE_REPO" "$BUNDLE_PATH/$BUNDLE_NAME"
fi

BUNDLE_NAME="Vundle.vim"
BUNDLE_REPO="https://github.com/VundleVim/Vundle.vim.git"
if [ ! -d "$BUNDLE_PATH/$BUNDLE_NAME" ] || [ ! "$(ls -A $BUNDLE_PATH/$BUNDLE_NAME)" ]; then
  git clone "$BUNDLE_REPO" "$BUNDLE_PATH/$BUNDLE_NAME"
fi
vim -E -s +PlugInstall +qall

if [ ! -d "${HOME}"/.src/zsh-git-prompt ]; then
  mkdir -p "${HOME}"/.src/zsh-git-prompt
  if [ "$CODESPACES" = true ]; then
    ln -s /workspaces/.codespaces/.persistedshare/dotfiles/zsh-git-prompt/zshrc.sh "${HOME}"/.src/zsh-git-prompt/zshrc.sh
  else
    ln -s "${HOME}"/.dotfiles/zsh-git-prompt/zshrc.sh "${HOME}"/.src/zsh-git-prompt/zshrc.sh
  fi
fi

sudo apt-get update

if [ ! "$CODESPACES" = true ]; then
  # no need to install on codespaces
  sudo apt install -y zsh
fi

name=tmux
if ! dpkg-query -W --showformat='${Status}\n' "$name" >/dev/null 2>&1; then
  echo "installing $name"
  sudo apt-get --assume-yes install "$name"
fi

name=fzf
if ! dpkg-query -W --showformat='${Status}\n' "$name" >/dev/null 2>&1; then
  echo "installing $name"
  sudo apt-get --assume-yes install "$name"
fi

name=ripgrep
if ! dpkg-query -W --showformat='${Status}\n' "$name" >/dev/null 2>&1; then
  echo "installing $name"
  sudo apt-get --assume-yes install "$name"
fi

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
  if [ -f /etc/environment.orig ]; then
    sudo sed -i '/^SHELL=/d' /etc/environment
  else
    # only create the backup file once
    sudo sed -i.orig '/^SHELL=/d' /etc/environment
  fi
  set_zsh "codespace"
else
  set_zsh "build"
fi

if [ -f /etc/locale.gen ] && [ ! -f /etc/locale.gen.orig ]; then
  sudo cp /etc/locale.gen /etc/locale.gen.orig
fi

sudo cp "${HOME}"/.dotfiles/locale.gen /etc/locale.gen 2>/dev/null
sudo locale-gen
