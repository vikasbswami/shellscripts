#!/bin/bash
echo "Enter source and target file names."
read source target
if mv $source $target
then
echo "Your file has been successfully renamed."
else
echo "File could not be renamed."
fi
