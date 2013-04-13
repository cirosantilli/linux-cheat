# about

git tutorial for absolute beginners.

it is use case oriented.

here i'm focusing on linux (ubuntu) + [git](http://git-scm.com/) + [github],
you can use any OS (Windows or OSX), and there are many alternatives to [github],
such as [bitbucket] or [gitorious]

this workflow is basically valid for any [vcm] with a web interface.

## souces

- official book: <http://git-scm.com/book>. Good info and graphs.

- good tut: <http://cworth.org/hgbook-git/tour/>

- good tut, straight to the point, ascii diagrams: <http://www.sbf5.com/~cduan/technical/git/git-1.shtml>

- description of a production/dev/hotfix branch model:
    <http://nvie.com/posts/a-successful-git-branching-model/>

# motivation

git + github allows you to do the following quickly:

- [upload] your work to a serverupload to

    - backup your work

    - publish it

- [download] something someone else made and put on a server

- [go to another version]

    - in case you make a mistake, you can restore any file you want, even if it was deleted.

    - you can refer to a specific version.

        Why is this useful?
    
        Say you are writting a book, and you made a session called "motivation".
        
        Other people liked it, and said, look at the motivation section!

        But one day, you decide that the motivation section should be moved somewhere else.

        But then this breakes the references of other people!

        Not if the other person said: look at the "motivation" section of *version* XXX!

- create alternate realities

    this is useful when:

    - you want to make two different modifications on a file
        but you think they may interfere with one another.

        No problem, create one alternate reality version for each based on the current state.

    - you want to contribute two modifictaions to someoneelse's project.

        You are not sure which he will accept. So you make two alternate realities
        and suggest them both.

