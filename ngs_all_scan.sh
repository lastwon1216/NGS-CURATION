#!/bin/bash
#$ -v PATH=/common/bermanblab:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin
#$ -S /bin/bash
#$ -cwd
set -xe

Date=`date +%y%m%d`
Log1=/common/bermanblab/ngs_data/"$USER-$Date"_home_ngs.txt
Log2=/common/bermanblab/ngs_data/"$USER-$Date"_common_ngs.txt
EXT="${1}"
TYPE="${2}"
COMP="${3}"

cd ~

#find all the files with a given extension and awk the results and append into all.txt.
find -iname \*.$Date_${EXT} -print0 | xargs -0 -I {} ls -l {} --time-style="+%b %Y" | awk '{print $NF,$3,$5,$6,$7}' OFS="\t" > "$Date_${EXT}".txt
awk -vext="${EXT}" -vfiletype="${TYPE}" -vcompress="${COMP}" -vOFS="\t" '{print $0, ext, filetype, compress}' < "$Date_${EXT}".txt >> $Log1;

cd /common/$USER/

find -iname \*.${EXT} -print0 | xargs -0 -I {} ls -l {} --time-style="+%b %Y" | awk '{print $NF,$3,$5,$6,$7}' OFS="\t" > ${EXT}.txt
awk -vext="${EXT}" -vfiletype="${TYPE}" -vcompress="${COMP}" -vOFS="\t" '{print $0, ext, filetype, compress}' < ${EXT}.txt >> $Log2;

#echo "Subject: $User NGS DATA collected." | sendmail -v wonje.choi@cshs.org;
