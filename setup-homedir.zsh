#!/usr/bin/env bash

# Get a fully qualified path
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
DIR=$(dirname $ABSPATH)

# Bash / zsh / terminal
ln -sf $DIR/profile ~/.profile
ln -sf $DIR/zsh/zshrc ~/.zshrc
git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

/usr/bin/env DIR=$DIR bash setup-common.sh
