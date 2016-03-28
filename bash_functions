# ~/.bash_functions

function myip() {
  wget -q http://icanhazip.com -O -
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

function parse_git_branch_and_add_brackets {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

function stage {
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD) cap staging deploy
}

function sweettooth {
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD) cap sweettooth deploy
}

function deploy {
  if [ $# -eq 0 ]; then
    cap production deploy
  else
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD) cap $1 deploy
  fi
}


function listbranches() {
  for k in $(git branch | perl -pe s/^..//); do 
    echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1)\\t$k
  done | sort -r
}
