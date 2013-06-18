/*
 * example of the fork POSIX function
 * */

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"

#include <sys/shm.h>        //getshm
#include <sys/wait.h>       //sleep
#include "unistd.h"

int main( int argc, char** argv )
{
    /*
    #shared memory

        memory that can be accessed by multiple separate processes
    */
    {

        /*
        #shmget

            allocate shared memory

                int shmget(key_t key, size_t size, int shmflg);

            - key: unique identifier used to refer to this memory.
            - size: num of bytes
            - shmflg: permission flags like for files

        */

            key_t key = (key_t)getpid();
            assert( shmget( key, sizeof( int ) * 2, 0755 ) == 0 );

        /*
        #shmat

            attribute shared memory to program address space

                void *shmat(int shm_id, const void *shm_addr, int shmflg);

            - shm_id: memory id given to shmget
            - shm_id: where to map to. Usual choice: `NULL` so the system choses on its own.
            - shm_flg:
        */
            int* sh_mem = shmat( key, NULL, 0 );
            if ( sh_mem == (void*)-1 )
                assert( false );
            else
            {
                //parent only
                sh_mem[0] = 1;
                fflush( stdout );
                pid_t pid = fork();
                if ( pid < 0 )
                    assert( false );
                else
                {
                    //child only:
                    if ( pid == 0 )
                    {
                        sh_mem[0]++;
                        exit( EXIT_SUCCESS );
                    }

                    //parent only:
                    int status;
                    wait( &status );
                    assert( status == EXIT_SUCCESS );
                    assert( sh_mem[0] == 2 );

                /*
                #shmdt

                    delete shared memory

                        int shmdt( void* sh_mem );
                */
                    assert( shmdt( sh_mem ) == 0 );
                    return EXIT_SUCCESS;
                }
            }
    }
}
