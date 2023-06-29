# ~/.bash_functions

function myip() {
  wget -4 -q http://icanhazip.com -O -
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
  CAP_STAGE=staging
  if [ $# -gt 0 ]; then
    CAP_STAGE=$1
  fi
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD) bundle exec cap $CAP_STAGE deploy
}

function deploy {
  bundle exec cap production deploy
}

function listbranches() {
  for k in $(git branch | perl -pe s/^..//); do
    echo -e $(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1)\\t$k
  done | sort -r
}

function mkv2mp4() {
  if [ ! $# -eq 1 ]; then 
    echo "Usage: mkv2mp4 <file.mkv>"
    return 1
  fi

  if [[ ${1##*.} != "mkv" ]]; then
    echo "Input must be an mkv file"
    return 1
  fi

  ffmpeg -i $1 -vcodec copy -acodec copy ${1%.*}.mp4
}

function add_key() {
  if [ ! $# -eq 1 ]; then
    echo "Usage: add_key user@host"
    return 1
  fi

  if [ $(basename $SHELL) == "zsh" ]; then
    READ_CMD="read -A -r KEY_PARTS <<< $1"
  else 
    READ_CMD="read -a -r KEY_PARTS <<< $1"
  fi

  IFS="@" eval $READ_CMD
  KEY_FILE="$(find $HOME/.ssh/ -name ${KEY_PARTS[2]}_${KEY_PARTS[1]} | head -n 1)"
  
  if [ ! -z $KEY_FILE ]; then
    ssh-add $KEY_FILE
  else 
    echo "Key not found for $1"
    return 1
  fi
}
  
upgrade_nvm() {
  echo "\033[32mAbout to update NVM...\033[0m";
  sleep 5
  cd "$NVM_DIR"
  git fetch -p
  git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
  source "$NVM_DIR/nvm.sh"
  cd "$OLDPWD"
}

sync_media() {
  rsync -avz --delete 'abonner@db1:/srv/nfs4/store/media/*' media/ --exclude='*watermarked*' --exclude='*cache*' --exclude='.thumbs' --exclude='js'  --exclude='css' --exclude='mnsresized' --exclude='purchasing' --exclude='customer/' --exclude='xmlconnect/'
}

sync_drupal_media() {
  rsync -avz --delete 'abonner@db1:/srv/nfs4/drupal/sites/default/files/' files/  --exclude='*cache*' --exclude='.thumbs' --exclude='js'  --exclude='css' 
}

dcsh() {
  if [ ! $# -eq 1 ]; then
    echo "Usage: dcsh <servicename>"
    return 1
  fi
  docker compose exec -it $1 /bin/bash
}

