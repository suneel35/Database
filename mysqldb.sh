#!/bin/bash
mkdir -p /tmp/db_backup
TODAY=`date +"%Y.%m.%d-%H.%M.%S"`
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='4\Y+$w&<`_mJTS6T'
database='books'
sudo mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${database} | gzip > /tmp/db_backup/${database}-${TODAY}.sql.gz
RESULT=$?
if [ $RESULT -eq 0 ]; then

echo "mysqldb backup completed sucessfully"

else

echo "mysqldb backup not sucessfull"

fi
