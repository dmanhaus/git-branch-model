if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply name of new feature as argument, e.g.: bash features/01-create-feature-branch.sh [new-feature-name]"
  else
    git checkout -b $1 develop
fi
