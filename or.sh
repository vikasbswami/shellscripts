#!/bin/bash
echo "Please Enter a lowercase character"
read var
if [ `echo $var | wc -c` -eq 2 ]
then
	if [ $var = a -o $var = e -o $var = i -o $var = o -o $var = u ]
	then
		echo "The character is a vowel"
	else
		echo "You didn't entered a vowel"
	fi
else
	echo "Invalid input"
fi
