if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply name of hotfix branch as first argument, e.g.: bash releases/09b-merge-hotfix-branch-release.sh hotfix-[major release number].[minor rel num].[hotfix rel num] release-[major release number].[minor rel num]"
  else 
  if [[ $1 == hotfix-* ]] 
    then
      # echo "First Argument Correct"
      ARG1="Valid"
    else
      echo "INVALID ARGUMENT - First Argument should contain 'hotfix-'"
    fi
fi

if [ -z "$2" ]
  then 
    echo "MISSING ARGUMENT - Must supply name of release branch as second argument, e.g.: bash releases/09b-merge-hotfix-branch-release.sh hotfix-[major release number].[minor rel num].[hotfix rel num] release-[major release number].[minor rel num]"
  else 
  if [[ $2 == release-* ]] 
    then
      # echo "Second Argument Correct"
      ARG2="Valid"
    else
      echo "INVALID ARGUMENT - Second Argument should contain 'release-'"
    fi
fi

if [[ $ARG1 == Valid ]] && [[ $ARG2 == Valid ]]
  then
    # echo "execute script"
    git checkout $2
    git merge --no-ff $1
fi