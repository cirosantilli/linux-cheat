# compiles all .c files in current dir into .ko
# also furnishes phony targets to insert and remove modules, view log file
#
# this file *must* be named exactly `Makefile`

override IN_DIR 	?= ./
override IN_EXTS 	?= .c
override LOG_PATH 	?= /var/log/syslog
override OUT_DIR 	:= ./
#override OUT_DIR 	:= _out/
override OUT_EXT 	:= .ko
override OBJ_EXT 	:= .o
override RUN		?= cheat

INS			:= $(filter-out %.mod.c, $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT))))
INS			:= $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)))
INS_NODIR 	:= $(notdir $(INS))
OBJS_NODIR	:= $(addsuffix $(OBJ_EXT), $(basename $(INS_NODIR)))
OBJS		:= $(addprefix $(OUT_DIR), $(OBJS_NODIR))
RUN_EXT		:= $(RUN)$(OUT_EXT)

# `obj-m` is all that needs to be defined for the standard makefile to work

#TODO why this does not work but the next line does? there is no `:` version of `+=`: it depends on how it is first defined. If if is first defined with `:`: then `+=` is `:`
#obj-m 	+= $(OBJS)
obj-m += hello_world.o cheat.o

.PHONY: all clean ins rm run

# TODO put all outputs in a single output dir
all:
	make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" modules
	#make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" O="$(PWD)/$(OUT_DIR)" modules

# convenient way to test a module insertion:
#
# - removes module if inserted
# - inserts
# - shows log in a pager
#
# this is called run to keep consistency with retular user space programs,
# where you run the program to test it.
run: all
	if [ ! -z "`lsmod | grep '^$(RUN) '`" ]; then sudo rmmod "$(RUN_EXT)"; fi
	make ins
	make log

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

ins: all
	sudo insmod $(RUN_EXT)

# view system log file for printk messages
log:
	cat "$(LOG_PATH)"

rm:
	sudo rmmod "$(RUN_EXT)"
