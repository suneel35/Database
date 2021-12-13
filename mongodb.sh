#!/bin/bash
mkdir -p /opt/backups
MONGO_USER=tccpreprod_mongoadmin
MONGO_PASS=YHBxxa4v
S3_BUCKET_NAME=tcc-mongobackup
BACKUP_FILE_NAME=tccbackup$(date "+%Y.%m.%d-%H.%M.%S").zip
BACKUP_PATH=TCC-PREPROD
authenticationdatabase=admin
mongodump -u $MONGO_USER -p $MONGO_PASS  --authenticationDatabase=$authenticationdatabase -o /opt/backups/
zip -r $BACKUP_FILE_NAME /opt/backups/
aws s3 cp $BACKUP_FILE_NAME s3://$S3_BUCKET_NAME/$BACKUP_PATH/$(date "+%Y")/$(date "+%m")/$(date "+%d")/
rm -rf $BACKUP_FILE_NAME /opt/backups/
RESULT=$?
if [ $RESULT -eq 0 ]; then

logger mongodb backup completed sucessfully

else

logger mongodb backup not sucessfull

fi
