if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply name of hotfix branch as argument, e.g.: bash releases/08-merge-hotfix-branch-master.sh release-[major release number].[minor rel num].[hotfix rel num]"
  else
    git checkout master
    git merge --no-ff hotfix-$1
    git tag -a $1
fi
