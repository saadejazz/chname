#!/bin/bash

#Description: change names of files

# the name of the script without a path
name=`basename $0` #scriptname

#to avoid spaces (if directories or file names have spaces)
IFS=$(echo -en "\n\b")

# function for printing error messages to diagnostic output
error_msg() 
{ 
	echo "$name: error: $1" 1>&2 
}

helpfun()
{
	echo "Use: chname  [-r] [-s] [-l|-u] <dir/file names...>
	change names of files by lowerizing (-l| --lowercase) or (-u| --uppercase) file and directory names given as arguments.
	Changes may be done either with recursion (for all the files in subdirectories '-r' or --recursive) or without it.  
	In recursive mode changes may affect only regular file names  or  subdirectory names (if with '-s' or --subdirectories)as well.  
	Option -s without -r allows modification of directory names in the current directory. Option -h (or --help) should print help message.

	-r : recursive 
	-s : subdirectories
	-l : lowercase
	-u : uppercase"
	exit 0

}

# function for changing cases
change_case() 
{ 
	#lower 
	if test $l = "y"
	then
		while test "x$1" != "x";do
			aux=`basename $1` #get the last name 
			a=`echo $aux | tr '[:upper:]' '[:lower:]'` #change to lower
			first=`dirname $1` #get the name of the directory if specified
			total="${first}/${a}" #join together the new lower with the previous
			if test $aux != $a #if it is already low dont change
			then
				if [ -f "$1" -o -d "$1" ] #check that is a file or directoy
				then
					mv $1 $total 
				else 
					error_msg "$1 is not a file or directory"
				fi
			fi
			shift
		done

	#upper
	elif test $u = "y"
	then
		while test "x$1" != "x";do
			aux=`basename $1` #get the last name 
			a=`echo $aux | tr '[:lower:]' '[:upper:]'` #change to lower
			first=`dirname $1` #get the name of the directory if specified
			total="${first}/${a}" #join together the new lower with the previous
			if test $aux != $a #if it is already low dont change
			then    
				if [ -f "$1" -o -d "$1" ] #check that is a file or directoy
				then
					mv $1 $total
				else
					error_msg "$1 is not a file or directory"
				fi
			fi  
			shift
		done
	fi
}


# if no arguments given
if test -z "$1"
then
	cat<<EOT 1>&2

usage:
  $name [-r|--recursive] [-s|--subdirectories] [-l|--lowercase|-u|-uppercase] [-h|--help] <names>

$name correct syntax examples: 
  $name new.c
  $name -l file.c
  $name -r -u  /folder/hello

$name incorrect syntax example: 
  $name -d
  $name -u -l file.c

EOT
fi

# do with command line arguments
r=n
s=n
l=n
u=n
while test "x$1" != "x";do
	case "$1" in
		-r|--recursive) r=y;;
		-s|--subdirectories) s=y;;
		-l|--lowercase) l=y;;
		-u|--uppercase) u=y;;
		-h|--help) helpfun;;
		-*) error_msg "bad option $1"; exit 1 ;;

		#get the names of the files 
		*) break; 
	esac
	shift
done

if test "x$1" = "x"
then
	error_msg "no files or directories introduced"
	exit 1
fi
#check not two options up and low are asked for
if [ $l = "y" ] && [ $u = "y" ]
then 
	error_msg "cannot use -u and -l at the same time"
	exit 1
	#check at least one option up or low are asked for
elif [ $l = "n" ] && [ $u = "n" ]
then 
	error_msg "need to use -u or -l"
	exit 1
fi

#recursive
if test $r = "y"
then
	if test $s = "n" #-r we are only changing the files inside
	then
		while test "x$1" != "x"
		do
			#if we get a file, we change it
			if [ -f "$1" ]
			then
				change_case $1
				#if we get a directory, find all the files inside and change them
			elif [ -d "$1" ]
			then
				all=`find $1 -type f | tac`
				change_case $all
			else
				error_msg "$1 is not a file or directory"
			fi
			shift
		done
		#-s-r we are changing only the directories and files inside
	else
		while test "x$1" != "x";do
			#if we get a file, we change it
			if [ -f "$1" ]
			then
				change_case $1
			elif [ -d "$1" ]
			then
				all="`find $1 | tac`"
				change_case $all
			else
				error_msg "$1 is not a file or directory"
			fi
			shift
		done    
	fi

#non-recursive
else
	change_case $@
	if test $s = "y"
	then
		all=`find . -maxdepth 1 -type d`
		all="${all:2}"
		change_case $all
	fi

fi
