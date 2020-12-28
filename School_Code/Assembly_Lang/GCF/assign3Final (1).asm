**************************************
*
* Name:Joseph Tierney
* ID:18164679
* Date:10/3/19
* Lab3
*
* Program description:This program will compare 2 numbers and find the GCF of the 2 numbers
* Pseudocode:
*#include<stdio.h>
*#include<stdlib.h>
*int main()
*{
*                unsigned int num1 = 1;
*                unsigned int num2 = 250;
*                unsigned int rega = 0;
*                unsigned int regb = 0;
*                unsigned int divisor = 0;
*                unsigned int dividend = 0;
*                unsigned int check = 0;
*                unsigned int GCF = 0;
*                if(num1 < num2)              //Checks to see if number 1 less than number 2 if this is the case num1 will be declared the divisor and num2 the dividend
*                {
*                                divisor = num1;
*                                rega = divisor;
*                                dividend = num2;
*                                regb = dividend;
*                }
*                if(num2 < num1) //Checks to see if number 1 less than number 2 if this is the case num1 will be declared the divisor and num2 the dividend
*                {
*                                divisor = num2;
*                                rega = divisor;
*                                dividend = num1;
*                                regb = dividend;
*                }
*                if(num1 == num2) //will see if the numbers are the same if they are the GCF will be set as the value in num1
*                {
*                                GCF = num1;
*                }
*                GCF = divisor;
*                if(num2 == 0)
*                {
*                        GCF = num1;
*                        check = 1;
*                }
*                if(num1 == 0)
*                { 
*                       GCF = num2;
*                       check = 1;
*                }
*                GCF++;
*                while(check == 0) //will loop till check has been changed
*                {
*                                rega = divisor;
*                                regb = dividend;
*                                GCF--;
*                                while(GCF <= rega) //will look to see if the value given for the GCF is divisable for the divisor
*                                {
*                                        rega = rega - GCF;
*                                        if(rega == 0) //if the remainder from the first while loop is 0 that means that it was divisable so it will be tested against the dividend
*                                        {
*                                                        while(GCF <= regb) //diviend is tested against the GCF
*                                                        {
*                                                                        regb -= GCF;
*                                                        }
*                                                        if(regb == 0) //will set check to 1 so that it will exit the while loop with the appropriate GCF
*                                                        {
*                                                                        check = 1;
*                                                        }
*                                        }
*                                }
*                }
*                return 0;
*}
*
**************************************

* start of data section

		ORG $B000
NUM1		FCB	255
NUM2		FCB	1

		ORG $B010
GCD		RMB	1
REMAINDER	RMB	1
DIVISOR	RMB	1
DIVIDEND	RMB	1
CHECK		RMB	1
* define any other variables that you might need here using RMB (not FCB or FDB)


	ORG $C000
* start of your program
		CLR	GCD
		CLR	REMAINDER
		CLR	DIVISOR
		CLR	DIVIDEND
		CLR	CHECK
		LDAA	NUM1
		LDAB	NUM2
		CMPA	#$00
		BEQ	IF2
		CMPB	#$00
		BEQ	IF6
		CMPA	NUM2
		BHI	IF
		BLO	IF1
		BEQ	IF2
IF		STAA	DIVIDEND	  if(num1 < num2) THIS IF STATEMENT WILL SET THE DIVISOR AND THE DIVIDEND  
		STAB	DIVISOR
		BRA	ENDIF
IF1		STAA	DIVISOR	if(num2 < num1) THIS IS THE IF STATEMENT THAT WILL SET THE DIVISOR AND DIVIEND FOR NUM2 BEING GREATER
		STAB	DIVIDEND
		BRA	ENDIF
IF2		LDAA	NUM2		if(num1 == 0) WILL SET GDF TO NUM1 AND CHECK TO 1
		STAA	GCD
		LDAB	#$01
		STAB	CHECK
		BRA	ENDIF2
IF6		LDAB	NUM1		if(num2 == 0) WILL SET GDF TO NUM2 AND CHECK TO 1	
		STAB	GCD
		LDAA	#$01
		STAA	CHECK
		BRA	ENDIF6
ENDIF
		LDAA	DIVIDEND
IF7		CMPA	DIVISOR	if(num1 == num2) SET CHECK TO ONE AND GCD TO NUM1
		BEQ	ENDIF7
		STAA	GCD
ENDIF7	
		LDAA	DIVISOR
		STAA	GCD
		INC	GCD
WHILE		LDAB	CHECK		while(check == 0) STARTS THE LOOP THAT WILL CHECK TO SEE WHAT GCD THE DIVISOR WILL HAVE THEN SEE IF THE DIVIDEND SHARES THAT VALUE
		CMPB	#$01
		BEQ	ENDWHILE
		LDAA	DIVISOR
		DEC	GCD
WHILE1		CMPA	GCD		while(GCF <= rega) GCF OF THE DIVISOR
		BLO	ENDWHILE1
		SUBA	GCD
		BRA	WHILE1
ENDWHILE1
IF3		CMPA	#$00		if(rega == 0) SEES IF THE REGISTER WITH THE VALUE OF THE DIVISOR IS AT 0 SIGNIFING A GDC
		BNE	ENDIF3
		LDAA	DIVIDEND
WHILE2		CMPA	GCD		while(GCF <= regb) TESTS THAT GDC AGAINST THE DIVIDEND	
		BLO	ENDWHILE2
		SUBA	GCD
		BRA	WHILE2
ENDWHILE2
IF4		CMPA	#$00		 if(regb == 0) CONFIRMS IF IT IS AND THEN SETS CHECK TO 1 SO THE LOOP CAN EXIT
		BNE	ENDIF4
		LDAB	#$01
		STAB	CHECK
ENDIF3
ENDIF4
		BRA	WHILE
ENDWHILE
ENDIF6
ENDIF2
DONE	BRA	DONE			  return 0; ENDS THE PROGRAM