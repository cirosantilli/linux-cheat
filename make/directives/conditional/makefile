##ifeq

#can be used both for variable definitions and in rules

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

empty :=   
nonempty := a

.PHONY: all
.POSIX:

all:
	@if [ ! $(ifeqaa) = 1 ]; then exit 1; fi
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
