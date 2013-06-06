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

.PHONY: all

all:
	@if [ ! "$(colon)" 		= "a"		]; then exit 1; fi
	@if [ ! "$(nocolon)" 		= "b" 		]; then exit 1; fi
	@if [ ! "$(colon_plus)"		= "a b c" 	]; then exit 1; fi
	@if [ ! "$(nocolon_plus)" 	= "a b d" 	]; then exit 1; fi
