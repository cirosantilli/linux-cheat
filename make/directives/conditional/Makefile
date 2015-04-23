## Conditional

## ifeq

ifeq (a,a)
	ifeqaa := 1
else
	ifeqaa := 0
endif

ifeq (a,b)
	ifeqab := 1
else
	ifeqab := 0
endif

	# Can be used both for variable definitions and in rules.

	# Syntax gotchas:

	# - you **must** put a space after `ifeq`!
	#   The following fails gives a separator missing error:

#ifeq(a,a)
#endif

	# - **must** be the first thing on a line. The following fails:

	#ifeq (a,a)
	#endif

# Can be nested:

ifeq (a,a)
ifeq (a,a)
	if_nest_eqaa := 1
endif
endif

# Only evals done before the rules are taken into account:

	EVAL_BEFORE:=0

empty :=   
nonempty := a

.PHONY: all
.POSIX:

all:
	@if [ ! $(ifeqaa) = 1 ]; then exit 1; fi
	@if [ ! $(if_nest_eqaa) = 1 ]; then exit 1; fi
	@if [ ! $(ifeqab) = 0 ]; then exit 1; fi
ifeq (a,a)
else
	@exit 1
endif

ifeq (a,b)
	@exit 1
else
endif

	@#test if variable is empty (or just contains just spaces)
ifeq ($(strip $(empty)),)
else
	@exit 1
endif

ifeq ($(strip $(nonempty)),)
	@exit 1
else
endif

	@#this eval is *not* taken into acccount by ifeq! (ifeq is like a macro)
	$(eval EVAL_RULE:=0)
ifeq ($(EVAL_RULE),0)
	@exit 1
endif

ifeq ($(EVAL_BEFORE),0)
else
	@exit 1
endif
