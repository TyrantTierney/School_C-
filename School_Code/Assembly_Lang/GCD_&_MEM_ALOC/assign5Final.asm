**************************************
*
* Name: Joseph Tierney
* ID: 18164679
* Date: 11/4/19
* Lab5
*
* Program description:This program will pass values of the given table to the stack and allocate memory in the stack, it will then load the stack pointer to X and utilize the stack to store and access variables,
* with these variable it will find the GCD of the values from the table, until it has reached a point on the table where both values are $FF
* 
*
* Pseudocode of Main Program:
*#include<stdio.h>
*#include<stdlib.h>
*int GCD(int A,int B);
*int main()
*{	
*	int table1[] = {222,37,16,55,55,1,3,22,255};	
*	int table2[] = {37,222,240,5,55,15,22,3,255};
*	int result[8];
*	int* ptrx;
*	int* ptry;
*	ptrx = table1;
*	ptry = table2;
*	int counter = 0;
*	while(*ptrx != 255)		//makes a pointer so that I can navigate the array
*	{
*		while(*ptry != 255)		//makes a pointer that can navigate the 2nd array to the other table
*		{
*			result[counter] = GCD(*ptrx,*ptry);
*			ptry++;
*			ptrx++;
*			counter++;
*		}
*	}
*	counter = 0;
*	while(counter <= 8)			//prints my results
*	{
*		printf("%d result\n", result[counter]);
*		counter++;
*	}  
*	return 0;
*}
*
*---------------------------------------
*
* Pseudocode Subroutine
*int GCD(int A,int B)
*{
*	printf("A: %d,B: %d\n",A,B);
*	int divisor = 0;
*	int dividend = 0;
*	int tempend = 0;
*	int tempdiv = 0;
*	int check = 0;
*	int GCD = 0;
*	if(A > B)			//declares the dividend and the divisor or the function for A being greater than B
*	{
*		divisor = B;
*		tempdiv = B;
*		dividend = A;
*		tempend = A;
*	}
*	if(A < B)			//declares the dividend and the divisor or the function for A being greater than B
*	{
*		divisor = A;
*		tempdiv = A;
*		dividend = B;
*		tempend = B;
*	}
*	if(A == 0)			//declares the GCD as B if A is 0
*	{
*		GCD = B;
*		check = 1;
*	}
*	if(B == 0)			//declares the GCD as A if B is 0
*	{
*		GCD = A;
*		check = 1;
*	}
*	if(A == B)			//sets the GCD as A if A and B are equal
*	{
*//		printf("A2: %d\n",A);
*		check = A;
*	}
*	GCD = divisor;
*	GCD++;
*	while(check == 0)		//iterates the GCD through the loop dividing it by itself will be tested against the dividend
*	{
*		tempdiv = divisor;
*		tempend = dividend;
*		GCD--;
*//		printf("GCD:%d\t tempend:%d\n",GCD,tempend);
*//		printf("GCD:%d\t tempdiv:%d\n",GCD,tempdiv);
*		while(GCD <= tempdiv)
*		{	
*//			printf("GCD:%d\t tempdiv:%d\n",GCD,tempdiv);
*			tempdiv = (tempdiv - GCD);
*			if(tempdiv == 0)
*			{
*				while(GCD <= tempend)
*				{
*//					printf("GCD:%d\t tempendF:%d\n",GCD,tempend);
*					tempend = (tempend - GCD);
*//					printf("GCD:%d\t tempendF:%d\n",GCD,tempend);
*				}
*				if(tempend == 0)
*				{
*					check = 1;
*				} 
*			}
*		}	
*	}
*	GCD = check;
*	printf("GCD: %d\n",GCD );
*	return GCD;
*}
*
***************************************
* start of data section

	ORG $B000
TABLE1	FCB	222,  37, 16,  55,  55,  1,   3, 22, $FF
TABLE2	FCB	37,  222, 240,  5, 55, 15,  22,  3, $FF

	ORG $B020
RESULT	RMB	8
ADDRESSR	RMB	2

* define any other variables that you might need here 
* remember that your subroutine must not access any of these variables,
* including TABLE1, TABLE2, and RESULT
********************************
* initalizing the pointers and making room in the stack for the stack variables in the sub routine
********************************
	ORG $C000
	LDS	#$01FF		initialize stack pointer
	LDX	#TABLE1
	LDY	#TABLE2
	PSHY
	LDY	#RESULT	
	STY	ADDRESSR	gives addressr the value of RESULTS address
	PULY
	DES			TEMP variable on stack
	DES			DIVIDEND variable on stack
	DES			DIVISOR variable on stack
	DES			CHECK	variable on stack
	DES			GCF variable on stack
