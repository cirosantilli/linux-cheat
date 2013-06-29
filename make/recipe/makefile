.POSIX:

#each line is a separate invocation of the interpreter
basic:
	echo basic1
	echo basic2

#must escape dollar or else make thinks its a make variable
dollar:
	a=1 && echo $$a

#I meant **separate** invocation!
#
#this fails, as its two different calls to sh
multiline-fail:
	a=1
	echo $$a

#if a recipe line ends in `\`, the next line is appended to it
#and passed to the interpreter:
#
#- **including** the `\`
#- **without** the newline
#
#the next line can then start at char 0 to avoid extra spaces being
#added to the rule
#
#useful to make the program clearer
multiline:
	a=1 ;\
echo $$a

#if one interpret line returns non 0, the rule stops
non0:
	false
	echo 1

#unless you add an hyphen `-` before that line:
non0-hyphen:
	-false
	echo 1

#rule lines get put into stdout, unless you add an at sign `@` before the line
#
#a major application is to give user messages with echo, without seeing the literal `echo`
at:
	@echo a

#you can combine `@` and `-`:
at-hyphen:
	@-false
	echo at-hyphen
