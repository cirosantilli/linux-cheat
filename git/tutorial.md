# about

git tutorial for absolute beginners.

it is use case oriented.

here i'm focusing on linux (ubuntu) + [git](http://git-scm.com/) + [github],
you can use any OS (Windows or OSX), and there are many alternatives to [github],
such as [bitbucket] or [gitorious]

this workflow is basically valid for any [vcm] with a web interface.

## souces

- official book: <http://git-scm.com/book>.

    Good info and graphs.

    Leaves out many practical things.

- good tut: <http://cworth.org/hgbook-git/tour/>

- good tut, straight to the point, ascii diagrams: <http://www.sbf5.com/~cduan/technical/git/git-1.shtml>

- good tut by github: <http://learn.github.com/p/>

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

- it has inner state that is not obvious at first to visualise.

- concepts depend on one another egg and chicken style.

to learn it:

- make a bunch of standard test repos, copy them out, and *test away*.

    use the standard repos generated in [test repos]

- visualise the commit tree whenever you don't know what is going on.

    once you see the tree, and how to modify it, everything falls into place!

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

# definition: index

is where git stores what will be kept for next version

it can modified with may commands such as [add], [rm], [mv], or [reset].

# definition: working tree

is all the "regular" files that lie outside the `.git` dir.

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

changes who is the parent of a commit.

as any history rewritting, you should not do this after a push.

## hard vs soft

hard also modifies the actual files and the index!

soft does not.

    ./copy.sh 2u
    echo a3 >> a
    echo b3 >> b
    git add a b c
    git status
        #to be commited: a, b and c

with soft:

    git reset
        #unstaged: a, b
        #untracked: c
    ls
        #a b c

    cat a
        #a1
        #a2
        #a3

    cat b
        #b1
        #b2
        #b3

    cat c
        #c

so all files stayed the same as they were, but they became unstaged.

this is how you unstage a file.

with hard:

    git reset --hard
    ls
        #a b c

    cat a
        #a1
        #a2

    cat b
        #b1
        #b2

    cat c
        #c

- tracked files went back to as they were at last commit.

    Changes you made on the working tree were discarded!!

- untracked files (`c`) are unchanged, but they are unstaged

## change parent of a commit

this changes history and as any history changing, if you do this after you [push] and someone else [fetche]d, there will be problems!

with reset, you can change the commit a branch points to to any other commit,
even if the other commit is not an ancestor of the parent!

    ./copy.sh b2
    git reset --hard b2
    git status
        #no changes

the tree:

    (1)-----(2)
     |       
     |       
     |       
     +------(b2)
             |
             master *
             b

`(2)` is called a *dangling commit* since it has no descentant branch.

### delete last commit from history

start with [2]:

    ./copy.sh 2
    echo a3 >> a
    echo b3 >> b
    echo c > c
    git reset --hard HEAD~
    ls
        #a b c

    cat a
        #a1

    cat b
        #b1

    cat c
        #c

    git show-refs -h HEAD
        #hash2

    git log --pretty=oneline
        #only one commit!

the tree:

    (1)-----(2)
     |
     master *

and `(2)` is called a dangling commit.

## undo a reset hard

you can undo a reset hard.

first find out the hash of the deleted commits:

    git fsck --lost-found

they should show up as *dangling commits*. This is what they are: commits that have no descentand branch.

now merge away with the have you just found.

but *don't rely on this!*: 
dangling commits are removed from time to time depending on your configs

## remove all dangling commits forever

    git reflog expire --expire=now --all
    git gc --prune=now

but be sure this is what you want! there is no turning back.

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

# mv

similar to [rm].

if you do a normal `mv`, then it is as if the old file was removed and a new one was created:

start with [1].

    mv b c
    git status
        #removed: b
        #untracked: b

if you do `git mv`, git acknowleges it was moved:

    mv b c
    git status
        #renamed: b -> c

with `-f`, if the new path exists, it is overwritten:

    git mv -f "$OLD_PATH" "$NEW_PATH"

with `-k`, if moving would lead to an error (overwrite without -f or file not tracked), skip the move:

    git mv -k "$OLD_PATH" "$NEW_PATH"

# clean

**danger**: remove all [untracked file]s in repo

start with [1]

    echo c > c
    git clean -f
    ls
        #a b

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

view hash commit messages only:

    git log --pretty=oneline

