/*
posix threads.

Complex model with around 100 functions prefixed by `pthread`.

c11 will introduce a standard threading model,
so in time this may become less important

Each thread has its own stack, but unlike process, global memory is shared.

Quicker to start than a process because less resource copy is needed.

In Linux, based on the `clone` system call.

In gcc you must compile with `-pthread`.
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include <pthread.h>

#define NUM_THREADS      5

void* main_thread( void* argument )
{
    int tid;

    tid = *((int*)argument);
    printf( "tid %d\n", tid );

    return NULL;
}

int main( int argc, char** argv )
{
    pthread_t threads[NUM_THREADS];
    int thread_args[NUM_THREADS];
    int rc, i;

    /* create all threads */
    for ( i = 0; i < NUM_THREADS; ++i )
    {
        printf( "create: %d\n", i );
        thread_args[i] = i;
        rc = pthread_create( &threads[i], NULL, main_thread, (void *) &thread_args[i] );
        assert( 0 == rc );
    }

    /* wait for all threads to complete */
    for ( i = 0; i < NUM_THREADS; ++i )
    {
        rc = pthread_join( threads[i], NULL );
        assert( 0 == rc );
    }

    exit( EXIT_SUCCESS );
}
