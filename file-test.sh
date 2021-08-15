#!/bin/bash
echo "Enter a name:\c"
read fname
if [ -b $fname ]
then
	echo "File is a block file."
else
	echo "File is a non block file."
fi
