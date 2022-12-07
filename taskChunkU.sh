#!/bin/bash

#$1--path to CAR files
#$2--path to source data
#$3--bucket name

printf "\n"
echo "< ++++++ Starting to chunk the car files at $(date) ++++++ >"
if ./graphsplit chunk --car-dir="$1" --slice-size=18697856102 --parallel=15 --graph-name=fildc --calc-commp=true --add-padding=false --rename=true --parent-path="$2" "$2"; then
    now="$(date +"%m-%d-%Y")"
    mv "$1"manifest.csv "$1""$now"-manifest.csv
else
    echo "chunk data has error at $(date) $?"
fi
printf "\n"
echo "< ++++++ Split car files have done! at $(date) ++++++>"
printf "\n"

echo "< ++++++ Upload CAR files to storage with qshell ++++++>"
mv "$1"* /fcfs/

sleep 20
wait $!
printf "\n"
echo "< ------ Congrats! All the tasks have finished! at $(date)------> "
