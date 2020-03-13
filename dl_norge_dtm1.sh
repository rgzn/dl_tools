#!/usr/bin/env bash
set -e

# Downloads all UTM33 DTM1 data from hoydedata.no

BASEURL="https://hoydedata.no/LaserInnsyn/Home/DownloadFile/"
FILE_NUMBERS=$(echo {29..53})
LOGFILE="dl.log"

get_tifs_from_url () {
    URL=$1
    DIR=$2
    wget -P $DIR -nc --content-disposition $URL
    ZIPFILE=$(ls -d $DIR/*.zip)
    unzip -u $ZIPFILE "*.tif"
    rm -rf $DIR
}
export -f get_tifs_from_url

# echo $FILE_NUMBERS | tr " " "\n" | parallel --joblog dl.log  wget -nc --content-disposition "$BASEURL{}"

echo $FILE_NUMBERS | tr " " "\n" | parallel --joblog $LOGFILE get_tifs_from_url "$BASEURL{}" "{}" 
