#!/bin/bash
echo "Enter a word:\c"
read word
case $word in
[aeiou]* | [AEIOU]*)
			echo "The word begins with a vowel."
			;;
[0-9]*)
			echo "The word begins with a digit."
			;;
*[0-9])
			echo "The word ends with a digit."
			;;
???)
			echo "The word is a three letter word."
			;;
*)
			echo "I don't know what you have entered."
			;;
esac
