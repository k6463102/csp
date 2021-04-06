#!/bin/bash -eu

# 引数となるCSVファイルのデータ列は「学籍番号,姓　名,有効年」にすること

if [[ $# != 1 ]]; then
  echo "Usage: $0 csvfile"
  exit 1
fi

nkfguess=`nkf --guess $1`

if [[ $nkfguess != 'Shift_JIS (CRLF)' ]]; then
  echo "$1 is not Shift_JIS (CRLF)"
  exit 1
fi


start_year=`date '+%Y'`

tmpfile=$(mktemp)

nkf -w -d $1 | awk -v s="$start_year" 'BEGIN{FS=",";OFS="\t"}{print \
  $1, \
  "カード1", \
  $2, \
  "", \
  s"/04/01", \
  s+$3"/05/01", \
  "あり", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "なし", \
  "0", \
  "002", \
  "", \
  "1", \
  $1, \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "", \
  "" \
  }' > $tmpfile

outfile=`basename $1 | sed 's/csv/txt/g'`
nkf -s -c -Z4 $tmpfile > $outfile
