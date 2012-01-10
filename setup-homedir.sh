#!/bin/bash

# Get a fully qualified path
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
DIR=$(dirname $ABSPATH)

# Bash / terminal
cp bash_profile ~/.bash_profile
ln -sf $DIR/bashrc ~/.bashrc
ln -sf $DIR/bash_functions ~/.bash_functions
ln -sf $DIR/bash_aliases ~/.bash_aliases
ln -sf $DIR/gitconfig ~/.gitconfig
ln -sf $DIR/ctags ~/.ctags
ln -sf $DIR/inputrc ~/.inputrc

# Vim
if [ ! -d ~/.vim ]; then
  mkdir ~/.vim
fi
ln -sf $DIR/vim/vimrc ~/.vimrc
ln -sf $DIR/vim/vim/update_bundles ~/.vim/update_bundles
ln -sf $DIR/vim/vim/colors ~/.vim/colors
ln -sf $DIR/vim/vim/autoload ~/.vim/autoload

# Ack grep
ln -sf $DIR/ackrc ~/.ackrc
