A:=a
B:=b

# export all variables to makefiles called from this one:

export

#export only specific variables:

#export A B

# preventin exporting specific variables:

unexport B

# works even with variables that were explicitly exported previously

.PHONY: all

all:
	# -C: call make on a different directory

		make -C d

	# useful for calling one make from another

	# -f: use a given file as a makefile

		make -f makefile-other
