#!/usr/bin/bash

python gen_urls.py | sed '/^\s*$/d' |  parallel -j0 wget -P /mnt/data/norge_n50/ {}
