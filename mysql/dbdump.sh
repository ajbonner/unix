#!/bin/sh                                                                       
                                                                                
MYSQLDUMP="/usr/bin/mysqldump"                                                  
GZIP="/bin/gzip"                                                                
                                                                                
USERNAME="root"                                                                 
PASSWORD=""                                                             
HOST="localhost"                                                                
DATE=`date +%Y%m%d-%H%M%S`                                                      
                                                                                
DBNAME=$1                                                                       
if [ "$DBNAME" != "" ]; then                                                    
    $MYSQLDUMP --disable-keys --no-autocommit --skip-lock-tables \
      --single-transaction --insert-ignore -u$USERNAME -p$PASSWORD \
      -h$HOST $DBNAME > ${BACKUP_DIR}${DBNAME}_${DATE}.sql
    $GZIP ${DBNAME}_${DATE}.sql                                                 
fi
