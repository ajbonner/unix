#!/usr/bin/env bash

# Get a fully qualified path
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
DIR=$(dirname $ABSPATH)

# Bash / terminal
ln -sf $DIR/profile ~/.bash_profile
ln -sf $DIR/bashrc ~/.bashrc
ln -sf $DIR/bash_login ~/.bash_login
ln -sf $DIR/bash_logout ~/.bash_logout

/usr/bin/env DIR=$DIR setup-common.sh
