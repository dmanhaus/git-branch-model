# Git Branching Model

Adapted from [A successful Git Branching Model](http://nvie.com/posts/a-succgitessful-git-branching-model/) by Vincent Driessen

![git model](http://nvie.com/img/git-model@2x.png)

This tutorial creates the branching model and provides code examples for developer teams who want to follow the same approach.

## The Main Branches

The central repo holds two main branches with an infinite lifetime:

- master
- develop

The master branch at origin should be familiar to every Git user. Parallel to the master branch, another branch exists called develop.

We consider origin/master to be the main branch where the source code of HEAD always reflects a production-ready state.

We consider origin/develop to be the main branch where the source code of HEAD always reflects a state with the latest delivered development changes for the next release. Some would call this the “integration branch”. This is where any automatic nightly builds are built from.

When the source code in the develop branch reaches a stable point and is ready to be released, all of the changes should be merged back into master somehow and then tagged with a release number. How this is done in detail will be discussed further on.

Therefore, each time when changes are merged back into master, this is a new production release by definition. We tend to be very strict at this, so that theoretically, we could use a Git hook script to automatically build and roll-out our software to our production servers everytime there was a commit on master.

## Feature Branches

![feature branches](http://nvie.com/img/fb@2x.png)

May branch off from:

- develop 

Must merge back into:

- develop

Branch naming convention:

- anything except master, develop, release-*, or hotfix-*

Feature branches (or sometimes called topic branches) are used to develop new features for the upcoming or a distant future release. When starting development of a feature, the target release in which this feature will be incorporated may well be unknown at that point. The essence of a feature branch is that it exists as long as the feature is in development, but will eventually be merged back into develop (to definitely add the new feature to the upcoming release) or discarded (in case of a disappointing experiment).

Feature branches typically exist in developer repos only, not in origin.

### Step 1 - Creating a feature branch

When starting work on a new feature, branch off from the develop branch:
```bash
$ git checkout -b myfeature develop
Switched to a new branch "myfeature"
```
This step is automated in [01-create-feature-branch.sh](./features/01-create-feature-branch.sh). 

Pass the name of the feature as the first and only argument when running the script.

### Step 2 - Incorporating a finished feature on develop

Finished features may be merged into the develop branch to definitely add them to the upcoming release:

```bash
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Summary of changes)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop
```

This step is automated in [02-merge-feature-branch.sh](./features/02-merge-feature-branch.sh). 

Pass the name of the feature as the first and only argument when running the script.

The --no-ff flag causes the merge to always create a new commit object, even if the merge could be performed with a fast-forward. This avoids losing information about the historical existence of a feature branch and groups together all commits that together added the feature. Compare:

![merge no-ff](http://nvie.com/img/merge-without-ff@2x.png)

In the latter case, it is impossible to see from the Git history which of the commit objects together have implemented a feature—you would have to manually read all the log messages. Reverting a whole feature (i.e. a group of commits), is a true headache in the latter situation, whereas it is easily done if the --no-ff flag was used.

Yes, it will create a few more (empty) commit objects, but the gain is much bigger than the cost.

## Release Branches

May branch off from:

- develop

Must merge back into:

- develop and master

Branch naming convention:

- release-*

Release branches support preparation of a new production release. They allow for last-minute dotting of i’s and crossing t’s. Furthermore, they allow for minor bug fixes and preparing meta-data for a release (version number, build dates, etc.). By doing all of this work on a release branch, the develop branch is cleared to receive features for the next big release.

The key moment to branch off a new release branch from develop is when develop (almost) reflects the desired state of the new release. At least all features that are targeted for the release-to-be-built must be merged in to develop at this point in time. All features targeted at future releases may not—they must wait until after the release branch is branched off.

It is exactly at the start of a release branch that the upcoming release gets assigned a version number—not any earlier. Up until that moment, the develop branch reflected changes for the “next release”, but it is unclear whether that “next release” will eventually become 0.3 or 1.0, until the release branch is started. That decision is made on the start of the release branch and is carried out by the project’s rules on version number bumping.

### Step 3 - Creating a Release Branch

Release branches are created from the develop branch. For example, say version 1.1.5 is the current production release and we have a big release coming up. The state of develop is ready for the “next release” and we have decided that this will become version 1.2 (rather than 1.1.6 or 2.0). So we branch off and give the release branch a name reflecting the new version number:

```bash
$ git checkout -b release-1.2 develop
Switched to a new branch "release-1.2"
$ ./bump-version.sh 1.2
Files modified successfully, version bumped to 1.2.
$ git commit -a -m "Bumped version number to 1.2"
[release-1.2 74d9424] Bumped version number to 1.2
1 files changed, 1 insertions(+), 1 deletions(-)
```
This step is automated in [03-create-release-branch.sh](./releases/03-create-release-branch.sh). 

Pass the version number of the release, without any prefix, as the first and only argument when running the script. (e.g, to create a release branch called "release=1.2", pass "1.2" as the first and only argument when running the script.)

After creating a new branch and switching to it, we bump the version number. Here, bump-version.sh is a shell script that changes an environmental variable in a file called *release-version* in the working copy to reflect the new version. Then, the bumped version number is committed.

This new branch may exist there for a while, until the release may be rolled out definitely. During that time, bug fixes may be applied in this branch (rather than on the develop branch). Adding large new features here is strictly prohibited. They must be merged into develop, and therefore, wait for the next big release.

### Step 4 - Finishing a Release Branch - Merge to Master

When the state of the release branch is ready to become a real release, some actions need to be carried out. First, the release branch is merged into master (since every commit on master is a new release by definition, remember). Next, that commit on master must be tagged for easy future reference to this historical version. Finally, the changes made on the release branch need to be merged back into develop, so that future releases also contain these bug fixes.

The first two steps in Git:

```bash
$ git checkout master
Switched to branch 'master'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2
```
This step is automated in [04-merge-release-branch-master.sh](./releases/04-merge-release-branch-master.sh). 

Pass the version number of the release, without any prefix, as the first and only argument when running the script. (e.g, to create a release branch called "release=1.2", pass "1.2" as the first and only argument when running the script.)

