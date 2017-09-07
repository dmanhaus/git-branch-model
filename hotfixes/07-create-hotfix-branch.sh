if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply major/minor/hotfix release version number as argument, e.g.: bash features/07-create-hotfix-branch.sh [major release number].[minor rel num].[hotfix rel num]"
  else
    git checkout -b hotfix-$1 master
    bash ./releases/07a-bump-version.sh $1
    git add .
    git commit -a -m "Bumped version number to "$1
fi

