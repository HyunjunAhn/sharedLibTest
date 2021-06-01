#include <stdio.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>

void *thFunc(void *arg)
{
    sem_t *sem = (sem_t *)arg;
    for(;;)
    {
        usleep(3000000);
        sem_post(&sem[0]);
        sem_wait(&sem[1]);
        usleep(1000000);
        sem_post(&sem[2]);
    }
}

void testLib()
{
    sem_t sem[3];
    pthread_t thId;
    static int cnt;
    
    sem_init(&sem[0], 0, 0);
    sem_init(&sem[1], 0, 0);
    sem_init(&sem[2], 0, 0);
    pthread_create(&thId, NULL, thFunc, (void *)&sem);

    for(;;)
    {
        sem_wait(&sem[0]);
        printf("[%3d] A\n", cnt);
        sem_post(&sem[1]);
        sem_wait(&sem[2]);
        printf("[%3d] B\n", cnt);
        cnt++;
    }
}
