#!/usr/bin/env bash

##tags

  #are names to commits. usefull for versioning

    git tag "v1.3"
    git push --tags

##rm

  #stop tracking file and permanently delete it on disk:

    git rm "$PATH"

  #only works if the files has not been modified after last commit. If it has, you must use the -f option.
  #if the file exist but is not being tracked, nothing is done

  #stop tracking file, but keep source:

    git rm --cached "$PATH"

  #rm even if the file has been modified after last commit:
  
    git rm -f "$PATH"

  #thus possible resulting is loss of data
  #if the file is not being tracked, nothing is done

  #recurse remove into directories:

    git rm -r "$PATH"

  #removes only tracked files that were mannualy deleted:

    git ls-files --deleted -z | xargs -0 git rm

  #this might be useful since if you try to remove an untracked file with git, nothing happens

  #RECURSIVE remove:

    git rm '*.txt'

##diff
  
  #see differences between two commits:

    git diff $C1 $C2

  #on a single file:

    git diff $C1 $C2 $F

  #staged differences before commit.

    git diff --cached "$F"

  #only for files that have been ``git add``.

    git diff HEAD "$F"
  #all differences between current state and last commit
    #no need to have added the files

  git checkout $hash  #go back to given Hash and KEEP changes. new commits will start branches
  git checkout master #go back to last commit and lose uncommited changes on all files
  git checkout $hash  #go back to hash (beginning of hash). lose uncommited
  git checkout $hash -- $file1 $file2

##submodule

  ##remove

    #Delete the relevant section from the .gitmodules file:

      vim .submodules

    #delete the relevant section from .git/config:

      vim .git/config
      rm --cached $path_to_submodule #(no trailing slash).
      rm -Rf .git/modules/$path_to_submodule
      git commit -am 'removed submodule'
      rm -rf $path_to_submodule

##.gitkeep

  #git ignores empty dirs

  #this is a conventional placeholder filename to force git to keep files.

  #it has no special meaning to git and is not documented.

  #possible better alternative: use a ``readme`` explaining the purpose of the dir!

##github api v3 via curl

    USER=cirosantilli
    REPO=repo
    PASS=

  #get repo info (large):

    curl -i https://api.github.com/users/$USER/repos

  #create remote git repo:

      curl -u "$USER" https://api.github.com/user/repos -d '{"name":"'$REPO'"}'
      git remote add github git@github.com:$USER/$REPO.git
      git push origin master

    #{
      #"name": "$REPO",
      #"description": "This is your first repo",
      #"homepage": "https://github.com",
      #"private": false,
      #"has_issues": true,
      #"has_wiki": true,
      #"has_downloads": true
    #}

  #delete repo:

      curl -u "$USER" -X DELETE https://api.github.com/repos/$USER/$REPO

  #careful, it works!!!

##svn tutorial

  #didn't expect this here did you?

  #create new svn controlled folder:

    svnadmin create project

  #clone:

    svn checkout https://subversion.assembla.com/svn/cirosantillitest/

  #clone version number 3:

    svn checkout -r 3 file:///home/user/svn project

  #everything you commit increases this number

  #take a non svn file directory and convert it to svn controlled one:

    svn import nonsvn svn

  #commit. if your ssh is added, this pushes to the original repository!!!
  #this is why in svn everything happens over the network!!

    svn commit -m 'commit message'

  #history of commits:

    svn log

  #what is commited, changed and tracked:

    svn status

  #must use to make dirs, -m to commit with message:

    svn mkdir foo -m 'commit message'

  #must use to remove dirs, m to commit with message:

    svn rmdir foo -m 'commit message'

  #add to version controll:

    svn add

  ##get single file from repo, modify it, and up again

      svn co https://subversion.assembla.com/svn/cirosantillitest/ . --depth empty
      svn checkout readme.textile
      vim readme.textile
      svn ci -m 'modified readme.textile'
