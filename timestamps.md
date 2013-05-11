the following timestamps exist which store the last modification of file:

- modification time: contents
- access time:       read, execute
- change time:       metadata (permissions, etc)
- creation time:     not yet widely supported! don't rely on this.

from bash those can be viewed with the stat command:

    stat a
