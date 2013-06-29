##:= vs =

	colon_rval := a

	#without colon, variable expands here as in c:

	colon := $(colon_rval)

	#without the colon, expansion takes the value of $(a) at the time of usage:

	nocolon = $(colon_rval)
	colon_rval := b

	#summary: always use colon unless you have a very good reason not to do so,
	#non colon equals is confusing!

##+=

	#evaluates immediately like `:=` if lvar was first defined with `:=`
	#and later if it was first defined with `=` or `?=`

	colon_plus_rval := c

	colon_plus := a
	colon_plus += b
	colon_plus += $(colon_plus_rval)

	nocolon_plus = a
	nocolon_plus += b
	nocolon_plus += $(colon_plus_rval)

	colon_plus_rval := d

##?=

	#define variable only if it is not defined

	#empty variables are still defined

##where variables can be used

	#you can use variables:

	#- to give other variable names
	#- to define rules
	#- to define recipes

	#name a variable with another variable:

	varname := avarname
	$(varname) := avarname_val

	#TODO why does this not work:

	#vardef := vardef_name := vardef_val
	#$(vardef)

	#write a rule with a variable:

	rule := varrule: all

##multiline

	#TODO why does it not work? I copied from the manual!

	multiline_inner := multiline_2

define multiline =
@echo multiline_1
@echo $(multiline_inner)
endef

##automatic variables

	#some variables have default values

	#variables like $@ are also automatic variables,
	#but are discussed together with the rules

	#some automatic variables can be defined in makefiles and have an effect

	##MAKE

		#TODO

	###AKECMDGOALS

		#contains all targets given at commandline invocation

		#the default target if any does not count

	##MAKEFLAGS

		#flags given at invocation

	##MAKELEVEL

		#recursion level of make (how many makes called other makes)

	##SHELL

		#interpreter used to read each line

	##SUFFIXES

		#list of suffixes for which make automatically defines rules

	##VPATH

		#directories where to look for prerequisite files not found in current dir

.PHONY: all sh makecmdgoals

all:
	@#here you see how variables can be used inside recipes:
	@if [ ! "$(colon)" 				= "a"				]; then exit 1; fi
	@if [ ! "$(nocolon)" 			= "b" 				]; then exit 1; fi
	@if [ ! "$(colon_plus)"			= "a b c" 			]; then exit 1; fi
	@if [ ! "$(nocolon_plus)" 		= "a b d" 			]; then exit 1; fi
	@if [ ! "$(avarname)" 			= "avarname_val"	]; then exit 1; fi
	@#@if [ ! "$(multiline)" 			= $$'1\n2'			]; then exit 1; fi
	@#@if [ ! "$(vardef_name)"		= "vardef_val"		]; then exit 1; fi
	$(multiline)
	@echo "CURDIR       = $(CURDIR)"
	@echo "MAKE         = $(MAKE)"
	@echo "MAKECMDGOALS = $(MAKECMDGOALS)"
	@echo "MAKEFLAGS    = $(MAKEFLAGS)"
	@echo "MAKEFILES    = $(MAKEFILES)"
	@echo "MAKELEVEL    = $(MAKELEVEL)"
	@echo "SHELL        = $(SHELL)"
	@echo "SUFFIXES     = $(SUFFIXES)"
	@echo "VPATH        = $(VPATH)"

$(rule)
	@echo varrule

#by the way, you can also use built-ins anywhere just like variables
#Try this with `make sh`:
$(shell echo sh):
	@echo sh

makecmdgoals:
	@#
