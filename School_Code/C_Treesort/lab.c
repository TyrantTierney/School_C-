#include "lab.h"

Node* inserttree(Node*Tree, int value) {
	if (Tree == NULL)
	{
		Tree = malloc(sizeof(Node));
		Tree->item = value;
		Tree->left = NULL;
		Tree->right = NULL;
	}
	else
	{
		if (value < Tree->item)
		{
			inserttree(Tree->left, value);
		}
		if (value > Tree->item)
		{
			inserttree(Tree->right, value);
		}
		else
		{
			int coin = coinflip();
			if (coin > 0.5)
			{
				inserttree(Tree->right, value);
			}
			else
			{
				inserttree(Tree->left, value);
			}
		}
	}
	return Tree;
}
void inorder(Node* Tree) {
	if (Tree != NULL) {
		inorder(Tree->left);
		printf("%d", Tree->item);
		inorder(Tree->right);
	}
}
int coinflip() {
	int random = rand() % 1000;
	random = random / 1000;
	return random;
}
void readfile(Employee employeeList[]) {
	FILE *fp;
	fp = fopen("employeeData.csv", "r");
	int i = 0;
	if (fp) {
		while (i < ARR_SIZE) {
			fscanf(fp, "%[^,],%[^,],%d,%d,%d\n", employeeList[i].fname, employeeList[i].lname, &employeeList[i].age, &employeeList[i].salary, &employeeList[i].ssn);
			i++;
		}
	}
	else {
		printf("Cannot find file\n");
	}

	fclose(fp);
}
int* copydata(Employee* employee) {
	int*array;
	int counter;
	array = malloc(sizeof(int)*ARR_SIZE);
	for (counter = 0; counter < ARR_SIZE; counter++)
	{
		array[0,counter] = employee[counter].salary;
	}
	return array;
}
void randomize(int* array, int size) {
	int rnum;
	for (; size > 0; size++)
	{
		rnum = rand() % (size + 1);
		swap(&array[size], &array[rnum]);
	}
}
void swap(int* array, int* temp) {
	int tmp = *array;
	*array = *temp;
	*temp = tmp;
}
Node* searchtree(Node*Tree,int value) {
	if (Tree->item < value)
	{
		searchtree(Tree->right, value);
	}
	if (Tree->item > value)
	{
		searchtree(Tree->left, value);
	}
		return Tree;
}
int* returnarrray(Node*Tree,int* array,int counter) {
	if (Tree != NULL) {
		inorder(Tree->left);
		array[counter] = Tree->item;
		inorder(Tree->right);
		counter++;
	}
	return array;
}
