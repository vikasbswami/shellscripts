#!/bin/bash
echo "Enter a number between 50 and 100:\c"
read num
if [ $num -ge 50 -a $num -le 100 ]
then
	echo "The number is within limits."
else
	echo "The number is off limits."
fi
