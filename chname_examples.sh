#!/bin/sh

# test script

echo "Starting testing..."
echo
echo "The script will create test folders and files in the current directory"
echo "The created folders and files would be deleted upon completion of tests"
echo "It must be noted that the extensions of the files are always preserved."
echo "At any point in the test, press Keyboard Interrupt to exit. This will not
delete the created folders. Manual deletion would be required."
echo "press [ENTER] to continue"
read continue

# making the testing tree (lower and upper case)
LROOTNAME="test_directory"
UROOTNAME="TEST_DIRECTORY"

echo
echo "Creating testing tree with root folder name: $LROOTNAME"
mkdir -p $LROOTNAME/style/work/helium/elements
mkdir -p $LROOTNAME/studio/server/
mkdir -p $LROOTNAME/work/loop/
mkdir -p $LROOTNAME/names/

touch $LROOTNAME/studio/file.xy
touch $LROOTNAME/names/saad.csv
touch $LROOTNAME/names/adele.vsx
touch $LROOTNAME/names/hugo.cfg
touch $LROOTNAME/names/maria.pln
touch $LROOTNAME/work/korea.xyz
touch $LROOTNAME/work/kowa.xyz
touch $LROOTNAME/work/koee.xyz
touch $LROOTNAME/style/work/helium/elements/joker.py

echo "Folders and files created. You can see all the files below"
echo
find $LROOTNAME
echo
echo "press [ENTER] to continue"
read continue

# testing simple uppercase
echo "Testing simple uppercase for folder and file"
echo "Running command: chname.sh -u $LROOTNAME/names/saad.csv $LROOTNAME/names"

./chname.sh -u $LROOTNAME/names/saad.csv $LROOTNAME/names

echo "The file and folder mentioned above would be changed to $LROOTNAME/names/SAAD.csv and $LROOTNAME/NAMES"
echo "Verifying automatically..."

if [ -f "$LROOTNAME/NAMES/SAAD.csv" -a -d "$LROOTNAME/NAMES" ]
then
    echo "Test for simple uppercase passed"
else
    echo "Test for simple uppercase failed"
fi

echo "You can manually verify and then continue."
echo "press [ENTER] to continue"
read continue

# testing simple lowercase
echo "Testing simple lowercase for folder and file"
echo "Running command: chname.sh -l $LROOTNAME/NAMES/SAAD.csv $LROOTNAME/NAMES"

./chname.sh -l $LROOTNAME/NAMES/SAAD.csv $LROOTNAME/NAMES

echo "The file and folder mentioned above would be changed to $LROOTNAME/names/saad.csv and $LROOTNAME/names"
echo "Verifying automatically..."

if [ -f "$LROOTNAME/names/saad.csv" -a -d "$LROOTNAME/names" ]
then
    echo "Test for simple lowercase passed"
else
    echo "Test for simple lowercase failed"
fi

echo "You can manually verify and then continue."
echo "press [ENTER] to continue"
read continue

# testing multiple file input with asterisk
echo "Testing uppercase with multiple file names (given with asterisk)"
echo "Running command: chname.sh -u $LROOTNAME/work/ko*"

./chname.sh -u $LROOTNAME/work/ko*

echo "All the files in the folder $LROOTNAME/work/ start with ko and will be changed to uppercase"
echo "Verifying automatically..."

# just checking one file as it is enough to
if [ -f "$LROOTNAME/work/KOWA.xyz" ]
then
    echo "Test for multiple files (with *) passed"
else
    echo "Test for multiple files (with *) failed"
fi

echo "You can manually verify and then continue."
echo "press [ENTER] to continue"
read continue


# testing recursive functionality
echo "Testing recursive functionality"
echo "Running command: chname.sh -r -u $LROOTNAME"

./chname.sh -r -u $LROOTNAME

echo "Every file in folder tree created (even inside subdirectories) would be converted to uppercase"
echo "Verifying automatically..."

# checking only to files as its enough
if [ -f "$UROOTNAME/studio/FILE.xy" -a -f "$UROOTNAME/style/work/helium/elements/JOKER.py" ]
then
    echo "Test for recursive passed"
else
    echo "Test for recursive failed"
fi

echo "You can manually verify and then continue."
echo "press [ENTER] to continue"
read continue

# testing recusive functionality with subdirectories
echo "Testing recursive functionality with subdirectories"
echo "Running command: chname.sh -r -s -u $UROOTNAME"

./chname.sh -r -s -u $UROOTNAME

echo "Every file and folder in folder tree created (even inside subdirectories) would be converted to uppercase"
echo "Verifying automatically..."

# checking only to files as its enough
if [ -f "$UROOTNAME/STUDIO/FILE.xy" -a -f "$UROOTNAME/STYLE/WORK/HELIUM/ELEMENTS/JOKER.py" ]
then
    echo "Test for recursive subdirectories passed"
else
    echo "Test for recursive subdirectories failed"
fi

echo "You can manually verify and then continue."
echo "press [ENTER] to continue"
read continue

# testing all errors
echo "Now, we will test error cases"
echo
echo "For providing invalid file/folder arguments"
echo "Running chname.sh -l $LROOTNAME"
echo "Error printed: "
echo
./chname.sh -l $LROOTNAME
echo

echo "For providing no arguments"
echo "Running chname.sh -l -s -r"
echo "Error printed: "
echo
./chname.sh -l -s -r
echo

echo "For providing none of uppercase or lowercase"
echo "Running chname.sh -r -s $UROOTNAME"
echo "Error printed: "
echo
./chname.sh -r -s $UROOTNAME
echo

echo "It must be noted that the following functionalities are not considered erroronous"
echo "When both -u and -l are provided, -u takes precedence"
echo "If the case of the argument is already as desired, it will be ignored without any error message"
echo
echo "press [ENTER] to continue"
read continue

# help message
echo "Running help message: chname.sh -h"
./chname.sh -h

echo "All tests are finished. Press [ENTER] to delete created folder and exit."
read continue

rm -R $UROOTNAME