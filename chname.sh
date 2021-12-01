#!/bin/sh

# variables for options
UPPER=false
LOWER=false
RECURSIVE=false
SUB=false

# read command line arguments
while [ $# -gt 0 ]; do
    key="$1"
    case $key in
        -u | --uppercase)
            UPPER=true
            shift
            ;;
        -l | --lowercase)
            LOWER=true
            shift
            ;;
        -r | --recursive)
            RECURSIVE=true
            shift
            ;;
        -s | --subdirectories)
            SUB=true
            shift
            ;;
        -*)
            # ignore every other command line argument
            # implement -h | --help before this
            shift
            ;;
        *)
            # assume that all options precede file names
            break
            ;;
    esac
done

while [ $# -gt 0 ]; do
    
    # pop first positional variable
    key=$1


    # construct 'find' command based on options provided
    # for non-recursive find, maxdepth is used
    # maxdepth is a global option, it needs to be written first
    FI="find $1 -type f"
    if [ "$SUB" = "true" ]
    then
        FI="find $1 -maxdepth 1"
        if [ "$RECURSIVE" = "true" ]
        then
            FI="find $1"
        fi
    else
        FI="find $1 -maxdepth 1 -type f"
        if [ "$RECURSIVE" = "true" ]
        then
            FI="find $1 -type f"
        fi
    fi
    
    shift
    
    # go through each file
    for fname in `$FI | tac`
    do

        # if arfument is a directory, do not change it
        if [ "$fname" = "$key" ]
        then
            if [ ! -f $fname ]
            then
                continue
            fi
        fi

        # get the leaf in the path name and also everything else
        # leaf (fit) and everything else (evelse)
        # echo $fname
        rname=`echo $fname | rev`
        fit=`echo $rname | cut -d"/" -f1`
        lnt=${#fit}
        evelse=`echo $rname | cut -c $lnt-`
        evelse=`echo $evelse | cut -c 2-`
        evelse=`echo $evelse | rev`
        
        # if argument is a file, also get extension
        # the case of the extension is to be preserved
        ext=""
        fit=`echo $fit | rev`
        if [ -f $fname ]
        then

            # check if file has an extension
            # if extension exists, separate it
            case "$fit" in
                *.*)
                    ext=.`echo $fit | cut -d"." -f2`
                    fit=`echo $fit | cut -d"." -f1`
                    ;;
            esac
        fi

        # code to change to uppercase
        # if both -u and -l are given, -u takes precedence
        if [ "$UPPER" = "true" ]
        then
            casse=`echo "$fit" | sed 's/.*/\U&/'`
            if [ $fit != $casse ]
            then
                mv $fname $evelse$casse$ext
            fi

        # code to change to lowercase
        elif [ "$LOWER" = "true" ]
        then
            casse=`echo "$fit" | sed 's/.*/\L&/'`
            if [ $fit != $casse ]
            then
                mv $fname $evelse$casse$ext
            fi
        fi
    done
done
