if [ -z "$1"]
  then 
    echo "MISSING ARGUMENT - Must supply name of hotfix branch as argument, e.g.: bash releases/09a-merge-hotfix-branch-develop.sh hotfix-[major release number].[minor rel num].[hotfix rel num]"
  else
    git checkout develop
    git merge --no-ff hotfix-$1
fi