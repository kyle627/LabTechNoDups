#! /bin/bash

# Kyle Evangelisto
# nodups - check for duplicate files in folders (incomplete)
#
# D. Provine, 17 Nov 2011

# Check for right number of arguments
if (( $# != 2 )); then
    echo "usage: nodups dir1 dir2"
    echo "dir1 and dir2 are directories with files in them."
    echo "all files in dir2 which already exist in dir1 are removed."
    exit
fi


if [[ -d $1 ]] #check $1 is a folder
then
    if [[ -d $2 ]] #check $2 is a folder
    then
        if [[ "$1" != "$2" ]]; #check $1 and $2 are not the same folder
        then
            if [[ "$1" > "0" ]]; #check $1 has more than 0 files
            then
                for file in $1/*; do #for each file in $1 .txt not necessary
                     file=$(basename "$file")
                     if [ -f "$2/$file" ];
                     then
                         cmp -s "$1/$file" "$2/$file" #utilize compare status
                         status=$?
                         if [ "$status" -eq 0 ]; #0 means same
                         then
                             echo "$1/$file : $2/$file matches - removing from $2" # match test script
                         elif [ "$status" -eq 1 ]; #1 means not the same
                         then
                             echo "$1/$file : $2/$file exists but contents differ" #match test script
                         fi
                     else
                         echo "$1/$file: no $file in $2" #otherwise not there
                     fi
                done
            else
                echo "$1 has no files" #match test script
            fi
        else
            echo "Same directory specified twice.  Disaster results." #match test script
        fi
    else
        echo "$2 is not a directory." #match test script
    fi
else
    echo "$1 is not a directory." #match test script
fi