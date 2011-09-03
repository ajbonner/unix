# ~/.bash_functions

function syncwsimages() {
  rsync --archive \
    --verbose \
    -e ssh \
    waterscape@vpn-web-a:/home/waterscape/public_html/waterscape/var/www/media /home/aaron/Sites/waterscape/var/www
}

function pipeinsql() {
  cat $1 | mysql -p $2
}

function pipeinbzsql() {
  bzcat $1 | mysql -p $2
}

function dbdump() {
  if [ $# -lt 3 ]; then
    echo 'Usage: dbdump username password dbname';
    return
  fi
  FILE=$3-`date +'%H%M%d%m%Y'`.sql
  mysqldump -u$1 -p$2 $3 > $FILE && bzip2 $FILE
}

function phpgrep() {
  find . -name '*.php' -print0 | xargs -0 grep "$1"
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

