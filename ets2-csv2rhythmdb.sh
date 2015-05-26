#!/bin/bash
#######################################################################
#
#                    ets2-csv2rhythmdb.sh
#
#  Convert your .csv of radio streams to a RhythmBox "rhythmdb.xml"
#  compatible XML snippet.  Created primary for use with my other
#  Euro Truck Simulator 2 script(s).
#
#  2015-05-26, Geoff Maciolek
#
#  https://www.github.com/GeoffMaciolek/ETS2-Tools
#

# If no parameters are specified, set $file to "-"
file=${1--}

#  Checks the following to ensure proper usage.  If NOT, explain usage and exit
#   (using stdin, no paramters, non-interactive) or (passing a filename, it's not "-" (stdin), only one parameter, running interactively, file exists.)
if ! [[ ( ( ( "$file" == "-" ) && ( "$#"  -eq 0 ) && ! ( -t 0 ) ) || ( ( -n "$file" ) && ! ( "$file" == "-" ) && ( $# -eq 1 ) && ( -t 0 ) && ( -e "$file" ) ) ) ]]; then
  if ! [[ -e "$file" ]] ; then echo; echo "ERROR:  File $file doesn't exist!"; echo; exit 1; fi
  echo
  echo "$0 - Convert your radio stream CSV into RhythmBox compatible XML (snippet)"
  echo
  echo "Usage: speficfy filename, or pass valid csv data to stdin."
  echo
  echo "Examples: $0 filename.csv"
  echo "          $0 /path/to/live_streams.sii | /path/to/ets2-csv2rhythmdb.sh > rhythmdb.xmlpart"
  echo
  exit 0
fi

#Begin iterating through file or stdin
while read -r theline; do

   url=$(cut -d, -f1 <<< ${theline})
   title=$(cut -d, -f2 <<< ${theline})
   genre=$(cut -d, -f3 <<< ${theline})
   country=$(cut -d, -f4 <<< ${theline})
   bitrate=$(cut -d, -f5 <<< ${theline})

   #-e is used here to convert the backspace-escaped i18n UTF-8 chars to Unicode
   echo '  <entry type="iradio">'
   echo -e "    <title>$genre: $title ($bitrate)</title>"
   echo "    <genre>ETS2-$country</genre>"
   echo "    <artist></artist>"
   echo "    <album></album>"
   echo "    <location>$url</location>"
   echo "    <date>0</date>"
   echo "    <media-type>application/octet-stream</media-type>"
   echo "  </entry>"

done < <(cat -- "$file")
# Injects the file contents or passes "-" to cat pass stdin.  (Double-hyphen means "translate the rest literally as filenames")
