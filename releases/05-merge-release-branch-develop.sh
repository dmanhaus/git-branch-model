if [ -z "$1"]
  then 
    echo "MISSING ARGUMENT - Must supply name of release branch as argument, e.g.: bash releases/05-merge-release-branch-develop.sh release-[major release number].[minor release number]"
  else
    git checkout develop
    git merge --no-ff release-$1
fi

