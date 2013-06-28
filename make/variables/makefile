## := vs =

colon_rval := a

# without colon, variable expands here as in c:

colon := $(colon_rval)

# without the colon, expansion takes the value of $(a) at the time of usage:

nocolon = $(colon_rval)
colon_rval := b

# summary: always use colon unless you have a very good reason not to do so,
# non colon equals is confusing!

## +=

# evaluates immediately like `:=` if lvar was first defined with `:=`
# and later if it was first defined with `=` or `?=`

colon_plus_rval := c

colon_plus := a
colon_plus += b
colon_plus += $(colon_plus_rval)

nocolon_plus = a
nocolon_plus += b
nocolon_plus += $(colon_plus_rval)

colon_plus_rval := d

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

.PHONY: all

all:
	@#here you see how variables can be used inside recipes:
	@if [ ! "$(colon)" 				= "a"				]; then exit 1; fi
	@if [ ! "$(nocolon)" 			= "b" 				]; then exit 1; fi
	@if [ ! "$(colon_plus)"			= "a b c" 			]; then exit 1; fi
	@if [ ! "$(nocolon_plus)" 		= "a b d" 			]; then exit 1; fi
	@if [ ! "$(avarname)" 			= "avarname_val"	]; then exit 1; fi
	@#@if [ ! "$(vardef_name)"		= "vardef_val"		]; then exit 1; fi

$(rule)
	@echo varrule

#by the way, you can also use built-ins anywhere just like variables
#Try this with `make sh`:
$(shell echo sh):
	@echo sh
