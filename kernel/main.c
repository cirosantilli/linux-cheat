/*
main cheat on kernel modules and on kernel concepts
that can be exemplified in modules (much easier than recompiling and reinstalling the kernel...)

#typedefs

	the kernel uses many typedefed datatypes to ensure:

	- fixed sized integers (the kernel cannot use c99's stdlib `int32_t` family)
	- byte ordering: in some cases it is necessary to use typedefs to ensure big/small endieness

#TODO

	#__user

		userspace values

	#__rcu

		a type of locking directive
*/

#include <linux/interrupt.h>    /* request_irq, IRQF_SHARED */
#include <linux/kernel.h>	/* KERN_INFO */
#include <linux/module.h>	/* module specific utilities: MODULE_* macros, module_param, module_init, module exit */
#include <linux/sched.h>	/* current */
#include <linux/spinlock.h>
#include <linux/version.h>
#include <linux/slab.h>

#define MODID __FILE__ ": "
#define INFO_ID KERN_INFO MODID

/*
#module description

##license

the kernel offers methods to indicate the license of modules or parts of modules
such as symbols

for entire modules, the `MODULE_LICENSE` macro can be used. Possible args:

- "GPL v2" (for GPL version two only)
- "GPL and additional rights"
- "Dual BSD/GPL"
- "Dual MPL/GPL"
- "Proprietary"

where `Dual` means that developers can either use BSD or GPL

If you don't set this, it is taken to be `Proprietary` by default,
'tainting' the module and the kernel,
so always define this if your module is not proprietary.
*/

MODULE_LICENSE("GPL");
MODULE_AUTHOR("John Smith <john.smith@mail.com>");
MODULE_DESCRIPTION("a cheat module");
MODULE_VERSION("0.1");
/*MODULE_DEVICE_TABLE(table_info);*/
/*MODULE_ALIAS("cheat2");*/

/*
#parameters

parameters an be passed to modules at insertion time:

- via command line arguments for `insmod` and `modprobe`
- via conf files in `/etc/modprobe.d/` for `modprobe` only

they are used from inside the program via the module_param macro.

if no vaule is given for them, they remain unchanged

the following types are supported:

- bool
- invbool (returns the negation of bool)
- charp: character pointer
- int, long, short, uint, ulong, ushort

the third is the file permissions for the module representation under `/sys/module/<name>/parameters`:

- `S_IRUGO`: readonly
- `S_IRUGO|S_IWUSR`: writeable by sudo

try:

	cat /sys/module/<thismodule>/parameters/param_i
*/

//declartion and default values of parameters:
static int param_i = 0;
static char *param_s = "aaa";
//static int param_is[] = {0,0,0};

//set values if given:
module_param(param_i, int, S_IRUGO);
module_param(param_s, charp, S_IRUGO);
/* TODO BUG this generates a NULL dereference and kernel oops:*/
/*module_param_array(param_is, int, 3, S_IRUGO);*/

/*
#export symbols

	when the a module gets inserted in to the kernel, it can see symbols defined in the kernel

	however other modules cannot see the symbols defined in a module unless you explicitly
	export them. This can be done with `EXPORT_SYMBOL` and its `GPL` version
*/

static int i_global;

int exported_symbol;
int exported_symbol_gpl;

EXPORT_SYMBOL(exported_symbol);
EXPORT_SYMBOL_GPL(exported_symbol_gpl);

//must be global:
DEFINE_PER_CPU(int, cpu_int);

/*
 * this function is defined as the entry point by the `module_init` call below.
 *
 * using `init_module` as name also worked. TODO why
 *
 * static is not mandatory, but good practice since this function should not be seen
 * from other files.
 *
 * typical things a real module would do here include:
 *
 * - initialize variables
 * - register an interrupt handler
 * - register a the bottom half of the interrupt handler
 *
 * #__init
 *
 * 	tells the compiler that this function is only used once at initialization,
 * 	so the kernel may free up its memory after using this function
 *
 * return value: a non 0 return means init_module failed; module can't be loaded.
 *
 * #__initdata TODO
 * #__initconst TODO
 * #__devinit TODO
 *
 * 	they are used as:
 *
 * 		static int init_variable __initdata = 0;
 * 		static const char linux_logo[] __initconst = { 0x32, 0x36, ... };
 *
 * but what do they do?
 *
 * #cleanup
 *
 * 	module insertion forget to nicely cleanup in case 
 *
 * */
