# hcx-to-wigle
A simple bash script that converts hcxdumptool capture files to Wigle compatible csv import

This script uses hcxpcapngtool (part of [hcxtools](https://github.com/ZerBea/hcxtools) by @ZerBea) to process [hcxdumptool](https://github.com/ZerBea/hcxdumptool) pcapng files and generates [Wigle](https://wigle.net/) [csv imports](https://api.wigle.net/csvFormat.html) from them. Big thanks to @ZerBea for making this possible by implementing the needed changes in his software for this to work.

## Requirements

hcxpcapngtool from [hcxtools](https://github.com/ZerBea/hcxtools)

## Usage

`./hcx-to-wigle.sh <pcapng file>`

Output will then be a file with the same filename as the input but the extension replaced by "-wigle.csv". This output file can then by uploaded directly to Wigle.

## TODO

* Also process .csv files manually exported using hcxpcapngtool
* Automatically upload the output file to Wigle
* Check if there are any GPS data in input file (right now will also process files with no GPS data in them which will be accepted by Wigle but are kinda useless)
