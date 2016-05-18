#!/usr/bin/env bash

if [[ $DIR == "" ]]; then
  echo "DIR environment variable not set"
  exit 1
fi

ln -sf $DIR/bash_functions ~/.bash_functions
ln -sf $DIR/bash_aliases ~/.bash_aliases

ln -sf $DIR/gitconfig ~/.gitconfig
ln -sf $DIR/ctags ~/.ctags
ln -sf $DIR/inputrc ~/.inputrc
ln -sf $DIR/xsessionrc ~/.xessionrc
ln -sf $DIR/tmux/tmux.conf ~/.tmux.conf

# Vim
if [ ! -d ~/.vim ]; then
  mkdir ~/.vim
fi
ln -sf $DIR/vim/vimrc ~/.vimrc
ln -sf $DIR/vim/vim/update_bundles ~/.vim/update_bundles
ln -sf $DIR/vim/vim/colors ~/.vim/colors
ln -sf $DIR/vim/vim/autoload ~/.vim/autoload

# Ack
ln -sf $DIR/ackrc ~/.ackrc

# Dircolors
ln -sf $DIR/dircolors/dircolors.solarized.256dark ~/.dircolors

# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

