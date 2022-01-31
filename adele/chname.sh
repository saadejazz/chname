#!/bin/bash
# command options and arguments interpreter example
# simple version

help_text(){
    echo "
    Usage: chname  [-r|--recursive] [-s|--subdirectories] [-l|--lowercase|-u|-uppercase] <dir/file names...>
    chname  [-h|--help]
    
    The aim of this is script is to lowerizing (-l or --lowercase) file and directory names or uppercasing (-u or
    --uppercase) file and directory names given as arguments.
    
    Changes has to be done either with recursion (for all the files in subdirectories '-r' or --recursive) or
    without it.  In recursive mode changes may affect only regular file names  or  subdirectory names
    (if with '-s' or --subdirectories) as well.  Option -s without -r allows modification of directory names
    in the current directory. Option -h (or --help) should print help message.
    "
}

upper_lower(){
    file=$1

    leaf="$(basename "${file}")"
    path="$(dirname "${file}")"
    # echo $leaf $path
    if test $up = "t"
    then
        result=`echo $leaf | tr '[:lower:]' '[:upper:]'` # uppercase all characters
        if test $leaf != $result
        then
            mv $file $path/$result
        fi
    elif test $low = "t"
    then
        result=`echo $leaf | tr '[:upper:]' '[:lower:]'` # lowercase all characters
        if test $leaf != $result
        then
            mv $file $path/$result
        fi
    fi
}


# the name of the script without a path
name=`basename $0`


#function printing error messages to diagnostic output
error_msg(){
    echo "$name: error :$1" 1>&2
}

#if no arguments were given
if test -z "$1"
then
cat<<EOT 1>&2

usage:
$name [[-r|--recursive] [-s|--subdirectories] [-l|--lowercase|-u|--uppercase]] <dir/file names ...>


EOT
fi

#do with command line arguments
rec=f
sub=f
low=f
up=f

while test "x$1" != "x"
do
    key="$1"
    case $key in
        -r | --recursive)
            rec=t
            shift;;
        -s | --subdirectories)
            sub=t
            shift;;
        -l | --lowercase)
            low=t
            shift;;
        -u | --uppercase)
            up=t
            shift;;
        -*)
            error_msg "bad option $1";
            shift;;
        *)
            # echo "arg: $1"
            break;;
    esac
done

#Cycle that check for the options
while test "x$1" != "x"
do
    # non recursive
    if test $rec = f
    then
        upper_lower $1
        shift
    else
         if test $sub = t
         then
            echo "SUB enabled"
            #Find setting
            FIND="find $key"
        else
            echo "SUB disabled"
               #Find setting
               FIND="find $key -type f"
        fi
        shift
        searcher=`$FIND | perl -e "print reverse(<>)"`
        echo $searcher
        echo
        for file in $searcher; do
            upper_lower $file
            echo $file
          done
    fi
done