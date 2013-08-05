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
	@echo 1

#unless you add an hyphen `-` before that line:
non0-hyphen:
	-false
	@echo 1

#rule lines get put into stdout, unless you add an at sign `@` before the line
#
#a major application is to give user messages with echo, without seeing the literal `echo`
at:
	@echo a

#you can combine `@` and `-`:
at-hyphen:
	@-false
	@echo at-hyphen

#Redefining a target GNU make ignores the first, and gives a warning.
#It seems that POSIX says nothing about this, so the behaviour is undefined.
redef:
	@echo redef0

redef:
	@echo redef1

#GNU extension:
#A target with double colon can be redefined without error.
#Both targets are executed, first the first one to be defined, and then the other one.

redef-double-colon::
	@echo redef0

redef-double-colon::
	@echo redef1
