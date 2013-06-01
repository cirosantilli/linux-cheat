#this file *must* be named exactly `Makefile`

NAME := test1

obj-m += $(NAME).o

.PHONY: all clean insert remove

#TODO put all outputs in a single output dir
all:
	make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" modules
	#make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" O="$(PWD)/_out/" modules

#TODO not working
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

ins: all
	if [ ! -z "`lsmod | grep '^$(NAME) '`" ]; then sudo rmmod $(NAME).ko; fi
	sudo insmod $(NAME).ko

#view system log file for printk messages
#inverts file linewise to see most recent first
log:
	tac /var/log/syslog | less

rm:
	sudo rmmod $(NAME).ko
