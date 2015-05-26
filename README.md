ETS2-Tools
==========

## Overview

ETS2-Tools is a collection of (bash) scripts for managing various features of Euro Truck Simulator 2, with a focus (so far) on Linux & Radio management.  As the Linux version of Euro Truck Simulator 2 doesn't have radio support, I created these tools to allow Linux users to use the ETS2 Windows stream list in their favorite music player(s).

So far, only **RhythmBox** is supported.

## ets2-streams2csv.sh

### Overview

`ets2-streams2csv.sh` allows you to convert the `live-streams.sii` file into a standard CSV for easier processing, including by `ets2-csv2rhythmboxxml.sh`

### Usage

`./ets2-streams2csv.sh "/mnt/windowsdrive/Users/MyUser/Euro Truck Simulator 2/live-streams.sii" > live-streams-2015-05-26.csv`

## ets2-csv2rhythmdb.sh

### Overview 

`ets2-csv2rhythmdb.sh` converts a csv file containing stream data (such as created by `ets2-streams2csv.sh`) into a **RhythmBox** `rhythmdb.xml` file segment, allowing you to bulk-import radio streams.

### Usage

`./ets2-csv2rhythmdb.sh "~/Documents/live-streams-2015-05-26.csv" > attach-me-to-rhythmbox.xmlpart` 
  or
`./ets2-streams2csv.sh "/path/to/live-streams.sii" | ./ets2-csv2rhythmdb.sh > attach-me-to-rhythmbox.xmlpart`

## Notes and Disclaimer

These scripts do not perform any sanity checking; use at your own risk.  I'm not responsible for any issues they cause.

The xml segment created by `ets2-csv2rhythmdb` needs to be inserted appropriately; otherwise you can corrupt your rhythmdb.xml file, and you **definitely** don't want that.
