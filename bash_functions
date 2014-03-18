# ~/.bash_functions

function myip() {
  wget -q http://icanhazip.com -O -
}

function aptup {
  sudo apt-get update && sudo apt-get upgrade
}

function phpunit_debug() {
  DEBUG_SERVER=$1
  shift
  PHP_IDE_CONFIG="servername=$DEBUG_SERVER" phpunit $@
}

function pkgup() {
  sudo apt-get update && sudo apt-get upgrade
}

function cleanmacmenus() {
  sudo /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user
}

function ssh_sync() {
  if [ $# -lt 2 ]; then
    echo 'Usage: ssh_sync remote-src local-dest';
    return
  fi
  
  rsync --archive \
    --verbose \
    --progress \
    -e ssh \
    $1 $2 
}

function enable_xdebug() {
  sudo sed -i'' 's/^;*//g' /etc/php5/conf.d/xdebug.ini 
}

function enable_xdebug_profiler() {
    enable_xdebug
    echo 'xdebug.profiler_enable=1' | sudo tee -a /etc/php5/conf.d/xdebug.ini >/dev/null
}

function disable_xdebug_profiler() {
    sudo sed -i'' '/^xdebug.profiler_enable/d' /etc/php5/conf.d/xdebug.ini
}

function disable_xdebug() {
  sudo sed -i'' 's/^/;/g' /etc/php5/conf.d/xdebug.ini 
}

function pipeinsql() {
  FILEINFO=$(file $1)
  if [[ $FILEINFO =~ "bzip2" ]]; then
    pipeinbzsql $1 $2
  elif [[ $FILEINFO =~ "gzip" ]]; then
    pipeingzsql $1 $2
  else
    cat $1 | mysql -p $2
  fi
}

function pipeinbzsql() {
  bzcat $1 | mysql -p $2
}

function pipeingzsql() {
  gunzip -c $1 | mysql -p $2
}

function dbdump() {
  if [ $# -lt 3 ]; then
    echo 'Usage: dbdump username password dbname';
    return
  fi
  FILE=$3-`date +'%H%M%d%m%Y'`.sql
  mysqldump -u$1 -p$2 $3 > $FILE && bzip2 $FILE
}

function printcolors() {
  # Sample text
  T='gYw'
  
  echo -e "\n                 40m     41m     42m     43m\
       44m     45m     46m     47m";
  
  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$ONE \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
}

function cpufreq() {
  for CPU in `seq 0 3`; do
    sudo cpufreq-set -c $CPU -g $1
  done
}

function vmwrun() {
    vmrun start "$HOME/Documents/Virtual Machines.localized/$1.vmwarevm/$1.vmx" nogui
}

function startvm() {
    VBoxManage startvm "$1" --type headless 
}

function stopvm() {
    VBoxManage controlvm "$1" poweroff
}

function parse_git_branch_and_add_brackets {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}
