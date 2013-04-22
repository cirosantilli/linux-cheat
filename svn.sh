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
