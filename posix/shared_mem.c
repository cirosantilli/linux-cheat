/*
 * example of the fork POSIX function
 * */

#define _XOPEN_SOURCE 700

#include "assert.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"

#include <sys/shm.h>        //getshm
#include <sys/wait.h>       //wait, sleep
#include "unistd.h"

int main( int argc, char** argv )
{
    /*
    #shared memory

        memory that can be accessed by multiple separate processes

        in this example, both parent and child processes access the same shared memory
    */
    {
        int shmid;
        /*
        #shmget

            allocate shared memory

                int shmget(key_t key, size_t size, int shmflg);

            - key: TODO
            - size: num of bytes
            - shmflg: permission flags like for files + other specific flags
                IPC_CREAT is required to allocate the memory

            return:

            - negative if error
            - unique identifier of memory if positive
        */

            shmid = shmget( (key_t)1234, sizeof( int ) * 2, IPC_CREAT | 0666 );
            assert( shmid >= 0 );

        /*
        #shmat

            attach shared memory to current process so it can be used afterwards

                void *shmat(int shm_id, const void *shm_addr, int shmflg);

            - shm_id: memory id given to shmget
            - shm_id: where to map to. Usual choice: `NULL` so the system choses on its own.
            - shm_flg:
        */

            int* shmem = shmat( shmid, NULL, 0 );
            if ( shmem == (void*)-1 )
                assert( false );
            else
            {
                //parent only
                shmem[0] = 1;
                fflush( stdout );
                pid_t pid = fork();
                if ( pid < 0 )
                    assert( false );
                else
                {
                    //child only:
                    if ( pid == 0 )
                    {
                        shmem[0]++;
                        //detach from child:
                        assert( shmdt( shmem ) == 0 );
                        exit( EXIT_SUCCESS );
                    }

                    //parent only:
                    int status;
                    wait( &status );
                    assert( status == EXIT_SUCCESS );
                    assert( shmem[0] == 2 );

                /*
                #shmdt

                    detach shared memory from current process

                        int shmdt( void* shmem );

                    each process should detach it separatelly before deleting the memory
                */

                    //detach from parent:
                    assert( shmdt( shmem ) == 0 );

                /*
                #shmctl

                    controls the shared memory, doing amogst other things its deletion

                        int shmctl(int shm_id, int command, struct shmid_ds *buf);

                    - shm_id returned by shmget
                    - command one of the following:


                        - IPC_STAT: get parameters of memory into buf
                        - IPC_SET:  set parameters of memory to match buf
                        - IPC_RMID: delete memory.

                            It must be detached from all processes, or you get unspecified behaviour.

                    - buf the following struct:

                            struct shmid_ds {
                                uid_t shm_perm.uid;
                                uid_t shm_perm.gid;
                                mode_t shm_perm.mode;
                            }

                        it can be `NULL` for `PIC_RMID`

                    - return: 0 on success, -1 on failure
                */

                    assert( shmctl( shmid, IPC_RMID, NULL ) == 0 );
                    return EXIT_SUCCESS;
                }
            }
    }
}
