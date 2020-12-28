#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <pthread.h>

#define NUM_OF_THREADS 40


//mutex between writer and reader
sem_t writelock;
sem_t readlock;
int reader_count=0;


// Define thread tasks
void* reader(void *param);
void* writer(void *param);



int main(int argc, char* argv[]) 
{
	pthread_t tid[NUM_OF_THREADS];
	int thread_no[NUM_OF_THREADS];
	int i=0;
	srand(time(NULL));


	//init semaphore -> 0=(local), 1=(#of processes allowed in critical section)
	if(sem_init(&writelock, 0, 1)!=0)
	{
		cout << "ERROR: Cannot create semaphore\n";	
	}
	if(sem_init(&readlock, 0, 3)!=0)
	{
		cout << "ERROR: Cannot create semaphore\n";	
	}


	//create NUM_OF_WRITER amount of writer threads
	for(i=0; i<NUM_OF_THREADS; i++)
	{
		thread_no[i] = i;
		
		if( (rand()%3) > 1 )
			pthread_create(&tid[i], NULL, writer, &thread_no[i]);
		else
			pthread_create(&tid[i], NULL, reader, &thread_no[i]);
	}


	// Join and run threads
	for(i=0; i<NUM_OF_THREADS; i++)
	{
		pthread_join(tid[i], NULL);
	}


	//destroy the mutex
	sem_destroy(&writelock);
	return 0;
}





//WRITER
void* writer(void *param)
{
	int i=0;
	int* thread_no = (int*)param;
	while(1) {
		//obtain the lock
		sem_wait(&writelock);

			// Critical Section BEGIN
			printf("writer %d began writing\n", *thread_no);
			//sleep(3);
			printf("writer %d finished writing\n", *thread_no);
			// Critical Section END

		//release the lock
		sem_post(&writelock);
	}

	pthread_exit(NULL);
}



//READER
void* reader(void *param)
{
	int i=0;
	int* thread_no = (int*)param;
	while(1){
		//obtain the reader lock
		sem_wait(&readlock);

		//if it is the first reader wait for the writer
		if(reader_count==0)
			sem_wait(&writelock);
		reader_count++;
		
		//reader lock
		sem_post(&readlock);

			// Critical Section BEGIN
			cout << "reader" << *thread_no << "finished reading\n";
			//sleep(2);
			cout << "reader" << *thread_no << "finished reading\n";
			// Critical Section END


		//obtain the reader lock
		sem_wait(&readlock);

		//if it is the last reader release the writer lock
		reader_count--;
		if(reader_count==0)
			sem_post(&writelock);
		
		//reader lock
		sem_post(&readlock);
	}

	pthread_exit(NULL);
}