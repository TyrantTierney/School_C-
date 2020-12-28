#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#pragma warning(disable:4996)
#define ARR_SIZE 1000

typedef struct Node {
	int item;
	struct Node* left;
	struct Node* right;
} Node;
Node*Tree;

typedef struct employee {
	char fname[25], lname[25];          //first name and last name of an employee
	int age;
	int salary;
	int ssn;
}Employee;

void readfile(Employee*);
Node* createnode(Node*);
Node* inserttree(Node*, int);
void inorder(Node*);
int coinflip();
int* copydata(Employee*);
void randomize(int*, int);
void swap(int*, int*);
Node* searchtree(Node*, int);
int* returnarray(Node*, int*, int);