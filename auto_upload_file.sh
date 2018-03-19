#!/bin/bash

DROPBOX_DIR=/$(date +%Y-%m-%d)    #dropbox 目录

BACK_DATA=~/backup-data    #文件备份目录
DATA=/home/wwwroot/default   #需要备份的文件所在目录

#备份文件名
IMAGES_FILE=images_$(date +"%Y-%m-%d").tar.gz

OLD_IMAGES_FILE=imgaes_$(date -d -day +"%Y-%m-%d").tar.gz

OLD_DROPBOX_DIR=/$(date -d -30day +%Y-%m-%d)

#清理本地6天前的文件
echo -ne "Delete local data of 6 day files"
rm -rf "$BACK_DATA/$OLD_IMAGES_FILE"
echo -e "Done"

#备份文件
echo -ne "Backup images files"
cd $DATA
tar zcf "$BACK_DATA/$IMAGES_FILE" ./*
echo -e "Done"

cd $BACK_DATA

#上传备份文件

~/dropbox_uploader.sh upload "$BACK_DATA/$IMAGES_FILE" "$DROPBOX_DIR/$IMAGES_FILE"

#删除30天备份
~/dropbox_uploader.sh delete $OLD_DROPBOX_DIR

echo -ne "Thank you! All done"