# reflog

see all that was done on repo linearly in time:
    
    git reflog

shows stuff like:

- commits
- checkouts
- resets

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

## by tag

see [tag]

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

- hash:        `1ba8f~3`
- branch:      `master~3`
- tag:         `1.0~3`
- remote head: `origin/master~3`

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

# tag

tags are aliases to commits

the difference from branches is that tags don't move with commits.

typical usage: give version numbers: `1.0`, `1.1`, `2.0`

    ./copy 2

give tag to `HEAD`:

    git tag 2.0

give tag to another commit:

    git tag 1.0 HEAD~

use:

    git show-refs -h HEAD
        #hash of first commit
    git show-refs -h HEAD
        #hash of second commit
    git checkout 1.0
    git show-refs -h HEAD
        #hash of first commit
    git checkout 2.0
    git show-refs -h HEAD
        #hash of second

list:

    git tag
        #1.0
        #1.0a
        #1.1

list with hashes side by side:

    git show-ref --tags

list with commit messages side by side:

not possible without a for loop AFAIK <http://stackoverflow.com/questions/5358336/have-git-list-all-tags-along-with-the-full-message>

delete:

    git tag -d 1.0

push to remote:

    git push --tags

is not done be default.

## annotated tag

    git tag -a ta -m 'annotated tag message!'

and now:

    git show ta

will show who created the tag and the tag message before the rest of the infos.

a tag that is not annotated is called a `lightweight` tag.

## signed

gpg signed tags!!

too overkill/too lazy to show for here see: <http://learn.github.com/p/tagging.html>.

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

if you ommit the version, defaults to `HEAD` so:

    git checkout
    git checkout HEAD

are the same.

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

the file must exist in the version you want to checkout to

### counter-example: checkout after remove

    start with [1]

    git rm a
    git commit -am 'noa`

no try:

    git checkout a

which is the same as:

    git checkout HEAD -- a

and it fails, because in `HEAD` a was removed from the repo.

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

TODO: finish example
TODO: mergetool

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

### with remote add

see [remote add]

### -u

another way is to use the -u flag:

    git push -u git@github.com:userid/reponame.git master

now next time you can just do:

    git push

and it will push to the last location.

## force

if you do something bad, force may allow you to correct it.

TODO

# remote

create aliases to a remote repo

when you clone something, it alreay has a origin remote.

## view remote

shows remote repo aliases without their real addresses:

    git remote 

shows remote repo aliases and their real addresses:

    git remote -v

view detail of branch:

    git remote show $B

## remote add

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

## remote rm

remove the branch github:

    git remote rm github

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

state of the remote:

    (A)----(B)----(C)----(H)
                   |      |     
                   |      master *
                   |                   
                   +-----(E)
                          | 
                          feature

local repo after a clone:

    git clone path/to/repo

    (A)----(B)----(C)----(D)    
                   |      |     
                   |      master *
                   |      origin/master
                   |                   
                   +-----(E)
                          | 
                          origin/feature

new state of the remote:

    (A)----(B)----(C)----(D)----(H)
                   |             |     
                   |             master *
                   |                   
                   +-----(E)----(F)--------(G)
                                            | 
                                            feature

local repo after a fetch:

    git fetch origin

    (A)----(B)----(C)----(D)--------(H)
                   |      |          |     
                   |      master *   origin/master
                   |                   
                   +-----(E)--------(F)--------(G)
                          |                     | 
                          feature               origin/feature

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

state of the remote:

    (A)----(B)----(C)----(H)
                   |      |     
                   |      master *
                   |                   
                   +-----(E)
                          | 
                          feature

your repo after a clone:

    git clone path/to/repo

    (A)----(B)----(C)----(D)    
                   |      |     
                   |      master *
                   |      origin/master
                   |                   
                   +-----(E)
                          | 
                          origin/feature

new state of the remote:

    (A)----(B)----(C)----(D)----(H)
                   |             |     
                   |             master *
                   |                   
                   +-----(E)----(F)--------(G)
                                            | 
                                            feature

local repo after a `merge`:

    git pull origin master

    (A)----(B)----(C)----(D)--------(H)
                   |                 |     
                   |                 master *
                   |                 origin/master
                   |                   
                   +-----(E)--------(F)--------(G)
                          |                     | 
                          feature               origin/feature

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

# file permissions

