#!/bin/bash
echo "Enter a name:\c"
read fname
if [ -c $fname ]
then
	echo "File is a character special file."
else
	echo "File is a non character special file."
fi
