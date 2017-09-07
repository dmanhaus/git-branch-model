if [ -z "$1" ]
  then 
    echo "MISSING ARGUMENT - Must supply major/minor release version number as argument, e.g.: bash features/03-create-release-branch.sh [major release number].[minor release number]"
  else
    git checkout -b release-$1 develop
    bash ./releases/03a-bump-version.sh $1
    git add .
    git commit -a -m "Bumped version number to "$1
fi

