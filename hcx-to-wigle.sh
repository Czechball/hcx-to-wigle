#!/bin/bash

FILENAME="$1-wigle.csv"
TMPFILE=$(mktemp)

# Sanity Checks

if [[ "$1" == "" ]]; then
  echo Usage: "$0 <pcapng file>"
  exit
fi

# Check if hcxpcapngtool is installed
which hcxpcapngtool > /dev/null || { echo Error: hcxpcapngtool is not installed, you can get it from "https://github.com/ZerBea/hcxtools"; exit 1; }
# Check if input file is pcapng file
if [[ $(file "$1" | grep pcapng) == "" ]]; then
  echo Error: "$1" is not a pcapng file.
fi

# Get hcxdumptool version

APPLICATION=$(hcxpcapngtool "$1" | grep application | awk 'BEGIN { FS = " " } ; { print $2 }')
VERSION=$(hcxpcapngtool "$1" | grep application | awk 'BEGIN { FS = " " } ; { print $3 }')
VENDOR=$(hcxpcapngtool "$1" | grep "interface vendor" | awk 'BEGIN { FS = " " } ; {print $3 }')

# Create .csv from hcxpcapngtool

hcxpcapngtool "$1" --csv "$TMPFILE" > /dev/null

# Insert pre-header

echo "WigleWifi-1.4,appRelease=$APPLICATION $VERSION,model=$APPLICATION,release=$VERSION,device=$APPLICATION,display=$APPLICATION,board=$APPLICATION,brand=$VENDOR" > "$FILENAME"

# Insert header

echo "MAC,SSID,AuthMode,FirstSeen,Channel,RSSI,CurrentLatitude,CurrentLongitude,AltitudeMeters,AccuracyMeters,Type" >> "$FILENAME"

# Insert values from actual csv

awk 'BEGIN { FS = "\t" } ; { print $3","$4","$5$6","$1" "$2","$9","$10","$15","$16","$20",0,WIFI" }' "$TMPFILE" >> "$FILENAME"

rm "$TMPFILE"
