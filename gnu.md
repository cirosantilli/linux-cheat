# GNU

# Free software foundation

# FSF

The user space programs of most Linux distributions are mostly inherited from the *GNU project* which was created in 1983 by Richard Stallman.

For example, the following central components originate from GNU:

- GCC
- Binutils
- glibc
- bash

It seems that the GNU project is not officially called like that anymore, and has transformed into the *free software foundation* (FSF) also founded by Stallman. TODO check

Amongst the projects of the FSF is the *gnu operating system*. They are also active in legal causes and activism for free software.

The GNU operating system is developing its own kernel called *HUD*, but the own project states that it is not yet ready for broad usage

The FSF insists on calling what most people call Linux as GNU/Linux, which sounds quite reasonable considering they developed a great part of the userspace core.

The GNU software foundation is the creator and current maintainer of the GPL license, and mostly uses that license for its software and is the main enforcer of its infringements.

Interesting GNU links include:

- high priority projects: <http://www.fsf.org/campaigns/priority-projects/>
- <https://www.gnu.org/manual/blurbs.html>: list of all their software
- <ftp://ftp.gnu.org/gnu/>: software download section
- humour: <https://www.gnu.org/fun/fun.html>
- <https://www.gnu.org/prep/standards/standards.html> coding standards
- <https://www.gnu.org/prep/maintain/maintain.html> maintainer guidelines

## Savannah

Place where the source code is: <http://savannah.gnu.org/>

GNU uses Git.

Savannah allows anyone to hosted projects there, but there is a human review of compliance.

They have both `gitweb`, and `cgit` web interfaces.

List of all projects: <http://git.savannah.gnu.org>

## Vocabulary

- PR: Problem Report, bug
- CR: Change Request, feature request
- RFC: Request For Comment, TODO?

## Interesting projects

- GCC
- Binutils
- glibc
- bash
- gnulib: http://www.gnu.org/software/gnulib/ C utilities library. Similar to 

## Submitting patches

Most GNU projects use hateful last century mailing lists... subscribe to them and use your email filters to deal with the noise...

To generate patches, make a commit, then `git format-patch HEAD~ | xsel -b`, and send the output by email. You may add extra comments before the patch.

The email subject should be the commit summary line.

The commit message must end with the ChangeLog entry, which the committer will copy paste into the correct ChangeLog.

*Don't* modify the ChangeLog yourself.

You must indicate in which ChangeLog the entry will go by specifying it's directory.

Example of commit message:

    First summary line

    More lines.

    More lines.

    subdir:

    2000-01-01 Your Name  <your.name@email.com>

            * file.c (function) Improve something.
            (function1) Improve another thing.
            * file2.c (function) Improve something.
