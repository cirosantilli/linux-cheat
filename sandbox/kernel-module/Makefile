#this file *must* be named exactly `Makefile`

NAME := test1

obj-m += $(NAME).o

.PHONY: all clean insert remove

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

#view system log file for printk messages
#inverts file linewise to see most recent first
log:
	tac /var/log/syslog | less

#TODO not working
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) cleanall

ins:
	sudo insmod $(NAME).ko

rm:
	sudo rmmod $(NAME).ko
