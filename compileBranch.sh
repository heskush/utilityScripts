#!/bin/bash
#find . -maxdepth 1 -type d  | xargs -I {} bash -c 'cd {}; git branch; git checkout master; git pull '

repositories=(common tools dataingestion recordreader datamodel-metadata datamodel)
compileCode=false
pullBranch=false
branchName=master


if [ $# == 0 ] ; then
	echo "USAGE: $0 -b <NameOfBranch> [OPTIONS]
  -b <branchName>----------------------------------Checks out branchName in all the repositories
  where OPTIONS is one of the following
  -p-------------------------------------------------Does 'git pull' after checking out the branch. Prompts the user for password.
  -c-------------------------------------------------Compiles the code by running the 'build.sh' script
  -n <Comma delimited repositories>---------------Limits the action to the provided repositories";
  exit
fi


validateRepositoryNames(){
	repoArray=$(echo $1 | tr "," "\\n")
	for repoName in $repoArray
	do
		if [[ ! " ${repositories[@]} " =~ " ${repoName} " ]]; then
			echo -e "\033[1;31m ERROR: \033[0m ${repoName} is not a valid repository name"
		    exit
		fi
	done
	repositories=("${repoArray[@]}")
	echo ${repoArray[*]}
	echo ${repositories[*]}
	echo $repositories
}


while getopts "b:pcn:" opt; do
case $opt in 
	b) branchName=${OPTARG} ;;
    p) pullBranch=true;;
    c) compileCode=true;;
    n) validateRepositoryNames $OPTARG ;;
esac 
done

for repoName in "${repositories[@]}"
do 
echo $repoName
	if cd $CODEBASE/$repoName;then
		echo -e " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~INSIDE $repoName ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		git stash
		if git checkout $branchName;then
			if [ $pullBranch == true ] ; then
				 git pull 
			fi
			if [ $compileCode == true ]; then
				if [$repoName==recordreader]; then
					sh ./recordreader/build.sh -Pprod
				else
					./build.sh -Pprod
				fi	
			fi

		else
			echo -e "\033[1;31mCOULD NOT SWITCH TO $branchName INSIDE $repoName.\033[0m"
		fi
	else
		echo -e "\033[1;31m PATH FOR REPOSITORY $repoName IS INCORRECT. \033[0m"
	fi
done




