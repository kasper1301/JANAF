#!/bin/bash
# find all files in the html folder
find html/* | xargs \
# grep the files with the phrase 'requested resource is not available'
grep -l 'requested resource is not available' | xargs \
# remove the files 
rm
