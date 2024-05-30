# ~/.bash_aliases

alias gzcat="zcat"
alias b="cd .."
alias gr='cd $(git rev-parse --show-toplevel)'
alias g="git"
alias pf="phpunit --filter"
alias mrcc="magerun.phar cache:clean"
alias inssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias genpwd="apg -m15 -a0 -MCNS"
alias brewup="brew update && brew upgrade && brew cleanup"
alias dc="docker compose"
alias xdebug="php -dxdebug.mode=debug -dxdebug.start_with_request=1"

/usr/bin/env which -s nvim && alias vim=nvim

