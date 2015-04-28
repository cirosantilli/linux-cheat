.POSIX:

separate-invocations:

## Separate invocations

# Each line is a separate invocation of the interpreter.
	a=true
	$$a && echo 'fail'

## $

## Escape dollar sign

# Must escape dollar or else make thinks its a make variable

dollar-escape:
	a='pass' && echo $$a

## Multi-line instructions

# If a recipe line ends in `\`, the next line is appended to it
# and passed to the interpreter:
#
# - including the `\`
# - without the newline

# The next line can then start at char 0 to avoid extra spaces being
# added to the rule.

multiline-command:
	a='pass';\
	echo "$$a"

## hyphen prefix

## -

# If one interpret line returns non-0, the rule stops.
# unless you add an hyphen `-` before that line.

# This can be achieved for all lines with:

# - the `-i` command line option
# - the `.IGNORE` special targets

no-hyphen:
	false
	echo 'pass'

hyphen:
	-false
	echo 'pass'

## at sign prefix

## @

# Rule lines get put into stdout, unless you add an at sign `@` before the line.

# A major application is to give user messages with echo, without seeing the literal `echo`.

no-at:
	echo a

at:
	@echo a

# You can combine `@` and `-`.

at-hyphen:
	@-false
	@echo at-hyphen
