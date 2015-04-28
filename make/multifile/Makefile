A := a
B := b

# export all variables to makefiles called from this one:

export

# export only specific variables:

# export A B

# preventin exporting specific variables:

unexport B

# works even with variables that were explicitly exported previously

.PHONY: all a
.POSIX:

all:
	#  standard way to call on different directory:

		$(MAKE) -C d

	#  -C: call make on a different directory

	#  always use the MAKE variable since this does good magic for you

	# equivalent way:

		cd d && $(MAKE)

	#  -f: use a given file as a makefile

		$(MAKE) -f makefile-other

	#  -f does not change the current directory to the directory of the given file:

		$(MAKE) -f d/makefile

	@# include:

		@if [ ! "$(include_var)" = "include_var_val" ]; then exit 1; fi
