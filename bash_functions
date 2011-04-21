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
