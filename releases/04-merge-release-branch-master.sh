if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply version number of release branch as argument, e.g.: bash releases/04-merge-release-branch-master.sh [major release number].[minor release number]"
  else
    git checkout master
    git merge --no-ff release-$1
    git tag -a $1
    git push origin $1
fi

