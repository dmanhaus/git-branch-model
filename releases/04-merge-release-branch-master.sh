git checkout master
git merge --no-ff release-$1
git tag -a $1
git push origin $1