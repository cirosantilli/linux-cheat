# compiles all .c files in current dir into .ko
# also furnishes phony targets to insert and remove modules, view log file
#
# this file *must* be named exactly `Makefile`

IN_DIR 		?= ./
IN_EXTS 	?= .c
LOG_PATH 	?= /var/log/syslog
OUT_DIR 	?= ./
#OUT_DIR 	?= _out/
OUT_EXT 	?= .ko
OBJ_EXT 	?= .o
RUN			?= main

INS			:= $(filter-out %.mod.c, $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT))))
INS			:= $(foreach IN_EXT, $(IN_EXTS), $(wildcard $(IN_DIR)*$(IN_EXT)))
INS_NODIR 	:= $(notdir $(INS))
OBJS_NODIR	:= $(addsuffix $(OBJ_EXT), $(basename $(INS_NODIR)))
OBJS		:= $(addprefix $(OUT_DIR), $(OBJS_NODIR))
RUN_EXT		:= $(RUN)$(OUT_EXT)

#same name given in `alloc_chrdev_region`
MODULE_NAME := test
DEV_EXT 	:= .dev.tmp

# `obj-m` is all that needs to be defined for the standard makefile to work:

#TODO why this does not work but the next line does? there is no `:` version of `+=`: it depends on how it is first defined. If if is first defined with `:`: then `+=` is `:`
#obj-m 	+= $(OBJS)
obj-m += hello_world.o main.o

#gcc flags to use
ccflags-y := -Wno-declaration-after-statement -std=gnu99
#- must use -gnu because kernel relies on gnu extensions
#- you may still get C90 forbids mixed declarations because the main Makefile
#    explicitly uses `-make -Wno-declaration-after-statement`

.PHONY: all clean ins rm run

# TODO put all outputs in a single output dir
all:
	make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" modules
	#make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" O="$(PWD)/$(OUT_DIR)" modules
	#vim /lib/modules/`uname -r`/build/Makefile

# convenient way to test a module insertion:
#
# - removes module if inserted
# - inserts
# - echoes log
# - create test character device files
#
# this is called run to keep consistency with retular user space programs,
# where you run the program to test it.
run: all rm
	make ins
	make log
	major=$$(awk "\$$2 == \"$(MODULE_NAME)\" {print \$$1}" /proc/devices) ;\
	sudo mknod read_infinite$(DEV_EXT) 	c $$major 0 ;\
	sudo mknod read_once$(DEV_EXT)		c $$major 1
	uname=`id -un` ;\
	gname=`id -gn` ;\
	sudo chown $$uname:$$gname *$(DEV_EXT)

#clean built files, but not necessarily remove
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	sudo rm *$(DEV_EXT)

ins: all
	sudo insmod $(RUN_EXT) param_i=1 param_s="bbb"
	#sudo insmod $(RUN_EXT) param_i=1 param_s="bbb" param_is="1,1,1"

# view system log file for printk messages
log:
	#cat "$(LOG_PATH)"
	dmesg

#does not clean build files, only makes everything ready for a new run
rm:
	if [ ! -z "`lsmod | grep '^$(RUN) '`" ]; then sudo rmmod "$(RUN_EXT)"; fi
	rm -f *$(DEV_EXT)