*********************************
* the loop that will go until both the value in TABLE1 and TABLE2 are the same
*********************************
WHILE	LDAA	0,X		while(*ptry != 255)
	LDAB	0,Y
IFFF	CMPA	#$FF
	BNE	ENDIFFF
	CMPB	#$FF
	BNE	ENDIFFF
	BRA	ENDWHILE
ENDIFFF
***********************************
* pushes the values from both tables to the stack throught the a register
***********************************
	PSHA			sending the A value to the stack
	PSHB			sending the B value to the stack
	PSHX			sending the address of the X register to the stack
	JSR	SUB		result[counter] = GCD(*ptrx,*ptry);
	PULX			getting the address of the X register back
	PULA			
	PULA
	PULA			getting the value for GCD from the stack
	DES
	PSHY			stores the Y address on the stack
	LDY	ADDRESSR	Y points to the address of return
	STAA	0,Y		result[counter] = GCD(*ptrx,*ptry);
	INY			
	STY	ADDRESSR	
	PULY			Y address is pulled from the stack returnin it to its normal value
	INX			ptrx++;
	INY			ptry++;
	BRA	WHILE
ENDWHILE
**********************************
*Remove the gaps that you have made for the stack so the memory is freed
**********************************
	INS			returns the stack to its original location
	INS
	INS
	INS
	INS
DONE	BRA	DONE		return 0;
* start of your program



* NOTE: NO STATIC VARIABLES ALLOWED IN SUBROUTINE


		ORG $D000
* start of your subroutine
*************************************
* Declaration and setting of variables in the subroutine in respect to X
************************************* 
SUB		TSX			the X register points to the SP location and SP is decremented 1
		LDAA	#$00
		STAA	6,X		sets all values in the stack that haven't been used but space has been allocated to them to 0
		STAA	7,X
		STAA	8,X
		STAA	9,X
		STAA	10,X
*************************************
* sets variables to positions in the stack that I have declared,DIVISOR and DIVIDEND
*************************************
		LDAA	4,X
		CMPA	5,X		
		BEQ	IFE
		BHI	IFH
		BLO	IFL
IFE		STAA	6,X			if(A == B) GCD is set to the value for TABLE1
		LDAB	#$01
		STAB	10,X			CHECK is set to 1
		BRA	ENDIFE
IFH		STAA	9,X			if(A > B) DIVIDEND is set to TABLE1 value
		LDAB	5,X		
		STAB	8,X			DIVISOR is set to TABLE2 value
		BRA	ENDIFH
IFL		STAA	8,X			if(A < B) DIVISOR is set to TABLE1 value
		LDAB	5,X
		STAB	9,X			DIVIDEND is set to TABLE2 value
		BRA	ENDIFL
ENDIFE
ENDIFH
ENDIFL
***************************************
* checking for 0 then setting GCD to $FF if the value in ethier table is 0
***************************************
IFZ1		LDAA	4,X			if(A == 0)
		CMPA	#$00
		BNE	ENDIFZ1
		LDAB	#$FF
		STAB	6,X			GCD is set to $FF
		LDAB	#$01
		STAB	10,X			CHECK is set to 1
ENDIFZ1
IFZ2		LDAA	5,X			if(B == 0)
		CMPA	#$00
		BNE	ENDIFZ2
		LDAB	#$FF			GCD is set to $FF
		STAB	6,X
		LDAB	#$01			CHECK is set to 1
		STAB	10,X
ENDIFZ2
***************************************
* finding the GCF using the variables set in the stack
***************************************
IFW		LDAA	10,X
		CMPA	#$01
		BEQ	ENDIFW
		LDAA	8,X
		STAA	7,X
ENDIFW	
WHILESUB	LDAA	10,X			while(check == 0)
		CMPA	#$01
		BEQ	ENDWHILESUB
		LDAA	8,X
WHILEDIV	CMPA	7,X			while(GCD <= tempdiv)
		BLO	ENDWHILEDIV
		SUBA	7,X
		BRA	WHILEDIV
ENDWHILEDIV
IF1		CMPA	#$00			if(tempdiv == 0)
		BNE	ENDIF1
		LDAA	7,X
		STAA	6,X
		LDAA	9,X
WHILEEND	CMPA	7,X			while(GCD <= tempend)
		BLO	ENDWHILEEND
		SUBA	7,X
		BRA	WHILEEND
ENDWHILEEND
IF2		CMPA	#$00			if(tempend == 0)
		BNE	ENDIF2
		LDAA	7,X
		STAA	6,X
		LDAA	#$01
		STAA	10,X			check = 1;
ENDIF1
ENDIF2
		DEC	7,X			GCD--;
		BRA	WHILESUB
ENDWHILESUB
		TXS				The stack is pointing to its location it was before TSX
		RTS				return GCD;
