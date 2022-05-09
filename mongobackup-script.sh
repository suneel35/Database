#!/bin/bash
current_date=`date '+%Y-%m-%d-%H:%M:%S'`
DB_folder_name="dump_all_db_bk_$current_date"
sudo mkdir $DB_folder_name

db_list="admin adminDb avera  hoxworth hoxworth-on local ls mainDb mda mda-20180725 mda-pavlock mda-vc4 mda-vc4-20190709 mda-vc4-bkp mda_33 nbc nbtc nbtc-prod oneblood tyler tyler-staging-160719 vc4 vc41 vitalant vitalant-dryrun vitalant-vc4 "
for dbs in $db_list; do
    sudo mongodump --db $dbs --out $DB_folder_name --host rs0/172.31.3.204:27017,172.31.19.191:27017,172.31.4.150:27017y  --username root --password P3rf3qta_ecm2 --quiet --authenticationDatabase admin
    sudo zip -r -q $DB_folder_name/$dbs.zip $DB_folder_name/$dbs/
    sudo rm -r $DB_folder_name/$dbs
    echo "${dbs} - done"
 done

sudo zip -r --quiet $DB_folder_name.zip $DB_folder_name/
sudo rm -r $DB_folder_name
aws s3 cp  /home/ubuntu/do_not_delete/Daily_DB_bk/$DB_folder_name.zip s3://perfeqta-prod/Weekly_DB_backup/
sudo rm -r $DB_folder_name.zip
