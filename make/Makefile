# ?deprecated

# THIS FILE IS DEPRECATED
# it is being split up into smaller
# more understantable and testable makefiles
# and will be completelly removed afterwards

## conventional targets

## phony targets

	# if you don't give phony, make thinks you want to build a file
	# if a file install exists, make does nothing!
	# http://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile

	.PHONY: all install clean help

	# first target in file is default! all is often it by convention

	# help. can be first if options required

	help:
		@echo "must use an option:"
		@echo "  c"
		@echo "  cpp"

	# $make #makes first target found on file

	## conventional names

		## help

				# print help on cur makefile options

		## all

			# builds everything

			# usually is the default target (comes first)

		## check

			# do test to check that application is woking properly

		## install

				# install after a build

				# this basically putting built/config files in the right place with right permissions

				# and calling auxiliary programs such as ``ldconfig``

		## clean

			# remove generated output/auxiliary files

			clean:
				@rm *.o *.tmp

			install:
				@mv out $(DIRINPATH)

## .SECONDARY

	# an **intermediate** file is a file that is neither target nor prerequisite.

	# example:

		# a.m4 -> a.c -> a.o

	# with a single rule:

		a.o: a.m4
			m4 a.m4 > a.c
			gcc -o a.o a.c

	# here a.c is intermediate.

	# make deletes intermediate files by default because:

	# - they are not desired outputs (those must be targets)
	# - if one of the base prerequisites is modified, this will be remade anyways

	# if you want to keep them you can use the secondary target:

	.SECONDARY: a.c b.c

## variables

	CC=gcc
	CXX=$(CC)
	FLAGS=-Wall -Wno-unused-variable -Wno-unused-but-set-variable
	OUTEXT=.out
	OUTDIR=_out

	$(OUTDIR)/target$(OUTEXT): dep.c
		$(CC) $(FLAGS) -o $(OUTDIR)/target$(OUTEXT) dep.c

	# multiple vars
	articles = coat shoes mobile sweater socks\
					trousers shirt pants undershirt

	$(articles) :; @echo put on $@; touch $@

	# assignment
		# VARIABLE = value
			# Normal setting of a variable - values within it are recursively expanded when the variable is used, not when it's declared

			a = $(b)
			b = $(c)
			c = c

			echo $(a)
			# c

		# VARIABLE := value
			# Setting of a variable with simple expansion of the values inside - values within it are expanded at declaration time.

			# always use this

			c := c
			b := $(c)
			a := $(b)

			echo $(a)
			# c

		# VARIABLE ?= value
			# Setting of a variable only if it doesn't have a value
		# VARIABLE += value
			# Appending the supplied value to the existing value

	## define var inside rule
		all:
			$(eval X := $* )
			# set a variable inside a rule
			echo $(X)

	## special vars

		# $@: cur target
		# $*: part that matches % of cur target
		# $<: first cur dep
			$(OUTDIR)/target$(OUTEXT): dep.c
				$(CC) $(FLAGS) -o $@ $<
		# $? 	The names of all the prerequisites that are newer than the target, with spaces between them.
		# $^ and $+ 	The names of all the prerequisites, with spaces between them.
		# The value of $^ omits duplicate prerequisites, while $+ retains them and preserves their order.

## spaces

	# **PAY ATTENTION TO THIS BECAUSE MAKE IS FUSSY ABOUT SPACES**!

	# - you simply cannot have filenames with spaces in them. use hyphens '-' or '_' instead

	# - in variable definition, traillinw whitespaces that follow are included!!

		# ex:

			a = b

		# a = "b  "

		# never use trailling spaces!!!

	# - you cannot have a blank line for a rule:

		all:
			echo a

			echo b

		# only `echo a` will be executed!!!

		all:
			echo a
			echo b

		# `echo a` and `echo b` are executed

## include

	# sources a file
	include make.inc

	# continue even if missing
	-include make.inc

## implicit rules

	#  An explicit rule assigns the commands for several targets
	coat shoes mobile sweater socks trousers\
	shirt pants undershirt: ;  @echo put on $@; touch $@

	#  Implicit rules state the prerequisites
	coat:      shoes mobile sweater
	shoes:     socks trousers
	mobile:    trousers
	sweater:   shirt
	trousers:  pants shirt
	shirt:     undershirt

## duplicate rules

	# must use double colons

	# socks will build both
	socks:: ; @echo get into left sock
	socks:: ; @echo get into right sock

## call other makefiles

	$(MAKE)

## command line variables

	###
	$make run A='"1"'
	echo $(A)
	# 1

	###
	$make run A='"1"'
	A=2
	echo $(A)
	# 1

	###
	$make run A='"1"'
 A=2
	echo $(A)
	# 2

	###
	$make run A='"1"'
 A?=2
	echo $(A)
	# 1

	$make run A='"as df"'
	echo $(A)
	# as df

## conditional

	A=defined
	all: a.out
	ifdef A
		echo $(A)
	else
		echo undefined
	endif

