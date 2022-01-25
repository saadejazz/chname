#!/bin/sh

key="example1"

fname="example2/example1/Magic1.sh"


rname=`echo $fname | rev`
fit=`echo $rname | cut -d"/" -f1`
lnt=${#fit}
echo $lnt
evelse=`echo $rname | cut -c $lnt-`
evelse=`echo $evelse | cut -c 2-`
evelse=`echo $evelse | rev`
ext=""
fit=`echo $fit | rev`
if [ -f $fname ]
then
    case "$fit" in
        *.*)
            ext=.`echo $fit | cut -d"." -f2`
            fit=`echo $fit | cut -d"." -f1`
            ;;
    esac
fi


echo $fit $evelse $ext
# echo $line


# IFS='/' ?read arr < "$fname"
# echo $fname


# for entry in `find example2/`
# do
#     IFS='/' read -ra pat < "$entry"
#     LAST="${pat[-1]}"
#     unset arr[-1]
#     printf -v joined '%s/' "${pat[@]}"
#     echo $joined
# done