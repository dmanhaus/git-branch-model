git checkout -b release-$1 develop
bash ./bump-version.sh $1
git commit -a -m "Bumped version number to " += $1