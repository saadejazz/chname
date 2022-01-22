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

# -s without -r
if [ $# -eq 0 ]
then
    if [ \( "$RECURSIVE" = "false" \) -a \( "$SUB" = "true" \) ]
    then
        # clear everything from arguments
        while [ $# -gt 0 ]; do
            shift
        done
        
        # set anything just to run the next loop once
        set "hello"
    else
        echo "No files specified"
        exit 1
    fi
fi

while [ $# -gt 0 ]; do
    # need some code to print error if invalid file/dir name

    # pop first positional variable
    key="$1"
    shift

    # construct 'find' command if needed
    FI=$key
    search=$FI
    if [ "$RECURSIVE" = "true" ]
    then
        FI="find $key"
        if [ "$SUB" = "false" ]
        then
            FI="find $key -type f"
        fi
        search=`$FI | tac`
    else
        if [ "$SUB" = "true" ]
        then
            search=`find -maxdepth 1 -type d`
        fi
    fi
 
    # go through each file
    for fname in $search
    do
        # get the leaf (fit) in the path name and also everything else (evelse)
        fit="$(basename "${fname}")"
        evelse="$(dirname "${fname}")"/
        
        # if argument is a file, also get extension to preserve its case
        ext=""
        if [ -f $fname ]
        then
            # check if file has an extension, if so, separate it
            case "$fit" in
                *.*)
                    ext=."${fit#*.}"
                    fit="${fit%%.*}"
                    ;;
            esac
        fi

        # if both -u and -l are given, -u takes precedence
        if [ "$UPPER" = "true" ]
        then
            casse=`echo "$fit" | sed 's/.*/\U&/'`
        elif [ "$LOWER" = "true" ]
        then
            casse=`echo "$fit" | sed 's/.*/\L&/'`
        else
            casse=`echo "$fit"`
        fi

        # changing case if needed
        if [ $fit != $casse ]
        then
            mv $fname $evelse$casse$ext
        fi
    done
done
