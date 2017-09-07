if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply name of feature branch as argument, e.g.: bash features/02-merge-feature-branch.sh [feature-branch-name]"
  else
    git checkout develop
    git merge --no-ff $1
    git branch -d $1
    git push origin develop
fi

