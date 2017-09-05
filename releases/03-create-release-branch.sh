git checkout -b release-$1 develop
bash ./releases/03a-bump-version.sh $1
git add .
git commit -a -m "Bumped version number to " += $1