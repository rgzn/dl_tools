#!/usr/bin/env bash
set -e

for I in {01..32}
do
    echo > tmp_urls.txt
done

cat tmp_urls.txt | parallel wget --content-disposition {}    

rm tmp_urls.txt


# for I in {001..011}
# do
#     URL="https://www.inegi.org.mx/app/geo2/elevacionesmex/DownloadFile.do?file=CEM_V3_20170619_R15_Nacional.zip.${I}&res=15"
#     T_FILE="CEM_V3_20170619_R15_Nacional_${I}.zip"
# #     echo curl "$URL" \ 
# #         -H 'Connection: keep-alive' \ 
# #         -H 'Upgrade-Insecure-Requests: 1' \
# #         -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.115' \ 
# #         -H 'Sec-Fetch-User: ?1' \ 
# #         -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \ 
# #         -H 'Sec-Fetch-Site: same-origin' \ 
# #         -H 'Sec-Fetch-Mode: navigate' \ 
# #         -H 'Referer: https://www.inegi.org.mx/app/geo2/elevacionesmex/' \ 
# #         -H 'Accept-Encoding: gzip, deflate, br' \ 
# #         -H 'Accept-Language: en-US,en;q=0.9' \ 
# #         -H 'Cookie: JSESSIONID=5CF14BA8D71A5648E8E1BED2D6200AB1; NSC_MC_bqq_hfp2=ffffffff09911c7945525d5f4f58455e445a4a4229a2; NSC_MC_OvfwpQpsubm=ffffffff09da7a3e45525d5f4f58455e445a4a423660; NSC_MC_bqjt=ffffffff09da7a5845525d5f4f58455e445a4a423660; _ga=GA1.3.1935936139.1583781479; _gid=GA1.3.105315314.1583781479; _gat=1'  --compressed -O -J 
#     curl "$URL" -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.115' -H 'Sec-Fetch-User: ?1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-Mode: navigate' -H 'Referer: https://www.inegi.org.mx/app/geo2/elevacionesmex/' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cookie: JSESSIONID=5CF14BA8D71A5648E8E1BED2D6200AB1; NSC_MC_bqq_hfp2=ffffffff09911c7945525d5f4f58455e445a4a4229a2; NSC_MC_OvfwpQpsubm=ffffffff09da7a3e45525d5f4f58455e445a4a423660; NSC_MC_bqjt=ffffffff09da7a5845525d5f4f58455e445a4a423660; _ga=GA1.3.1935936139.1583781479; _gid=GA1.3.105315314.1583781479; _gat=1'  --compressed -O -J 
# done
# 
