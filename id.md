# id

POSIX 7: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/id.html>

Shows user and group ids and names.

Show all info for a given user:

    u='root'
    id "$u"

For current user:

    id

Effective user ID:

    id -u

Effective username:

    id -un

Real user ID:

    id -ur

Same but for groups:

    id -g
    id -gn
    id -gr
