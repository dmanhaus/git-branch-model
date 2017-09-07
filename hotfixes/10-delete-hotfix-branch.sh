if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply name of release branch as argument, e.g.: bash releases/06-delete-release-branch.sh release-[major release number].[minor release number]"
  else
    git branch -d hotfix-$1
fi
