#!/bin/bash
echo "Please enter a character:\c"
read var
if [ `echo $var | wc -c` -eq 2 ]
then
	echo "You entered a character."
else
	echo "Invalid input."
fi