static int __init init(void)
{
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

		printk(INFO_ID "%s\n", __func__ );

	i_global = 0;

	printk(INFO_ID "i_global = %d\n", i_global);

	/*
	#data structures

		the kernel has some basic and effective data structure implementations
		that should be reused whenever possible
	*/
	{
		/*
		#linked lists

			list_head with associated methods and macros is a doubly linked circular linked list

			based on `container_of`

			to understand things better:

				struct list_head {
					list_head *next;
					list_head *prev;
				}

			but you should use methods and macros instead of next and prev directly
		*/
		{
			struct char_list {
				char c; 		/* the actual data */
				struct list_head list;	/* used for the list */
			};

			/*
			#LIST_HEAD

				creates a differentiated `list_head` which shall represent the enteire list

				for example, you would pass this to functions that expect a list
			*/

			LIST_HEAD( alist );

			/*
			#LIST_HEAD_INIT

				links list.next and list.prev to itself:
				the first element of the list

				TODO when to use it? I have seen:

					struct char_list ca = {
						.c = 'a',
						.list = LIST_HEAD_INIT(&ca.list)
					};

				but this does not work properly for example with transversal:
				we need the differentiated element
			*/

			struct char_list ca = {
				.c = 'a',
			};

			/*
			#list_add

				adds the element next to the given one

			#list_add_tail

				adds the element previous to the given one

				if we use THE list head, this is the same as adding to the end of the list
			*/

			list_add_tail(&ca.list, &alist);

			struct char_list cb = {
				.c = 'b'
			};

			list_add_tail(&cb.list, &alist);

			struct char_list cc = {
				.c = 'c'
			};

			list_add_tail(&cc.list, &alist);

			/*
			#list_for_each_entry

				does the whole loop for us

					list_for_each_entry( list* list_pointer, list_head* list_head_ptr, field_name) {

				- list_pointer will contain each value of the list
				- list_head is the list head we want to start from
				- field name: name of the field of the struct that contains the list head

				TODO why is this skipping the a character?
			*/
			printk(INFO_ID "linked list:\n" );
			struct char_list *char_list_ptr;
			list_for_each_entry(char_list_ptr, &alist, list) {
				printk(INFO_ID "  %c\n", char_list_ptr->c );
			}

			/*
			to modify the list items while looping use:

				list_for_each_entry_safe
			*/

			/*
			#container_of

				this macros allows us to get the address of the struct given one of the
				addresses of the fields of the struct

				you don't need to use it directly with lists,
				but clearly it is needed internally to go from the `list_head` to the actual structure

				in general, the advantage of container_of is clear:
				it allows to emulate inheritance independant of the type of structure
				that is inheriting
			*/
			if ( container_of(&ca.list, struct char_list, list) != &ca )
				return 1;
		}
	}

	/*

	#kernel version

		device drivers depend on kernel version.

		you can get some version flexibility with the preprocessor.

		#LINUX_VERSION_CODE

			example: on kernel `2.6.10` == 132618 (i.e., 0x02060a)
	*/

		/* printk( "UTS_RELEASE = %s", UTS_RELEASE ); */	/* TODO get working */
		printk(INFO_ID "LINUX_VERSION_CODE = %d\n", LINUX_VERSION_CODE);

	/*
	#THIS_MODULE

		pointer to the module struct of current module

		the module struct and THIS_MODULE are both defined inside `module.h`

		this struct determines all the information about a module
	*/

		//version is was set with the MODULE_VERSION macro:

		printk(INFO_ID "THIS_MODULE->version = %s\n", THIS_MODULE->version );

	/*
	#parameters
	*/

		printk(INFO_ID "param_i = %d\n", param_i);
		printk(INFO_ID "param_s = %s\n", param_s);
		/*printk("param_is = %d, %d, %d\n", param_is[0], param_is[1], param_is[2]);*/

	/*
	#likely #unlikely

	 	the unlikely function marks a condition as rare, and makes it easier
	 	for compilers and processors to optimize the code

	 	likelly does the exac oposite

	 	those should only be used when the condition is extremelly rare (common)

	 	a typical use case is to test for errors conditions (which should, in theory, be rare...)
	*/

		if (likely(0)) {
			printk(INFO_ID "ERROR\n");
		}

		if (likely(1)) {
			printk(INFO_ID "unlikely(1)\n");
		}

		if (unlikely(0)) {
			printk(INFO_ID "ERROR\n");
		}

		if (unlikely(1)) {
			printk(INFO_ID "unlikely(1)\n");
		}


	/*
	#page

		a page refers to the smallest virtual memory division that the kernel can get,
		usually around 4Kib today. This size is equal to the size of the page frame.

	#page frame

		a page frame refers to the smalles physical memory that the processor can ask
		from the RAM.

	#linking pages to page frames

		it would be too expensive to keep a link from every virtual memory:

			4 GiB / 4 KiB = 1 M structures per processes

		the solution is then to only keep

	#TASK_SIZE

		*virtual memory* is divided as follows:

		- memory from address from 0 to TASK_SIZE - 1 can be used by *each* processes
		- other memory adressses (from  TASK_SIZE to the maxinum adressable memory, 2^32 on 32 bits platforms
				of 2^64 on 64 ) belongs to the kernel

		TASK_SIZE is typically around 3/4 of the total memory

		note that this is *virtual* memory, so it is independant of the acutual size of the memory
		as the hardware and the kernel can give processes the illusion that they actually have
		ammounts of memory larger than the hardware for instance

	*/

		printk(INFO_ID "TASK_SIZE (GiBs) = %lu\n", TASK_SIZE / (1 << 30));

	/*
	#kmalloc

		like libc malloc, but for the kernel

		#flags

			TODO
	*/

		int *kmalloc_is = kmalloc(2 * sizeof(int), GFP_KERNEL);
		kmalloc_is[0] = 0;
		kmalloc_is[1] = 1;
		printk(INFO_ID "kmalloc_is[0] = %d\n", kmalloc_is[0]);
		printk(INFO_ID "kmalloc_is[1] = %d\n", kmalloc_is[1]);
		kfree(kmalloc_is);

	/*
	# process

		the kernel manages user processes and kernel processes, scheduling them with some algorithm
		so that users see all process make some progress more or less at the same time.

		process representation is found under `sched.h` and is named `struct task_struct`

	#threads

		threads are processes that share the same address space so they act on common variables

	#kernel threads

		kernel threads are like user space threads, but are created by the kernel
		and execute on the kernel memory space with kernel priviledges.

		They can also be listed with ps:

	#current

		macro that gives the `task_struct` representing the current process

	#task_struct

		represents processes (called taks on the kern), found in `sched.h`

		#tgid

			thread group id

			same for all threads that TODO have the same data?

		#parent vs real_parent

			TODO

		#priorities and scheduling

			there are two main scheduler used today: completely_fair and real_time

			real time attempts to be real time, but linux maker no guarantees that
			a process will actually run before a given time, only this is very likely

			#state

				processes can be in one of the following states:

				- running:
				- waiting: wants to run, but scheduler let another one run for now
				- sleeping: is waiting for an event before it can run
				- stopped: killed but is waiting for its parent to call wait and get exit status
				- zombie: has been killed, but parent also without calling wait

				these are represented in the `state` field of `task_struct`

				- TASK_RUNNING: running
				- TASK_INTERRUPTIBLE: task is waiting for some event to continue running

			#static_priority

				priority when the process was started

				can be changed with `nice` and `sched_setscheduler` system calls

			#normal_priority

				priority based on the static priority and on the scheduling policy

			#prio

				actual priority. Can be different from normal priority under certain conditions

				that the kernel decides to increase priorities

			#rt_priority

				real time priority. Range: 0 to 99, largest mor urgent.

				Does not replace the other priorities.

			#sched_class

				contains mainly function pointers that
				determine the operation of the scheduler.

			#policy

				#SCHED_NORMAL

					handled by the fair scheduler. Normal tasks.

				#SCHED_BATCH

					handled by the fair scheduler.

					For non interactive jobs so latency is not a major concern,
					and therefore batch jobs get disfavoured.

				#SCHED_IDLE

					handled by the fair scheduler.

					those tasks have the minimum priority,
					and only run when there is nothing else to do.

				#SCHED_RR

					Handled by the real time scheduler.

					TODO

				#SCHED_FIFO

					Handled by the real time scheduler.

					TODO

			#run_list

				used by the real time scheduler only

				TODO

			#time_slice

				used by the real time only

				TODO

		#children

			processes keep a linked list of its children

		#sibling

			processes keep a linked list of its siblings
	*/

		printk(INFO_ID "TASK_RUNNING = %d\n", TASK_RUNNING);
		printk(INFO_ID "TASK_INTERRUPTIBLE = %d\n", TASK_INTERRUPTIBLE);

		//self is obviously running when state gets printed, parent may be not:

			printk(INFO_ID "current->state  = %ld\n", current->state);
			printk(INFO_ID "current->parent->state  = %ld\n", current->parent->state);

		printk(INFO_ID "current->comm = %s\n", current->comm);
		printk(INFO_ID "current->pid  = %lld\n", (long long)current->pid);
		printk(INFO_ID "current->tgid = %lld\n", (long long)current->tgid);

		printk(INFO_ID "current->prio = %d\n", current->prio);
		printk(INFO_ID "current->static_prio = %d\n", current->static_prio);
		printk(INFO_ID "current->normal_prio = %d\n", current->normal_prio);
		printk(INFO_ID "current->rt_priority = %d\n", current->rt_priority);
		printk(INFO_ID "current->policy = %u\n", current->policy);
		printk(INFO_ID "SCHED_NORMAL = %u\n", SCHED_NORMAL);

		printk(INFO_ID "current->nr_cpus_allowed  = %d\n", current->nr_cpus_allowed);

		printk(INFO_ID "current->exit_state = %d\n", current->exit_state);
		printk(INFO_ID "current->exit_code = %d\n", current->exit_code);
		printk(INFO_ID "current->exit_signal = %d\n", current->exit_signal);

		/*  the signal sent when the parent dies  */

			printk(INFO_ID "current->pdeath_signal = %d\n", current->pdeath_signal);

		printk(INFO_ID "current->parent->pid  = %lld\n", (long long)current->parent->pid);
		printk(INFO_ID "current->parent->parent->pid  = %lld\n", (long long)current->parent->parent->pid);
		printk(INFO_ID "current->real_parent->pid  = %lld\n", (long long)current->real_parent->pid);

		//children transversal:
		{
			struct task_struct *task_struct_ptr;
			printk(INFO_ID "current->children pids:\n");
			list_for_each_entry(task_struct_ptr, &current->children, children) {
				printk(INFO_ID "  %lld\n", (long long)task_struct_ptr->pid);
			}
		}

		//siblings transversal:
		{
			struct task_struct *task_struct_ptr;

			printk(INFO_ID "current->sibling pids:\n");
			list_for_each_entry(task_struct_ptr, &current->sibling, children) {
				printk(INFO_ID "  %lld\n", (long long)task_struct_ptr->pid);
			}

			printk(INFO_ID "current->parent->sibling pids:\n");
			list_for_each_entry(task_struct_ptr, &current->parent->sibling, children) {
				printk(INFO_ID "  %lld\n", (long long)task_struct_ptr->pid);
			}
		}

		//struct list_head sibling;	/* linkage in my parent's children list */

		/* threadgroup leader */

			printk(INFO_ID "current->group_leader->pid  = %lld\n", (long long)current->group_leader->pid);

	/*
	#smp

		stands for Symettrical MultiProcessing.

		means using multiple cpus at once (multicore systems)

	#per cpu variables

		<http://www.makelinux.net/ldd3/chp-8-sect-5>

		#DEFINE_PER_CPU

			define a copy of given variable for each cpu

		#get_cpu_var(name);

			get variable for current cpu

			this is a macro, so you can modify the variable with that too

		#put_cpu_var(name);

			must be called after the variable has been modified

		#smp_processor_id()

			get id of current processor

			run this many times and it may change

		#get_cpu(name, cpu)

			like `get_cpu_var`, but from any processor
	*/
	{
		get_cpu_var(cpu_int) = 0;
		put_cpu_var(cpu_int);
		printk(INFO_ID "cpu_int  = %d\n", get_cpu_var(cpu_int));

		printk(INFO_ID "smp_processor_id()  = %d\n", smp_processor_id());
	}

	/*
	#device driver

	there are 3 main types of device drivers:

	- character devices: simplest one. Applications can only access data as a stream, not randomly.

		Useful for devices like mice, keyboard

	- block device: devices like hard disks or dvd readers. Random access is required.

	- network device: TODO
	*/

	/*
	#character device

		they are represented by the struct cdev found in TODO

		dev_t dev;
		int alloc_chrdev_region(&dev, 0, 1, "char_cheat");
	*/


	/*
	#interrupt handler

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

	#request_irq

		this function tells the kernel to use a given interrupt function to deal with certain interrupts

		1. interrupt line. If non existent, will be created.

			this is a number the identifies each type of interrupt (ex: one from the mouse, one from the keyboard, etc.)

			it may be fixed for very traditional devices like the keyboard, but dynamic for most modern devices.

			TODO how to determine a line dynamically?

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

	return 0;
}

module_init(init);

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
 * same as init, with `module_exit` to fix this as exit point.
 *
 * naming this `module_cleanup` worked.
 *
 * # __exit
 *
 * 	if this is module is ever built into the kernel,
 * 	`__exit` functions are simply discarded to make up free space.
 *
 * */
static void __exit cleanup(void)
{
	printk(INFO_ID "%s\n", __func__ );
}

module_exit(cleanup);
