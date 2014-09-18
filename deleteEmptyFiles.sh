#!/bin/bash
# find all files in the html folder
# grep the files with the phrase 'requested resource is not available'
# remove the files 
find html/* | xargs grep -l 'requested resource is not available' | xargs rm
