#!/bin/bash
echo "Welcome to Bob's Burgers"
echo "Plese choose what you want to eat:"

MEALS="Burger Fries Cola"

select OPTION in $MEALS
do
	echo "The selected option is $REPLY"
	echo "The selected meal is $OPTION"
done
