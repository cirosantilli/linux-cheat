## shell

	# Evaluate shell command

	# Expands like a variable

		SHELL_IN := a
		SHELL_OUT := $(shell echo $(SHELL_IN))

	# Newlines and carriage returns are converted to single spaces:

		shell_newline := $(shell printf 'a\nb')

## error

	# Print error message and stop make execution.

ifeq (0,1)
	$(error Error message)
endif

##info

	#Print an information message.

$(info info message before fule)

.PHONY: all

all:
	@if [ ! $(SHELL_OUT) = a ]; then exit 1; fi
	@if [ ! $(shell echo a) = a ]; then exit 1; fi
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
	@##eval
	@#do make operations instead of sh operations inside a recipe
	$(eval EVAL_VAR := a)
	@if [ ! $(EVAL_VAR) = a ]; then exit 1; fi
	@##error
	@if [ ! "$(shell_newline)" = "a b" ]; then exit 1; fi
ifeq (0,1)
	$(error error message)
endif
	@#this will be printed before other outputs
	$(info info message rule)
