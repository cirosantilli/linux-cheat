#include <linux/module.h>	/* needed by all modules */
#include <linux/kernel.h>	/* KERN_INFO */
#include <linux/spinlock.h>
#include <linux/interrupt.h>    /*request_irq, IRQF_SHARED*/

//#static

	//remember: the kernel is a huge program, and kernel modules are inserted into it,
	//so to avoid name conflicts, define stuff that will only be used on single ko
	//as `static`

static int i_global;

/*
 * the function with this signature is called when the module is inserted into the kernel
 *
 * typical things a real module would do here include:
 *
 * - initialize variables
 * - register an interrupt handler
 * - register a the bottom half of the interrupt handler
 *
 * */
int init_module(void)
{

	i_global = 0;

	/*
	#printk

		the kernel has no simple way to communicate with a terminal
		so you the simplest thing to do is dump program output to a file

		printk does this in a very reliable manner

		at the time of writting on Ubuntu 13.04 the file is: `/var/log/syslog`

		`KERN_INFO` is a message priority string macro

		it is understood by printk when put at the beginning of the input string

		8 levels are defined:

		printk takes printf format strings with containing things like `%d`
	*/

		printk(KERN_INFO "cheat init_module\n");

		printk(KERN_INFO "i_global = %d\n", i_global);

	/*
	#likely #unlikely

	 	the unlikely function marks a condition as rare, and makes it easier
	 	for compilers and processors to optimize the code

	 	likelly does the exac oposite

	 	those should only be used when the condition is extremelly rare (common)

	 	a typical use case is to test for errors conditions (which should, in theory, be rare...)
	*/
		if (likely(0)) {
			printk(KERN_INFO "cheat ERROR\n");
		}

		if (likely(1)) {
			printk(KERN_INFO "cheat unlikely(1)\n");
		}

		if (unlikely(0)) {
			printk(KERN_INFO "cheat ERROR\n");
		}

		if (unlikely(1)) {
			printk(KERN_INFO "cheat unlikely(1)\n");
		}

	/*
	# interrupt handler

		is a function that does what must be done in case of an interrupt,
		typically a message sent by hardware such as a mouse saying "hey I moved"

		it cannot be interrupted by other kernel process, so it should be real quick in its job
		and do only what is absolutelly essential

		typically the jobs it will do are:

		      - save the data from some buffer into RAM. this prevents small buffers from getting filled up.
		      - send an aknowledgment to the hardware that the interrupt was handled so the hardware can
		          //continue to send data for example

		what it typically should *not* do it to actually procees the data that was aquired
		this should be left for the bottom half.

	# request_irq

		this function tells the kernel to use a given interrupt function to deal with certain interrupts

		1. interrupt line. If non existent, will be created.

			this is a number the identifies each type of interrupt (ex: one from the mouse, one from the keyboard, etc.)

			it may be fixed for very traditional devices like the keyboard, but dynamic for most modern devices.

			TODO how to determine a dynamic line?

		2. interrupt handler function

		3. flags.

			- `IRQF_SHARED` means that multiple handlers will handle this line.

				when each one is registered it must use `IRQF_SHARED`

			- `IRQF_SAMPLE_RANDOM` tells the kernel to use timings of this interrupt to add entropy to the random number generator

				should only be done for things which are unpredictable in timing such as mouve moves of disk accesses,
				but not for regular things like a hardware clock

		4. name. Should be unique, allows for communication with the user via `/proc/irq` and `/proc/interrupts` TODO understand

		5. number that distinguishes between multiple irqs in the same line.

			therefore be unique across different irqs on the same line.

			Can be `NULL` if irq is not shared. TODO understand

	*/

		//TODO get working
		/*if (request_irq(rtc_irq, rtc_interrupt, IRQF_SHARED, "rtc", (void *)&rtc_port)) {*/
			/*printk(KERN_ERR "rtc: cannot register IRQ %d\n", rtc_irq);*/
			/*return -EIO;*/
		/*}*/

	//a non 0 return means init_module failed; module can't be loaded.
	return 0;
}

/*static irqreturn_t rtc_interrupt(int irq, void *dev)*/
/*{*/
	/*
	* Can be an alarm interrupt, update complete interrupt,
	* or a periodic interrupt. We store the status in the
	* low byte and the number of interrupts received since
	* the last read in the remainder of rtc_irq_data.
	*/
	/*spin_lock(&rtc_lock);*/
	/*rtc_irq_data += 0x100;*/
	/*rtc_irq_data &= ~0xff;*/
	/*rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);*/
	/*if (rtc_status & RTC_TIMER_ON)*/
		/*mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);*/
	/*spin_unlock(&rtc_lock);*/
	/*
	* Now do the rest of the actions
	*/
	/*spin_lock(&rtc_task_lock);*/
	/*if (rtc_callback)*/
		/*rtc_callback->func(rtc_callback->private_data);*/
	/*spin_unlock(&rtc_task_lock);*/
	/*wake_up_interruptible(&rtc_wait);*/
	/*kill_fasync(&rtc_async_queue, SIGIO, POLL_IN);*/
	/*return IRQ_HANDLED;*/
/*}*/

/*
 * the function with this signature is called when the module is removed from the kernel
 * */
void cleanup_module(void)
{
	printk(KERN_INFO "cheat cleanup_module\n");
}
