#!/bin/bash
#######################################################################
#
#                    ets2-streams2csv.sh
#
#  Convert your Euro Truck Simulator 2 "live_streams.sii" to a .csv
#  for conversion to various other formats
#
#  This doesn't include headers
#
#  2015-05-26, Geoff Maciolek
#
#  https://www.github.com/GeoffMaciolek/ETS2-Tools
#

sort=5               # set to 0 if you don't want to sort, or:  url: 1, title: 2, genre: 3, country: 4, or bitrate: 5
convertcountries=1   # set to 0 if you want to leave eg FR instead of France, 1 to convert
outputdelim=","      # the delimiter for the output CSV

# Edit for your language "translation" of choice
countrysed="s,BE,belgium,
s,BG,Bulgaria,
s,CZE,Czech Republic,
s,DE,Germany,
s,DK,Denmark,
s,Dutch,Dutch,
s,EN,England,
s,EST,Estonia,
s,FR,France,
s,INT,International,
s,NL,Netherlands,
s,PL,Poland,
s,RU,Russia,
s,SK,Slovakia,
s,SRB,Serbia,
s,UA,Ukraine,
s,UK,UK,"

if [[ $# -eq 0 ]]; then
  echo "$0 - convert Euro Truck Simulator 2 live_streams.sii files into CSV"
  echo
  echo "Usage: $0 /path/to/live_streams.sii > ets2-streams.csv"
  echo "or:    $0 /path/to/live_streams.sii | /path/to/ets2-csv2rhythmdb.sh > rhythmdb.xmlpart"
  echo "       (see ets-csv2rhythmdb.sh for details)"
  echo
  exit 0
fi


if [[ $sort = "5" ]]; then
  sort="5 -n" #sort properly by numbers when needed
fi

# only match the actual content lines, strip out leading info, convert delimiter to comma for csv (not technically needed, but aids debugging)
grep "stream_data\[" "$1" | cut -d '"' -f2 | tr "|" "," |\
 while read -r inputline; do    # read each line, -r allows the escaped UTF-8 to pass through properly

 #echo -e $inputline #simple output for testing

  url=$(cut -d, -f1 <<< ${inputline})
  title=$(cut -d, -f2 <<< ${inputline})
  genre=$(cut -d, -f3 <<< ${inputline})
  country=$(cut -d, -f4 <<< ${inputline})
  bitrate=$(cut -d, -f5 <<< ${inputline})

  if [[ convertcountries -eq 1 ]]; then
    country=$(sed "$countrysed" <<< ${country})
  fi

  echo -e "${url}${outputdelim}${title}${outputdelim}${genre}${outputdelim}${country}${outputdelim}${bitrate}" #output CSV formatted data, by chosen delimiter
                                                                                                               #formatting UTF-8 backslash-escaped data to Unicode

 done | if [[ $sort -ne 0 ]]; then sort -t, -k${sort}; else cat; fi # Sort data by desired key if enabled
