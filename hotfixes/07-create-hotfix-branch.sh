git checkout -b hotfix-$1 master
bash ./releases/07a-bump-version.sh $1
git add .
git commit -a -m "Bumped version number to "$1