- view differences between versions

    it is easy to [view *differences* between versions](#differences)
    to find out what was different on a different version

    this is useful when:

    - why was my program working then, but stopped working?

    - what changes exactly did someone else made to my files and wants me to accept?

- work in groups

    Because of all its capacitie, git is widely used in group projects.
    (it was *created* for the linux kernel )

    This means that:

    - you can make a very large project that need many people to work on the same code.

    - you can learn from others.

    - if you make a good work, you will get more famous, and will have better jobs.

    For open source, this also means that:

    - you can make modifications that you need to the program you use.

# how to learn git

git is hard to learn at first because

- it has inner state that is not obvious to visualise.
- concepts depend on one another

to learn it, make a bunch of standard test repos, copy them out, test away.

# setup

before anything else install git.

on on ubuntu:

    sudo aptitude insatll git

next configure git:

    git config --global user.name "Ciro Duran Santilli"
    git config --global user.email "ciro@mail.com"

you will also want to install a local gui git viewer:

    sudo aptitude insatll gitk

it makes it easy to see certain things

# repository

git works inside the dirs you tell it to work.

those dirs are called *repositories*, *repo* for short.

to create a new repo, use [init].

To copy an existin repo, use [clone]. No need to init it after you clone it.

To transform a repo into a non repo, remove the `.git` dir (and maybe other files like `.gitignore`)

# init

go into some dir you have code you want to add to git and then do:

    git init

this creates a `.git` dir that contains all the git information.

## branches

read this after you understand [branch]

example: remote

                +---------------(E)
                /                |
    (A) -- (B) -- (C) -- (D)     |
                          |      |
                          master feature
                          |
                          HEAD

you repo after clone:

                    +-------------- (E)
                   /                 |
    (A) -- (B) -- (C) -- (D)         |
                          |          |
         origin/master, master    origin/feature
                          |
                         HEAD

# create version

most of git operations are based on versions, so you'd better know how to create them!

to create a version you need:

- decide what files will be included in the version with [add], [rm] or [reset]
- create the version with [commit]

you can see what would be included in the next version with [status]

# status

allows you to see what would be included in the next version

    git status

you can change what would be added with commmands like [add], [rm] or [reset]

there are 3 possible sections:

`Untracked files`

:   files which have never been added in any version.

`Changes not staged for commit:`

:   files which have changed but will not be considered.

`Changes to be committed: `

:   files which which have changed and will be considered

and if nothing changes, it says so.

check out the [add], [rm] and [reset] commands to see how it behaves
(it is only cool once you start changing the repo)

# add

make git track files for next version

    add a
    add a b

check that it will be considered for next version with:

    git status

## example: add

requires that you understand [add], [rm] and [reset] to modify the repo.

start with [0]

    status
        #untracked: a b
    git add a
    status
        #to be commited: new file: a
        #untracked: b
    git add b
        #to be commited: new file: a b
    git commit -m '1'
    status
        #no changes
    echo a2 >> a
    status
        #not staged: modified: a
    git add a
        #to be committed: modified: a

---

# reset

unadd a file that would be added to net version

if you regret adding a file to next version, and want to undo that to:

    git reset HEAD a

the file stays the same on your disk, but it will not be considered for next commit anymore.

# rm

if you want to remove a file that is tracked from future versions then use:

    git rm a

a simple `rm a` will not remove it from next version.

If you already did `rm a`, then doing `git rm a` will work even if the file
does not exist.

note however that this file still can be accessed on older versions!

if you committed sensitive data like passwords like this by mistake,
you need to remove it from history too!

to do that see [remove file from repo history].

## example: rm

start with [1]

    rm a 
    git status
        #not staged: removed a
    echo b2 >> b
    git add b
    git commit -m 2

then `a` is still in the repo:

    git checkout a

restores a.

If you use `commit -a`, it gets removed anyway:

    rm a 
    git status
        #not staged: removed a
    echo b2 >> b
    git add b
    git commit -am 2

You could also `git add` or `git rm` after a bare `rm`:

    rm a 
    git add a

or 

    rm a 
    git rm a

and a will be removed.

---

# commit

creates a new version.

you must first which files will be included in it with commands like [add], [rm] and [reset]

after you have decided what will be included or not,
you are ready to commit.

you should give a short message for every version telling what is happening on it.

this will be important later on to know what a version contains.

so from the [0] do:

    git add a
    git commit -m 'added a'
    git status

to give it a message 'added a'.

now status only says that b is untracked and nothing about a.

## correct last commit before upload

to understand this section you need to know the basic of push.

if you haven't yet uploaded this repo, you can correct the last message with:

    git commit --amend -m 'new msg'

see with `log` how this does not create new version.

can only use *before* push

## commit all tracked files

    git add -am 'message'

will create a new version, considering all files that are tracked.
( even if they were not added with add )

it is a very common default commit command.

if you use this all the time, you only add files once.

# remove file from repo history

useful if

- you mistakenly committed sinsitive data like a password
- some large output file like an .avi

    UNAME=cirosantilli
    REPONAME=cpp
    REPOURL=https://github.com/$UNAME/$REPONAME.git
    RMFILE="*.ogv"

    git filter-branch --index-filter "git rm --cached --ignore-unmatch \"$RMFILE\"" --prune-empty -- --all

remove from local dir

    rm -rf .git/refs/original/
    git reflog expire --expire=now --all
    git gc --prune=now
    git gc --aggressive --prune=now

remove from repo:

    git push origin master --force

MAIL ALL COLABORATORS AN TELL THEM TO git rebase

# log

list existing versions

start with [2] and then:

    git log

sample output:

    commit 1ba8fcebbff0eb6140740c8e1cdb4f9ab5fb73b6
    Author: Ciro Duran Santillli <ciro@mail.com>
    Date:   Fri Apr 12 10:22:30 2013 +0200

        2

    commit 494b713f2bf320ffe034adc5515331803e22a8ae
    Author: Ciro Duran Santillli <ciro@mail.com>
    Date:   Thu Apr 11 15:50:38 2013 +0200

        1

explanation:

There are 2 versions, one with commmit message `1` and another with commmit message `2`.

On version `1` we see that:

- author name: `Ciro Duran Santilli` (specified in `git config`)

- author email: ciro@mail.com (specified in `git config`)

- commit hash: `494b713f2bf320ffe034adc5515331803e22a8ae`.

    If you don't know what a hash is, it is time to learn now!

    Put simply, a hash is an angorithm that takes lots of input bytes (the repo)
    and outputs a short string (aka "the hash"), and so that it is very hard
    to find two inputs that have the same hash (altough they obviously exist,
    because the ouput string is much smaller! )

## find the version you want

in a plain `log` command, the only information you have about what happenned in a version
is the commit message.

you may need more information and better inofrmation filtering before deciding where you want to go back to.

show only if grepping commit messages match:

    git log --grep 1

show all commits on all branches (by default only current branch is shown):

    git log --all

# gitk

gitk is a gui for git.

it helps visualise commits and branches.

show commits on all branches:

    gitk --all

# how to refer to a version

to actually go to another version, you have to be able to tell git which one is it,
so that git can go back to it.

there are a few ways to do that.

## hash

the most complete is giving the entire hash, so:

    1ba8fcebbff0eb6140740c8e1cdb4f9ab5fb73b6

would be version 2.

It is very unlikelly that another version will have the same hash as this one.

Now, if this is the only version that starts with `1ba8fc` or `1ba8`, (and it is) you could use those as well!

## HEAD

head is the current commit we are on.

### definition: a head (lowercase)

is a commit with a name other than the hash,
such as

- a branch
- a remote head
- the HEAD.

### example: HEAD

start with [1]. we have:

    (1)
     |
     HEAD
 
after another commit:
 
    (1)-----(2)
             |
             HEAD
 
after another commit:
 
    (1)-----(2)-----(3)
                     |
                     HEAD

## by branch

to understand branches, see [branch]

## by remote head name

see [remote head]

## relative to another version

one commit before:
    
    HEAD~

two commits before:

    HEAD~~
    HEAD~2

three commits before:

    HEAD~~~
    HEAD~3

also work:

- hash:          `1ba8f~3`
- branch:       `master~3`
- remote head:  `origin/master~3`

# diff

TODO

see differences between two versions with:

    git diff eebb22 06637b

sample output:

    @@ 3,2 3,3 @@
     before
    +error
     after

meaning:

- before, line 3 was "before", line for "after".

    there were 2 lines total in what we see

- after, "error" was added after "before", becoming line 4

    there will be 3 lines total in what we see

    '+' indicates that a line was added.

    not surprisingly, if we remove something, a '-' will show instead

# branch

a branch is a name for a commit.

the commit a branch referst to may change.

using branches you may split up the commit tree

this creates alternate realities so you  can test changes without one affecting the other.

the first commit of a repo is made on a branch called `master`

## view existing branches

    git branch

not the asterisk indicating which is the current branch.

for more info:

    git branch -v

also shows start of hash and commit message.

one very important way is to do is graphically:

    gitk --all

will show you who is descendant of who!

## create a branch

create a branch called b:

    git branch b

check it was created:

    git branch

but the asterisk shows we are still in branch `master`.

this does not move to the branch just created! to do so you must use:

    git checkout b

## create a and move to it

    git checkout -b b
    git branch

## what happens when you create a branch

to the files, nothing.

to the tree, suppose we are [1u]

then after:

    git branch b

it becomes:

    (1)
     |
     master *
     b

## what happens to a branch when you commit

the *current* branch moves forward and continues being current.

Ex: start at [1ub] now:

    git add c
    git commit -am 'c'

gives:

    (1)-----(c)
             |
             master *

now try:

    git checkout b

which gives:

    (1)-----(2)
     |       |
     b *     master

c disappears because it was not tracked in b:

    ls
        #a b

echo c1 > c

    git add c
    git commit -m 'cb'

and now we have:

    +---------------(cb)
    |                |
   (1)-----(2)       b *
            |
            master

which makes it obvious why a branch is called a branch

## detached head

is when you checkout to a commit that has no branch associated

Ex: start with [2]

    git checkout HEAD^

now see:

    git branch

shows current branch as:
    
    (no branch) *

### what should I do if I want to branch from the detached head

if you are on it, you should first create a branch:

    git branch b

then work normally.

You can also create a branch before going to it with:

    git branch <hash>

### what happens if I commit on a detached head

bad things! never do this!

git does commit, but stays on a undefined state

to correct it you can create a branch:

    git branch b

and since you were on no branch, git automatically changes to `b`.

#### what if I commit and checkout??

worse things.

your old commit still exists, but does not show even on `git log --all`

git warns you: this might be a good time to give it a branch,
and you should as:

    git branch b hash

## start point

you can also create a branch at any commit other than the current one:

take [2]

    git branch b HEAD~

now
    
    git branch -v

to create switch to it directly:

    git checkout -b b HEAD~

# checkout

goes to another version

before you go to another version, you must see which versions you can go back with [log] or [gitk].

## entire repo

use the `checkout` command with some version name as explained in [how to refer to a version] for example:

    git checkout 494b
    git checkout HEAD~
    git checkout master~

the command is called `checkout`, because we are goint to "check out" what another version was like.

if you checkout the entire repo, `HEAD` moves!

### example: checkout entire repo

start with [3]

it looks like this:

    (1)-----(2)-----(3)
                     |
                     master
                     HEAD

now do:

    git checkout HEAD~~

the files `a` and `b` now both contain one line!

    cat a
        #a1

    cat b
        #b1

The tree looks like this:

    (1)-----(2)-----(3)
     |               |
     HEAD            master

Note how the `HEAD` moved, but `master` did not!

Now do:

    git checkout master

And `a` and `b` contain three lines again. This is how things look:

    (1)-----(2)-----(3)
                     |
                     master
                     HEAD

    cat a
        #a1

    cat b
        #b1

---

files that are not tracked stay the same.

### example: untracked files

start with [2]

    echo -e 'c1\nc2' > c

now checkout:

    git checkout HEAD~

`a` and `b` have changed

    cat a
        #a1

    cat b
        #b1

but the untracked `c` stays the same:

    cat c
        #c1
        #c2

---

### uncommited changes

if you have not yet commited changes, git warns you and does not checkout.

#### example: checkout uncommited modification

start with [2]

    echo a3 >> a

then try:

    git checkout HEAD~

git says that there is a change, and does nothing.

---

#### example: checkout file overwite

start with [2]

    git rm a
    git commit -am '-a'

    git echo -e 'a1\na2' > a

then try:

    git checkout HEAD~~

This fails again, because file a would be overwritten, even if its contents did not change.

---


## single file or dir

just like checking out the dir, but you also specify the files:

    git checkout HEAD~ a b

the head does not move now! this is different from the behaviour of checkout [entire repo]

new files that appear are just like untracked ones.

### example: checkout single file

start from [2]

    git checkout HEAD^ a

    cat a
        #a1

but we are still at master:

    git branch
        #* master

---

### example: checkout single removed file

start from [2]

remove b and commit:

    git rm b
    git commit -am '-b'

now restore it:

    git checkout HEAD~ b

    cat b
        #b1
        #b2

---

### uncommited changes

unlike when cheking out the entire repo,
git does not prompt you in case of non committed modifications 
when checking out individual files!

### example: checkout single file with modifications

start from [2]

    echo a3 >> a
    git checkout


---

# merge

is when you take two branches and make a new one that is child of both.

this is what you do when you like the modifications of two branches!

ex: start with [2b]

    merge 

# push

makes changes on a [bare] remote repo.

the other repo can be on an external server like github.

typical changes:

- put branches there
- remove branches from there

## usage

pushes branch to remote bare repo:

    git push path/to/bare/repo branch

if the branch does not exist it is created.

## don't type the repo url

### remote add

one way to avoid typing the repo url is giving it an alias with `remote add`:

    git remote add origin git@github.com:userid/reponame.git

origin can be any alias we want, but `origin` is a standard name for the main remote repo.

and now you can do:

    git push origin master

you can view existing aliases with:

    git remote -v

which gives:

    origin  git@github.com:cirosantilli/reponame.git (fetch)
    origin  git@github.com:cirosantilli/reponame.git (push)

### -u

another way is to use the -u flag:

    git push -u git@github.com:userid/reponame.git master

now next time you can just do:

    git push

and it will push to the last location.

# remote head

is a head that has a name

itis not a branch however!

if you checkout to them, you are in a detached head state.

## how to get one

see [clone] and [fetch]

## how to see the ones I have

    git branch -a

they are listed like remote/<remote-name>/<branch-name>

where remote-name was either given

- explicitly by `remote add`
- `origin` by default by `clone`

## how to refer to one

depends on the command

the best way is explicitly <remote-name>/<branch-name> but some
commands do explicit stuff if you enter just <branch-name> and
there is no other branch in your repo with that name.

ex: `origin/master`, `origin/feature2`, `upstream/feature2`, etc.

### branch

branch only sees remotes if you give the `remote-name` explicitly.

### checkout

if you have a remote `origin/b` and no branch named `b`,

    git checkout b

is the same as (magic!, never do this, it is very confuging!):

    git checkout b origin/b

but:

    git checkout -b b

is the same as:

    git branch b
    git checkout b

if you had a branch named `b`:

    git checkout b

would simply go to it.

# clone

make a "copy" of another repo.

fetchs all the remote branches.

creates only a single branch: the branch were the `HEAD` of the remote was.

## example: clone and branches

start with [multi].

    git clone a c

creates a repo c that is a "copy" of a. now:

    cd c
    branch -a
        #master *
        #remote/origin/b
        #remote/origin/b2
        #remote/origin/master

so you only have one branch, and the other are [remote head]s.

but if you do:

    cd a
    git checkout b
    cd ..
    git clone a d
    cd d
    git branch -a
        #b *
        #origin/b
        #origin/b2
        #origin/master

then you have a `b` branch, because that is where the head was when you cloned

## from github

it can also clone from a server such as github:

    git clone git@github.com:userid/reponame.git newname

this is how you download a project which interests you.

# fetch

looks for all modifications made on all branches of a remote and make them available on repo
through [remote head]s

does not modify any branch on current repo.

the remote must have a name (either given automatically at `clone` as `origin` or through explicit `remote add`)

## example

you after a clone:

    git clone path/to/repo

                   +--------------- (E)
                   |                 |
    (A)----(B)----(C)----(D)         |
                          |          |
         origin/master, master    origin/feature
                          |
                         HEAD

new state of the remote:

                   +--------- (E)----(F)----(G)
                   |                         |
    (A)----(B)----(C)----(D)----(H)          |
                                 |           |
                               master     feature
                                 |
                                HEAD

you after a fetch:

    git fetch origin

                    +-------------(E)--------------(F)------(G)
                   /               |                         |
    (A)----(B)----(C)----(D)-----------------(H)             |
                          |        |          |              |
                        master  feature origin/master  origin/feature
                          |
                         HEAD

---

## remove a pushed remote branch

if you pushed a branch test by mistake, here is how you remove it:

    git push origin :branchname

just add the colon before the branch name.

# bare

a repo that only contains the files that are inside `.git`.

this is what github stores for you: no need to store the files also!

there are some operations that you can only do/cannot do on a bare repo:

- you can only push to a bare repo.

- you cannot pull from a bare repo.

to create a bare repo:

    git init --bare
    git clone --bare other

# pull

pull is exactly the same as [fetch] + [merge] on given branch and merges with current branch.

does not update remote heads like [fetch] does.

## example: pull

you after a clone:

    git clone path/to/repo

                    +-------------- (E)
                   /                 |
    (A) -- (B) -- (C) -- (D)         |
                          |          |
         origin/master, master    origin/feature
                          |
                         HEAD

new state of the remote:

                    +-------- (E) -- (F) -- (G)
                   /                         |
    (A) -- (B) -- (C) -- (D) -- (H)          |
                                 |           |
                               master     feature
                                 |
                                HEAD

you after a `pull`:

    git pull origin master
    
                    +-------- (E) ------------- (F) ----- (G)
                   /           |                           |
    (A) -- (B) -- (C) -- (D) ------------ (H)              |
                               |           |               |
                            feature  origin/master,  origin/feature
                                        master
                                           |
                                          HEAD

so you current branch `master` has been merged into the branch `master` from repo `origin`.

# push to github

to upload you must have an account on some server and you must have created 

here we show how to upload to [github]

## github setup

create an account. your userid is: `userid`

create a repository. call it `reponame`

don't initilized it with a readme.

the git url is then `git@github.com:userid/reponame.git`

## do the upload

upload the latest version to the server with:

    git push git@github.com:userid/reponame.git master

this may ask for you github username and pass.

go back to github and browse your uploaded files to check that they are there.

# test repos

use those to test stuff.

## 0

2 files uncommitted:

    mkdir 0
    cd 0
    git init
    echo 'a1' > a
    echo 'b1' > b
    cd ..

    git status
        #untracked: a b

## 1

2 files committed.

create:

    cp -r 0 1
    cd 1
    git add *
    git commit -m 1
    cd ..

looks like:

    ls
        #a b
    cat a
        #a1
    cat b
        #b1

    git status
        #no changes

    1

    ^
    |

    master

    HEAD

## 1u

2 files committed and one uncommited

create:

    cp -r 1 1u
    cd 1u
    echo 'c1' > c
    cd ..

looks like:

    ls
        #a b c
    cat a
        #a1
    cat b
        #b1
    cat c
        #c1

    git status
        #untracked: c

    1

    ^
    |

    master

    HEAD

## 1ub

2 files committed and one uncommited + a branch called `b`

current branch is `master`.

    cp -r 1u 1ub
    cd 1ub
    git branch b
    cd ..

looks like:

    ls
        #a b c
    cat a
        #a1
    cat b
        #b1
    cat c
        #c1

    git status
        #untracked: c

    1

    ^
    |

    master *

    b

    HEAD

## 2

2 commits 2 files commited

    cp -r ic 2
    cd 2
    echo 'a2' >> a
    echo 'b2' >> b
    git commit -m 2
    cd ..

looks like:

    ls
        #a b
    cat a
        #a1
        #a2
    cat b
        #b1
        #b2

    git status
        #no changes

    1  -->  2

            ^
            |

            HEAD

            master

## 2u

2 commits 2 files commited, 1 file uncommited

    cp -r 2 2u
    cd 2u
    echo -e 'c1\nc2' >> c
    cd ..

looks like:

    ls
        #a b
    cat a
        #a1
        #a2
    cat b
        #b1
        #b2
    cat c
        #c1
        #c2

    git status
        #untracked: c

    1  -->  2

            ^
            |

            HEAD

            master

## 2b

two branches unmerged, no uncommited files.

    cp -r 1u 2b
    cd 2b
    git add c
    git commit -m 'master2'
    git checkout b
    echo a2 >> a
    echo '' >> b
    echo d1 > d
    git add d
    git commit -am 'b2'
    git checkout master
    cd ..

tree:

    1  -->  master2

    |       ^
    v       |

    b2      master *

    ^       HEAD
    |          
               
    b

files:

    git checkout master

    ls
        #a b c
    cat a
        #a1
    cat b
        #b1
    cat c
        #c1

    git checkout b

    ls
        #a b c
    cat a
        #a1
        #a2
    cat b
        #
    cat d
        #d1

## 3

3 commits 2 files

    cp -r 2 3
    cd 3
    echo 'a3' >> a
    echo 'b3' >> b
    git commit -m 3
    cd ..

looks like:

    ls
        #a b
    cat a
        #a1
        #a2
        #a3
    cat b
        #b1
        #b2
        #b3

    git status
        #no changes

    1  -->  2

    ^       ^
    |       |

    master  HEAD

## ib

bare

    mkdir ib
    cd ib
    git init --bare
    cd ..

## multi

contains multiple repos for interepo tests

it looks just like the github fork model!

    mkdir multi
    cp -r 1 multi/a
    cd multi
    clone --bare a ao
    clone --bare ao bo
    clone bo b
    cd a
    git remote add origin ../ao
    cd ../b
    git remote add upstream ../ao
    cd ../..

    cd ao
    git remote rm origin
    git remote add origin ../a
    cd ../bo
    git remote rm origin
    git remote add origin ../ao
    cd ../b
    git remote rm origin
    git remote add origin ../bo

the repo looks like this:

    ls
        # a ao b bo

where

- ao is the origin of a
- ao is the origin of bo
- bo is the origin of b
- ao is the upstream of b

meaning that a is the original repo

ao is where the owner put it on github

bo is the fork made by someone else

b  is the clone of the fork


# definitions

some commonly git vocabulary

## a commit

is a version

---

## to commit

is to create version

---

## to stage a file

is to consider it for next commit

---

## tracked file

is one that has already been staged once

---

[github]: https://github.com/
[bitbucket]: https://www.bitbucket.org/ 
[gitorious]: http://gitorious.org/
[vcm]: http://en.wikipedia.org/wiki/Revision_control
