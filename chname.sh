#!/bin/sh

########################################## Unclear usages ################################################
# These detail usages that are not clear in the prompt. The code is in pure shell as required.
# Have to have weird indentations at some place for newline characters (without tabs) for posix-compliance
# 
# Case: the fate of folder argument in recursive
# chname -r -u <lower_case_folder>
# This code also converts the folder name in the argument to uppercase, in addition to all files inside it
# 
# Case: subdirectories option without recursive
# chname -s -u <file1> <file2>
# This code will uppercase all folder names in its current directory (caution advised) and also uppercase
# the file arguments
# 
# when converting case, the extensions are always preserved.
# 

# variables for options
UPPER=false
LOWER=false
RECURSIVE=false
SUB=false

# function for help message
help_text(){
    echo "
    Usage: chname  [-r|--recursive] [-s|--subdirectories] [-l|--lowercase|-u|-uppercase] <dir/file names...>
    chname  [-h|--help]
    
    This script is dedicated to lowerizing (-l or --lowercase) file and directory names or uppercasing (-u or
    --uppercase) file and directory names given as arguments.
    
    Changes may be done either with recursion (for all the files in subdirectories '-r' or --recursive) or 
    without it.  In recursive mode changes may affect only regular file names  or  subdirectory names 
    (if with '-s' or --subdirectories) as well.  Option -s without -r allows modification of directory names 
    in the current directory. Option -h (or --help) should print help message.
    "
}

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
        -h | --help)
            help_text
            exit 0
            ;;
        -*)
            # ignore every other command line argument
            shift
            ;;
        *)
            # assume that all options precede file names
            break
            ;;
    esac
done

# -s without -r
FLAG=false
if [ $# -eq 0 ]
then
    if [ \( "$RECURSIVE" = "false" \) -a \( "$SUB" = "true" \) ]
    then
        # set anything just to run the next loop once
        set "hello"
        FLAG=true
    else
        echo "No files specified."
        exit 1
    fi
fi

# if both -u and -l are given, -u takes precedence
if [ \( "$UPPER" = "true" \) -a \( "$LOWER" = "true" \) ]
then
    echo "Both uppercase and lowercase options provided. Uppercase takes precedence."
fi

# if none of -u and -l are given, -u takes precedence
if [ \( "$UPPER" = "false" \) -a \( "$LOWER" = "false" \) ]
then
    echo "None of uppercase or lowercase options provided."
    exit
fi

while [ $# -gt 0 ]; do

    # pop first positional variable
    key="$1"

    # check if argument is valid or not
    if [ \( "$RECURSIVE" = "true" \) -o \( "$SUB" = "false" \) ]
    then
        shift
    fi

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
        if [ \( "$SUB" = "false" \) -a -d $key ]
        then
            # have to add newline (posix compliant way)
            search="$search
$key"
        fi
    else
        if [ "$SUB" = "true" ]
        then
            echo "-s is specified without -r"
            echo "folders in the current directory will be changed"
            echo "Caution is advised. Press [ENTER] to continue"
            read continue
            search=`find -maxdepth 1 -type d`
            while [ $# -gt 0 ]; do
                search="$search
$1"
                shift
            done
        fi
    fi

    # to cater for spaces in files and folder names
    # the indentation is intentional
    OLDIFS=$IFS
    IFS='
'
 
    # go through each file
    for fname in $search
    do
        if [ ! -f $fname -a ! -d $fname ]
        then
            if [ "$FLAG" = "false" ]
            then
                echo "$fname is not a valid file or directory."
            fi
            continue
        fi

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

        # convert case
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

    IFS=$OLDIFS
done