#!/bin/bash

#Description: demostrate and test chname

#assume that it is in the same directory as chname.sh
echo "Testing for the chname.sh"

echo "First: CREATE FILES AND DIRECTORIES"

read -r -s -p $'Press enter to continue...'
echo
mkdir Names Animals Countries 
echo "directories created: Names Animals Countries"
touch Ops Lik Med Luc 
echo "files created: Ops Lik Med Luc"

mkdir Names/Boy Names/Girl
echo "directories Name/ : Boy Girl"
echo "file Name/ : Indigo"
touch Names/Indigo
touch Names/Boy/Jhon Names/Boy/Thomas Names/Boy/Saad Names/Boy/Hugo 
echo "files Boy/ : Jhon Thomas Saad Hugo"
touch Names/Girl/Mery Names/Girl/Lucy Names/Girl/Adele Names/Girl/Sara  
echo "files Girl/ : Mery Lucy Adele Sara"

mkdir Animals/Mammals Animals/Birds Animals/Fish
echo "directories Animals/ : Mammals Birds Fish"
mkdir Animals/Mammals/Vivip Animals/Mammals/Ovovivip
echo "directories Mammals/ : Vivip Ovovivip"
touch Animals/Mammals/Ovovivip/platyplus
touch Animals/Mammals/Vivip/cow
echo "files Ovovivip/: platyplus"
echo "files Vivip/: cow"
touch Animals/Birds/parrot Animals/Birds/mockingjay
echo "Birds/ : parrot mockingjay"
touch Animals/Fish/salmon
echo "Fish/ : salmon"

mkdir Countries/France Countries/Poland Countries/Spain
echo "Countries/ : France Poland Spain"
touch Countries/France/Paris Countries/France/Nantes Countries/France/Lyon
echo "France/ : Paris Nantes Lyon"
touch Countries/Poland/Warsaw Countries/Poland/Krakow Countries/Poland/Gdansk
echo "Poland/ : Warsaw Krakow Gdansk"
touch Countries/Spain/Madrid Countries/Spain/Barcelona
echo "Spain/ : Madrid Barcelona"


#TESTING
read -r -s -p $'Press enter'
echo
echo "All files and directories created. "

read -r -s -p $'Press enter'
echo
echo "TESTING WITH LOWERCASE:"
echo "-l Ops Lik Names/Indigo"
read -r -s -p $'Press enter to continue'
echo
# -l 
./chname.sh -l Ops Lik Names/Indigo

read -r -s -p $'Press enter'
echo
echo "TESTING WITH UPERCASE"
echo "-u Med Animals/Mammals/Vivip/cow"
read -r -s -p $'Press enter to continue'
echo
# -u
./chname.sh -u Med Animals/Mammals/Vivip/cow

read -r -s -p $'Press enter'
echo
echo "TESTING WITH LOWERCASE AND RECURSIVE: will change file names"
echo "-r -l MED Luc Animals/ Countries/"
read -r -s -p $'Press enter to continue'
echo
# -r -l
./chname.sh -r -l MED Luc Animals/ Countries/ 

read -r -s -p $'Press enter'
echo
echo "TESTING WITH UPPERCASE RECURSIVE AND SUBDIRECTORIES: will change files and directories"
echo "-r -s -u med ops Names/ Countries/"
read -r -s -p $'Press enter to continue'
echo
# -r -s -l
./chname.sh -r -s -u med ops Names/ Countries/

read -r -s -p $'Press enter'
echo
echo "TESTING WITH * TO CHANGE ALL FILES STARTING WITH J"
echo "Create files in current directory: Journey Joy Jingle Abstrac"
read -r -s -p $'Press enter to continue'
echo
touch Journey Joy Jingle Abstrac
echo "-l J*"
read -r -s -p $'Press enter to continue'
echo
./chname.sh -l J*


#ERROR TESTING
read -r -s -p $'Press enter'
echo
echo "All correct testing done."

read -r -s -p $'Press enter'
echo
echo "ERROR TESTING WITH NO UPPER OR LOWERCASE SPECIFIED"
echo "./chname.sh Abstract"
read -r -s -p $'Press enter to continue'
echo
./chname.sh Abstract

read -r -s -p $'Press enter'
echo
echo "ERROR TESTING WITH NO FILES OR DIRECTORY SPECIFIED"
echo "./chname.sh -l "
read -r -s -p $'Press enter to continue'
echo
./chname.sh -l   

read -r -s -p $'Press enter'
echo
echo "ERROR TESTING WITH BOTH UPPER AND LOWERCASE"
echo "./chname.sh -u -l Abstract"
read -r -s -p $'Press enter to continue'
echo
./chname.sh -u -l Abstract

read -r -s -p $'Press enter'
echo
echo "HELP SECTION"
echo "./chname.sh -h"
read -r -s -p $'Press enter to continue'
echo
./chname.sh -h

read -r -s -p $'Press enter to finish'
echo
echo "Error Testing Successful"

read -r -s -p $'Press enter to delete files and directories created'
echo
rm -r NAMES/ Animals/ COUNTRIES/ 
rm Abstrac jingle journey lik joy luc MED OPS 