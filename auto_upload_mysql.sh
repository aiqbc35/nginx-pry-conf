#!/bin/bash

DROPBOX_DIR=/$(date +%Y-%m-%d)    #dropbox 目录

MYSQL_USER="root"
MYSQL_PASS="" #数据库密码
MYSQL_DB="" #数据库名称

BACK_DATA=~/backup-data

MYSQL_BACK_NAME=database_$(date +"%Y-%m-%d").tar.gz
OLD_MYSQL_BACK_NAME=database_$(date -d -6day +"%Y-%m-%d").tar.gz

OLD_DROPBOX_DIR=/$(date -d -30day +%Y-%m-%d)

#清理本地6天前的文件
echo -ne "Delete local data of 6 day files"
rm -rf "$BACK_DATA/$OLD_MYSQL_BACK_NAME"
echo -e "Done"

cd $BACK_DATA

echo -ne "backup mysql"

/usr/local/mysql/bin/mysqldump -u $MYSQL_USER -p$MYSQL_PASS $MYSQL_DB > video.sql

tar zcf $MYSQL_BACK_NAME ./*.sql
rm -rf ./*.sql
echo -e "Done"

cd $BACK_DATA
#上传备份文件

~/dropbox_uploader.sh upload "$BACK_DATA/$MYSQL_BACK_NAME" "$DROPBOX_DIR/$MYSQL_BACK_NAME"

#删除30天备份
~/dropbox_uploader.sh delete $OLD_DROPBOX_DIR

echo -ne "Thank you! All done"
