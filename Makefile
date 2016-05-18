default: help

bash: 
	./setup-homedir.sh

zsh: 
	./setup-homedir.zsh

help:
	@echo "Usage: $$ make [bash|zsh] to install dotfiles to ${HOME} for chosen shell."