git keeps file permissions (rwx) as metadata inside the ``.git`` dir

# symlinks

## on push

git stores symlinks as files containing the link location
+ some metadata inside ``.git`` that indicates that it is a symlink.

## on pull

git recreates the symlinks on local system

start with [multi]

    cd a
    ln -s a c
    git add c
    git commit -am 'c'
    git push

    cd ..
    git clone ao c
    cd c
    [ -s c ] && echo ok

# submodules

## application

you have 3 repos.

you want to use files from a certain versions of repo 1 in repos 2 and 3,

there is no reliable way to:

- share a file between programs ( like `PATH` does for executable )
- maintain different versions of a program ( like `virtualenv` does for python )

so you have to keep a copy of the shared repo for each using repo anyways.

## creation

you have a latex `a.sty` file which you want to use

- on version `1.1` for a latex project 2 in `project2` repo
- on version `1.0` for a latex project 3 in `project3` repo

make a repo and put `a.sty` in the repo. Call it `latex`.

On project 2:

    git submodule add git://github.com/USERNAME/latex.git shared 
    ln -s shared/a.sty a.sty
    git add .gitmodules

Now a dir callled `shared` was created and contains your repo.

Don't ever touch that dir directly. Changes in that dir are not seen by git.

## cloning

to get all the files of submodules you need:

    git clone add git://github.com/USERNAME/project2.git
    git submodule init
    git submodule update

---

git commands inside the submodule work just like git commands on a regular git repo!

## update the content of a submodule

    cd share
    git pull

## go back to another version of a submodule

    cd share
    git log
    git checkout VERSION-ID

# rebase

change local history making it appear linear thus clearer.

as any history change, can only be done before push.

see: <http://learn.github.com/p/rebasing.html>

# hooks

take an action whenever something happens (a commit for example)

create a hook, just add an executable file with a known hook name under `.git/hooks/`

this executable may receive command line arguments which git uses to pass useful info to the executable.

example:

    cd .git/hooks/
    echo '#!/usr/bin/env bash

    echo abc' > post-commit
    chmod +x post-commit

now whenever you commit, you will see: abc on the terminal!

see: <http://git-scm.com/book/en/Customizing-Git-Git-Hooks> for other hook names.

TODO

# test repos

use those to test stuff.

they can be generated with the `generate-test-repos.sh` script

they are described here.

## 0

2 files uncommitted

    ls
        #a b
    cat a
        #a1
    cat b
        #b1
    git status
        #untracked: a b

## 1

same as [0], but commited

    ls
        #a b
    cat a
        #a1
    cat b
        #b1
    git status
        #no changes

    (1)
     |
     master

## 1u

same as [1], but one uncommited file added

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

    (1)
     |
     master
     HEAD

## 1ub

same as 1ub + one branch

current branch is `master`.

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

    (1)
     |
     master *
     b

## 2

2 commits and 2 files commited

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

    (1)-----(2)
             |
             HEAD
             master

## 2u

same as [2] + 1 file uncommited

    ls
        #a b c
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

    (1)-----(2)
             |
             HEAD
             master

## 2b

two branches unmerged, no uncommited files.

tree:

     
    (1)-----(2)
     |       |
     |       master *
     |       
     +------(b2)
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

    (1)-----(2)-----(3)
                     |
                     master *

## 0bare

bare repo

## multi

contains multiple repos for inter repo tests

it looks just like the github fork model!

the repos are:

    ls
        # a ao b bo

where:

- ao is the origin of a
- ao is the origin of bo
- bo is the origin of b
- ao is the upstream of b

so that those represent:

- a is the original repo (same as [b2])
- ao is where the owner put it on github
- bo is the fork made by someone else on github
- b  is the clone of the fork

also:

- a has a branch `master` and a branch `b`

## multiu

like [multi], but both master branches have commited unmerged modifications

# definitions

some git vocabulary

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

# TODO

- b clones, a commits, b commits. how can a check b's work
(without clone! withou merge into master, but as a branch at first commit)?

- how to update submodules automatically after a clone (with hooks maybe?)

- how to automatically upload cross platform output files such as pdf (generated from latex)

[github]: https://github.com/
[bitbucket]: https://www.bitbucket.org/ 
[gitorious]: http://gitorious.org/
[vcm]: http://en.wikipedia.org/wiki/Revision_control
