#include <linux/module.h>	/* needed by all modules */
#include <linux/kernel.h>	/* KERN_INFO */

int init_module(void)
{
    //`KERN_INFO` is a message priority
    //8 are defined

    printk(KERN_INFO "test1 init_module\n");

	//A non 0 return means init_module failed; module can't be loaded. 
	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "test1 cleanup_module\n");
}
