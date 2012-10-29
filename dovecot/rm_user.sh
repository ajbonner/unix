#!/bin/bash
#
# dovecot remove user - for deleting virtual dovecot users
#
if [ ! $# = 1 ]
 then
  echo -e "Usage: $0 username@domain"
  exit 1
 else
  user=`echo "$1" | cut -f1 -d "@"`
  domain=`echo "$1" | cut -s -f2 -d "@"`
  if [ -x $domain ]
   then
    echo -e "No domain given\nUsage: $0 username@domain: "
    exit 2
  fi
fi
read -n 1 -p "Delete user $user@$domain from dovecot? [Y/N]? "
echo
case $REPLY in
 y | Y)
  new_users=`grep -v $user@$domain /etc/dovecot/users`
  new_passwd=`grep -v $user@$domain /etc/dovecot/passwd`
  new_vmaps=`grep -v $user@$domain /etc/postfix/vmaps`
  echo "Deleting $user@$domain from /etc/dovecot/users"
  echo "$new_users" > /etc/dovecot/users
  echo "Deleting $user@$domain from /etc/dovecot/passwd"
  echo "$new_passwd" > /etc/dovecot/passwd
  echo "Deleting $user@$domain from /etc/postfix/vmaps"
  echo "$new_vmaps" > /etc/postfix/vmaps
  postmap /etc/postfix/vmaps
  postfix reload
  read -n1 -p "Delete all files in /home/vmail/$domain/$user? [Y/N]? " DELETE
  echo
  case $DELETE in
   y | Y)
    echo "Deleting files in /home/vmail/$domain/$user"
    rm -fr /home/vmail/$domain/$user
   ;;
   * )
    echo "Not deleting files in /home/vmail/$domain/$user"
   ;;
  esac
 ;;
 * )
  echo "Aborting..."
 ;;
esac
