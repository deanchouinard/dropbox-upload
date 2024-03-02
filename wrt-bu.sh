#!/bin/bash

TMP_DIR="/home/deanchouinard/temp"
DATE=$(date +"%Y-%m-%d_%H%M")
BKP_FILE="$TMP_DIR/wrt-bu_$DATE.tar.gz"
# BKP_DIRS="/home/user /var/www /etc"
BKP_DIRS="/home/deanchouinard/wrk/wrt"
DROPBOX_UPLOADER=/home/deanchouinard/wrk/scripts/upload-to-dropbox.sh

tar -czvf "$BKP_FILE" $BKP_DIRS
# gzip "$BKP_FILE"
# tar -czvf wpbu.tar.gz 

# $DROPBOX_UPLOADER -f /root/.dropbox_uploader upload "$BKP_FILE.gz" /
sh $DROPBOX_UPLOADER "$BKP_FILE"
ls -al --color $TMP_DIR
rm -fr "$BKP_FILE"
ls -al --color $TMP_DIR

