#!/bin/bash
#This script takes the name of a branch and simply interated through all the repositories in the foder "codebase" 
#and switched them to the corresponding branch.

for d in $(ls $CODEBASE)
do
    cd ${CODEBASE}/$d
    if git branch ; then
    	if git checkout $1 ; then
    		echo "Checked Out $1 in $d"
    	else
    		# Used for initialization purpose
    		echo "Shouldn't be here"
    	fi
    else
    	echo "No GIT repository in $d"
    	#Used for initialization purpose
    fi
done