## builtin functions

	## wildcard

		# makes an array with wildcard.

			SRCS = $(wildcard *$(INEXT))

	## patsubst

		# makes an array with wildcard.

			OUTS = $(patsubst %$(INEXT),%$(OUTEXT),$(SRCS))

		# compile all files of a type

			INEXT=.c
			OUTEXT=
			SRCS = $(wildcard *$(INEXT))
			OUTS = $(patsubst %$(INEXT),%$(OUTEXT),$(SRCS))
			all: $(OUTS)
			%: %$(INEXT)
				$(CC) $(CFLAGS) -o $@$(OUTEXT) $<

	## foreach

		# do a loop and concatenate results

		# select all files with one of the given extensions in current directory

			IN_DIR   := ./
			IN_EXTS  := .lex .y .c .cpp
			INS		 := $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)) )

	## eval

		define a variable inside a rule

			$(eval X := $(AUX_DIR)$* )

	$(subst from,to,text) 	Replace from with to in text.
	$(patsubst pattern,replacement,text) 	Replace words matching pattern with replacement in text.
	$(strip string) 	Remove excess whitespace characters from string.
	$(findstring find,text) 	Locate find in text.
	$(filter pattern...,text) 	Select words in text that match one of the pattern words.
	$(filter-out pattern...,text) 	Select words in text that do not match any of the pattern words.
	$(sort list) 	Sort the words in list lexicographically, removing duplicates.
	$(dir names...) 	Extract the directory part of each file name.
	$(notdir names...) 	Extract the non-directory part of each file name.
	$(suffix names...) 	Extract the suffix (the last dot and following characters) of each file name.
	$(basename names...) 	Extract the base name (name without suffix) of each file name.
	$(addsuffix suffix,names...) 	Append suffix to each word in names.
	$(addprefix prefix,names...) 	Prepend prefix to each word in names.
	$(join list1,list2) 	Join two parallel lists of words.
	$(word n,text) 	Extract the nth word (one-origin) of text.
	$(words text) 	Count the number of words in text.
	$(wordlist s,e,text) 	Returns the list of words in text from s to e.
	$(firstword names...) 	Extract the first word of names.
	$(wildcard pattern...) 	Find file names matching a shell file name pattern (not a '%' pattern).
	$(error text...) 	When this function is evaluated, make generates a fatal error with the message text.
	$(warning text...) 	When this function is evaluated, make generates a warning with the message text.

	$(shell command) 	Execute a shell command and return its output.
		LIBS=$(shell pkg-config opencv --libs)

	$(origin variable) 	Return a string describing how the make variable variable was defined.
	$(call var,param,...) 	Evaluate the variable var replacing any references to $(1),$(2) with the first, second, etc. param values.

## submake

	# call other makefiles

	mkdir a

	echo -e 'a=b
all:
\t@echo $(a)
\t@$(MAKE) -C a all' > makefile

	echo -e 'all:
\t@echo $(a)' > a/makefile

	make

## implicit builtins

# make has some built-in rules and variables

# PAY ATTENTION OR THIS WILL F*** YOU UP LATER,
# SINCE THEY MAY OVERRIDE YOUR OWN RULES AND VARIABLES WITHOUT WARNING!!!!!!!!!!!!!

# in this way, for example, c.c -> c.o happens automatically

# suffixes for which there are implicit rules (may override your own rules!):

	# .out, .a, .ln, .o, .c, .cc, .C, .cpp, .p, .f, .F, .m, .r, .y, .l, .ym, .lm, .s, .S, .mod, .sym, .def, .h, .info, .dvi, .tex, .texinfo, .texi, .txinfo, .w, .ch .web, .sh, .elc, .el

# predefined vars ( ?= won't work for them! ):

	# AR AS CC CPP FC M2C PC CO GET LEX YACC LINT MAKEINFO TEX TEXI2DVI WEAVE CWEAVE TANGLE CTANGLE RM ARFLAGS ASFLAGS CFLAGS CXXFLAGS COFLAGS CPPFLAGS FFLAGS GFLAGS LDFLAGS LFLAGS YFLAGS PFLAGS RFLAGS LINTFLAGS

# those vars are mainly used to control the automatic rules.

# to turn off the implicit rules: add a phony empty rule:

.SUFFIXES:

# as you may guess, this specifies for which suffixes automatic rules will work or not.

# **I SUGGEST YOU ALWAYS USE THIS**!

## recipes

	## make all files of an extension inside given path

		CC=pdflatex
		IN_EXT=.tex
		IN_DIR=src/
		OUT_DIR=_out/
		OUT_EXT=.pdf

		INS=$(wildcard $(IN_DIR)*$(IN_EXT))
		INS_NODIR=$(notdir $(INS))
		OUTS_NODIR=$(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS_NODIR))
		OUTS=$(addprefix $(OUT_DIR),$(OUTS_NODIR))

		.PHONY: all mkdir clean

		all: mkdir $(OUTS)

		mkdir:
			mkdir -p "$(OUT_DIR)"

		$(OUT_DIR)%$(OUT_EXT): $(IN_DIR)%$(IN_EXT)
			$(CC) -o "$@" "$<"u al

		clean:
			rm -rf $(OUT_DIR) $(AUX_DIR)
			# rm *.$(OUT_EXT)
		# compile command
