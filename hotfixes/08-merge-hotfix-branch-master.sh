git checkout master
git merge --no-ff hotfix-$1
git tag -a $1
