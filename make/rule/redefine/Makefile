# Redefining a target GNU make ignores the first, and gives a warning.

# It seems that POSIX says nothing about this, so the behaviour is undefined.

a:
	echo a0

a:
	echo a1

## Double colon suffix

## ::

# GNU extension.

# A target with double colon can be redefined without error.

# Both targets are executed, first the first one to be defined, and then the other one.

b::
	echo b0

b::
	echo b1
