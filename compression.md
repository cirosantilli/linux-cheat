# Compression

The main performance parameters to consider when choosing the compression method are:

- compression ratio
- compression time
- can see and extracting single files
- support across OS
- ability to break into chunks
- keep file metadata such as permissions, hidden (windows), etc.

If you don't have very strict constraints, default to:

- `zip` if you want OS portability
- `tar.gz` if you want to maintain Linux filesystem metadata intact: permissions, symlinks, etc.

TODO: understand these formats:

- lzip. Extensions: `.lz`
- Extension `.xz`. TODO.
