#include "lab.h"

int main()
{
	Employee employeeList[ARR_SIZE];
	readfile(employeeList);
	int*array = copydata(employeeList);
	//int*pointer = malloc(sizeof(int)*ARR_SIZE);
	randomize(array, ARR_SIZE);
	Node* Tree = NULL;
	int counter;
	int value = 0;
	for (counter = 0; counter < ARR_SIZE; counter++)
	{
		value = array[counter];
		Tree = inserttree(Tree, value);
	}
	inorder(Tree);
	Tree = searchtree(Tree, 7);
	counter=0;
	array = returnarrray(Tree, array, counter);
	return 0;
}