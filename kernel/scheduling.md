# Scheduling

Modern systems are preemptive: they can stop tasks to start another ones, and continue with the old task later

A major reason for this is to give users the illusion that their text editor, compiler and music player can run at the same time even if they have a single CPU.

Scheduling is choosing which processes will run next

The processes which stopped running is said to have been *preempted*

The main difficulty is that switching between processes (called *context switch*) has a cost because if requires copying old memory out and putting new memory in.

Balancing this is a throughput vs latency question.

## Sleep

- <http://www.linuxjournal.com/node/8144/print>

How to sleep in the kernel

Low level method:

    set_current_state(TASK_INTERRUPTIBLE);
    schedule();

Higher level method: wait queues.

## State

Processes can be in one of the following states (`task_struct->state` fields)

-   running: running. `state = TASK_RUNNING`

-   waiting: wants to run, but scheduler let another one run for now

    `state = TASK_RUNNING`, but the scheduler is letting other processes run for the moment.

-   sleeping: is waiting for an event before it can run

    `state = TASK_INTERRUPTIBLE` or `TASK_UNINTERRUPTIBLE`.

-   stopped: execution purposefully stopped for example by `SIGSTOP` for debugging

    `state = TASK_STOPPED` or `TASK_TRACED`

-   zombie: has been killed but is waiting for parent to call wait on it.

    `state = TASK_ZOMBIE`

-   dead: the process has already been waited for,
and is now just waiting for the system to come and free its resources.

    `state = TASK_DEAD`

The following transitions are possible:

    +----------+ +--------+
    |          | |        |
    v          | v        |
    running -> waiting    sleeping
    |                     ^
    |                     |
    +---------------------+
    |
    v
    stopped

## Policy

Policy is the way of choosing which process will run next.

POSIX specifies some policies, Linux implements them and defines new ones.

Policy in inherited by children processes.

### Normal vs real time policies

Policies can be divided into two classes: normal and real time

Real time processes always have higher priority: whenever a real time process is runnable it runs instead of normal processes therefore they must be used with much care not to bog the system down.

The name real time policy is not very true: Linux does not absolutely ensure that process will finish before some deadline.

However, real time processes are very privileged, and in absence of other real time processes without even higher priorities, the processes will run as fast as the hardware can possibly run it.

#### RTAI

#### LinuxCNC

<https://en.wikipedia.org/wiki/RTAI>

<https://en.wikipedia.org/wiki/LinuxCNC>

Real Time Application Interface is a modified Linux kernel for strict real-time, and LinuxCNC is a distribution that uses it.

## Priority

Priority is a measure of how important processes are, which defines how much CPU time they shall get relative to other processes.

There are 2 types of priority:

-   real time priority.

    Ranges from 0 to 99

    Only applies to process with a real time scheduling policy

-   normal priorities.

    Ranges from -20 to 19

Only applies to processes with a normal scheduling policy.

Also known as *nice value*. The name relates to the fact that higher nice values mean less priority, so the process is being nice to others and letting them run first.

Nice has an exponential meaning: each increase in nice value means that the relative importance of a process increases in 1.25.

For both of them, lower numbers mean higher priority.

Internally, both real time and normal priorities are represented on a single integer which ranges from 0 to 140:

- real time processes are in the 0 - 99 range
- normal processes are in the 100 - 140 range

Once again, the lower values correspond to the greater priorities.

Priority is inherited by children processes.

### Nice

Is the traditional name for normal priority, ranging from -20 (greater priority) to 19.

An increase in 1 nice level means 10% more CPU power.

## Normal policies

### Completely fair scheduler

All normal processes are currently dealt with internally by the *completelly fair scheduler* (CFS).

The idea behind this scheduler is imagining a system where there are as many CPU's as there are processes a system where there are as many CPU's as there are processes

Being fair means giving one processor for each processes.

What the CFS tries to do is to get as close to that behaviour as possible, even though the actual number of processors is much smaller.

### Normal scheduling policy

Represented by the `SCHED_NORMAL` define.

### Batch scheduling policy

Represented by the `SCHED_BATCH` define

Gets lower priority than normal processes TODO exactly how much lower.

### Idle scheduling policy

The lowest priority possible.

Processes with this policy only run when the system has absolutely.

Represented by the `SCHED_IDLE` define.

## Real time policies

### FIFO

Represented by the `SCHED_FIFO` define

Highest priority possible.

Handled by the real time scheduler.

The process with highest real time priority runs however much it wants.

It can only be interrupted by:

- another real time processes with even higher priority becomes RUNNABLE
- a `SIGSTOP`
- a `sched_yield()` call
- a blocking operation such as a pipe read which puts it to sleep

Therefore, lots of care must be taken because an infinite loop here can easily take down the system.

### Round robin

Represented by the `SCHED_RR` define.

Processes run fixed amounts of time proportional to their real time priority.

Like turning around in a pie where each process has a slice proportional to it real time priority

Can only be preempted like FIFO processes, except that it may also be preempted by other round robin processes.

TODO if there is a round robin and a FIFO processes, who runs?

## Swapper process

When there are no other processes to do, the scheduler chooses a (TODO dummy?) processes called *swapper process*

## Run queues

A run queue is a list of processes that will be given cpu time in order which process will be activated.

It is managed by schedulers, and is a central part of how the scheduler chooses which process to run next

There is one run queue per processor.
