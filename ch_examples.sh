red=`tput setaf 1`
yell=`tput setaf 3`
blu=`tput setaf 4`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${red}This is chname examples file"
echo "Two Extra Subdirectories Tree will also created which will not be in use. If you need to test something else than what will
be presented here in example file, please use those subdirectories named as 'Electrical' and 'aerospace'... You will have the option
to keep or discard all the files and subdirectories at the very end... You can always press CTRL+C to stop the furhter execution....."
path=`pwd`

#Creating Files in Main Directory
touch "${path}/ALEKSandra"
touch "${path}/TOMAsz"

#Creating Directories for examples
mkdir "${path}/Robotics"
touch "${path}/Robotics/Computer Vision"
touch "${path}/Robotics/Signals Processing"
mkdir "${path}/Robotics/Modelling and Control"
touch "${path}/Robotics/Modelling and Control/joanna"
touch "${path}/Robotics/Modelling and Control/gania"
mkdir "${path}/Robotics/Modelling and Control/grades"
mkdir "${path}/Robotics/Real Time Systems"
touch "${path}/Robotics/Real Time Systems/tonny"
touch "${path}/Robotics/Real Time Systems/thomas"


mkdir "${path}/Electrical" 
touch "${path}/Electrical/DSP"
touch "${path}/Electrical/SIGNALS"
mkdir "${path}/Electrical/ELECTRONICS FUNDAMENTALS"
touch "${path}/Electrical/ELECTRONICS FUNDAMENTALS/Naela Hashmi"
touch "${path}/Electrical/ELECTRONICS FUNDAMENTALS/Perry James"
mkdir "${path}/Electrical/ELECTRONICS FUNDAMENTALS/grades"
mkdir "${path}/Electrical/HIGH VOLTAGE"
touch "${path}/Electrical/HIGH VOLTAGE/Micheal"
touch "${path}/Electrical/HIGH VOLTAGE/James Andersen"

mkdir "${path}/Mechanical" 
touch "${path}/Mechanical/Statics"
touch "${path}/Mechanical/Dynamics"
mkdir "${path}/Mechanical/THERMODYNAMICS"
touch "${path}/Mechanical/THERMODYNAMICS/MICHEAL STARK"
touch "${path}/Mechanical/THERMODYNAMICS/BAIRSTOW"
mkdir "${path}/Mechanical/THERMODYNAMICS/grades"
mkdir "${path}/Mechanical/MANUFACTURING PROCESSES"
touch "${path}/Mechanical/MANUFACTURING PROCESSES/OLA"
touch "${path}/Mechanical/MANUFACTURING PROCESSES/KASIA"

mkdir "${path}/aerospace"
mkdir "${path}/aerospace/aeroplance"
mkdir "${path}/aerospace/helocopter"
mkdir "${path}/aerospace/codcopter"
mkdir "${path}/aerospace/gun"


read -p "${reset}Press [Enter] Key to Start the Testing Section ..."

#Code Testing Section

#Lowercasing Test
echo "${yell}"
echo -e "\nTESTING THE LOWER CASE'\n"
./chname.sh -l TOMAsz ALEKSandra

#Uppercasing Test
read -p "${reset}Press [Enter] key to resume ..."
echo "${green}"
echo -e "\nTESTING THE UPPER CASE\'\n"
./chname.sh -u tomasz aleksandra

#Testing Recursive with lowercase
read -p "${reset}Press [Enter] key to resume ..."
echo "${yell}"
echo -e "\nTESTING THE RECURSIVE WITH LOWER CASE\n"
./chname.sh -r -l Mechanical Robotics ALEKSANDRA TOMASZ

#Testing Recursive with uppercase
# read -p "${reset}Press [Enter] key to resume ..."
# echo "${green}"
# echo -e "\nTESTING THE RECURSIVE WITH UPPER CASE\n"
# ./chname.sh -u mechanical -r aleksandra tomasz robotics  #Code work with every placement of positional arguments


#Testing Recursive and Subdirectories with lowercase 
read -p "${reset}Press [Enter] key to resume ..."
echo "${yell}"
echo -e "\nTESTING THE RECURSIVE AND SUBDIRECTORIES WITH LOWER CASE\n"
./chname.sh -s -r -l mechanical ALEKSANDRA TOMASZ robotics  #Code work with every placement of positional arguments


#Testing Recursive and Subdirectories with uppercase 
read -p "${reset}Press [Enter] key to resume ..."
echo "${green}"
echo -e "\nTESTING THE RECURSIVE AND SUBDIRECTORIES WITH UPPER CASE\n"
./chname.sh -s -r -u mechanical aleksandra tomasz robotics  #Code work with every placement of positional arguments

#Testing with * to change all files with same name
read -p "${reset}Press [Enter] key to resume ..."
echo "${yell}"
echo -e "\nTESTING THE * CASE TO CAPITALIZE THE FILES WITH THE STARTING 'b'\n"
touch banana ball mobile biscuit desk brown window bench
read -p "${reset}Please Check...The New Testing Files are Created...Press [Enter] key to resume ..."
echo "${yell}"
./chname.sh -u b* 
read -p "${reset}Please Allow Me to Delete The Testing Files Created For This Test...Press [Enter] key to resume ..."
rm B* mobile desk window

# Error Testing Section

#If No Directional Positional Arguments are given
echo -e "\n"
read -p "${reset}Lets Move Towards Error Section....Press [Enter] key to resume ..."
echo -e "${yell}If no directional argument (-l, -u, -r, -s) is selcted"
echo "${red}"
./chname.sh TOMASZ MECHANICAL

#If no file or directory is provided
read -p "${yell}.IF No File is Provided in Positional Arguments....${reset}Press [Enter] key to resume ..."
echo "${red}"
./chname.sh -r -u


#IF the file is already in the same alphatical structure as required
read -p "${yell}.IF the file is in same alphabetical structure as required....${reset}Press [Enter] key to resume ..."
echo "${red}"
./chname.sh -u TOMASZ MECHANICAL

#If Two of the Comparative Arguments are Seclected (-u and -l)
read -p "${yell}IF Two of the Comparative Arguments are Seclected (-u and -l)....P${reset}ress [Enter] key to resume ..."
echo "${red}"
./chname.sh -l -u TOMASZ MECHANICAL

#Help Section
read -p "${yell}Do You Need Guidance, We have the Help Section for You....${reset}Press [Enter] key to see the Help Section ..."
echo "${yell}"
./chname.sh -h

#Delection of Created Files
echo -e "\n\n${green}That was All... Let's Now Delete the Files and Subdirectories We Have Created"
read -p "${reset}Press [Enter] key to delete the files and subdirectories... or
	... Press CTRL+C to end the session and keep the files and subdirectories"



#Deleting the Directories
rm -r "${path}/ROBOTICS"
rm -r "${path}/Electrical"
rm -r "${path}/mechanical"
rm -r "${path}/aerospace"
rm tomasz ALEKSANDRA 



















