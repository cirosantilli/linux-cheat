# Print working directory of process.

# Each program has a working directory set by the OS.

# Processes inherit working directory of calling process

  mkdir a
  chmod 777 a
  echo pwd > a/a
  chmod 777 a/a
  ./a/a

#`pwd`
#outside /a, the working directory of the caller (bash cwd)
