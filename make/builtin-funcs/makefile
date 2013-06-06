#funcs can be used to define variables also:
A := a
VAR := $(shell echo a)

.PHONY: all

all:
	@#get stdout of shell command to variable:
	@echo shell: $(shell echo a)
	@#replace pattern:
	@echo patsubst:
	@echo $(patsubst %.a, %.b, a.a b.a b.b)
	@#can only have on single `%`:
	@echo $(patsubst %.%, %, a.a b.a b.b)
	@##path operations
	@###basename
	@#remove extensions only! does not do the same as the POSIX basename utility!
	@echo "basename:   $(basename a/b a/b.c)"
	@echo "dir:        $(dir a/b a/b/ a /)" #a a/a/ ./ /
	@echo "notdir:     $(notdir a/b a/b/ b /)" #b b
	@echo "filter:     $(filter %.a %.b, a.a a.ab a.b )"
	@echo "filter:     $(filter-out %.a %.b, a.a a.ab a.b )"
