#!/bin/sh

# test script

PASSED=true

# create a simple test folder with a weird name, assume that it doesnt already exist
MAIN_DIR="test_special_123"
mkdir $MAIN_DIR
echo "Created a directory to perform tests in: $MAIN_DIR"

# test a file and a directory for simple lowercase and uppercase
echo
echo "Starting testing"
echo "Testing use case: chname -u <FILE_NAME> <DIRECTORY_NAME>"
touch $MAIN_DIR/file.xy
mkdir $MAIN_DIR/dir
echo "Created a file $MAIN_DIR/file.xy and a directory $MAIN_DIR/dir"
echo "Running command..."
./chname.sh -u $MAIN_DIR/file.xy $MAIN_DIR/dir
echo "Verifying the result"
if [ -f $MAIN_DIR/FILE.xy -a -d $MAIN_DIR/DIR ]
then
    echo "Test for simple uppercase passed! :)"
else
    echo "Test for simple uppercase failed! :("
fi
echo "Testing the same for lowercase"
./chname.sh -l $MAIN_DIR/FILE.xy $MAIN_DIR/DIR
echo "Verifying the result"
if [ -f $MAIN_DIR/file.xy -a -d $MAIN_DIR/dir ]
then
    echo "Test for simple lowercase passed! :)"
else
    echo "Test for simple lowercase failed! :("
    PASSED=false
fi

# testing recursive
echo
echo "Testing recursive"
echo "Testing use case: chname -r -u <DIRECTORY_NAME>"
mkdir -p $MAIN_DIR/dir/dir/dir
touch $MAIN_DIR/dir/dir/dir/file.xy
echo "Created a file: $MAIN_DIR/dir/dir/dir/file.xy"
echo "Running command..."
./chname.sh -r -u $MAIN_DIR/dir
echo "Verifying the result"
if [ -f $MAIN_DIR/dir/dir/dir/FILE.xy ]
then
    echo "Test for recursive uppercase passed! :)"
else
    echo "Test for recursive uppercase failed! :("
    PASSED=false
fi

# testing recursive subdirectories
echo
echo "Testing recursive subdirectories"
echo "Testing use case: chname -r -s -u <DIRECTORY_NAME>"
echo "Running command..."
./chname.sh -r -s -u $MAIN_DIR/dir
echo "Verifying the result"
if [ -f $MAIN_DIR/DIR/DIR/DIR/FILE.xy ]
then
    echo "Test for recursive subdirectories passed! :)"
else
    echo "Test for recursive subdirectories failed! :("
    PASSED=false
fi

# testing subdirectories without recursive
echo
echo "Testing subdirectories without recursive"
echo "Testing use case: chname -s -l <DIRECTORY_NAME>"
cp chname.sh $MAIN_DIR/chname.sh
chmod +x $MAIN_DIR/chname.sh
echo "Created a copy of the script inside the test directory"
echo "This is to avoid unnecessary changes in the current dir"
echo "Also provided execution permissions"
echo "Running command..."
cd $MAIN_DIR
./chname.sh -s -l
cd ..
echo "Verifying the result"
if [ -d $MAIN_DIR/dir ]
then
    echo "Test for subdirectories w/o recursive passed! :)"
else
    echo "Test for subdirectories w/o recursive failed! :("
    PASSED=false
fi

# checking errors
echo
echo "Testing working for invalid argument"
echo "Testing use case: chname -l <INVALID_FILE>"
echo "Running command..."
echo "An error message should be printed for invalid file"
./chname.sh -l $MAIN_DIR/MIR

# check if help is working
echo
echo "Tesing help command"
echo "Running command..."
echo "A help message should appear."
./chname.sh -h

if [ "$PASSED" = "true" ]
then
    echo "All verifiable tests passed. Hooray!!"
else
    echo "Some tests failed. :("
fi

# clean up -- remove the main directory
rm -R $MAIN_DIR