#!/usr/bin/env bash
set -e

# script to download finland n50 raster data

API_KEY="vdh7s2tnjorq849eb6hao969ad"
CELL_VECTOR_FILE="/mnt/data/suomi_vector/suomi_cells.shp"
DL_DIR="/mnt/data/suomi_n50"
BASE_URL="https://tiedostopalvelu.maanmittauslaitos.fi/tp/tilauslataus/tuotteet/maastokarttarasteri_50k_jhs180/painovari/4m/etrs89/png/"

# gen_urls() {
#     CELL=$1
#     URL_NO_EXT=$BASE_URL${CELL:0:2}/${CELL:0:3}/${CELL:0:4}
#     echo $URL_NO_EXT.png?token=$API_KEY $URL_NO_EXT.pgw?token=$API_KEY
# }
# export -f gen_urls

if [ -f tmp_urls ]; then
    rm tmp_urls
fi

CELLS=$(ogrinfo -al ${CELL_VECTOR_FILE} | sed -n -e 's/^[ ]*LEHTITUNNU (String) = //p')
for CELL in $CELLS 
do
    echo ${BASE_URL}${CELL:0:2}/${CELL:0:3}/${CELL:0:4}.pgw?token=$API_KEY >> tmp_urls
    echo ${BASE_URL}${CELL:0:2}/${CELL:0:3}/${CELL:0:4}.png?token=$API_KEY >> tmp_urls
done

cat tmp_urls | parallel wget -nd -P $DL_DIR --content-disposition {}

rm tmp_urls
