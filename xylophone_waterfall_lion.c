#include <stdio.h>
#include <stdlib.h>

//declare constants 
#define MAX_STUDENTS 20 
#define INIT_BALANCE 50.00 

typedef struct{
	char name[50]; 
	int student_id; 
	float end_bal; 
} student; 

//declare function prototypes 
int signup();
int check_balance(int SID); 
int deposit_funds(); 
int transfer_funds(student *s); 

//main function
int main (void) {
	
	//declare student type data structure
	student s[MAX_STUDENTS]; 
	int i; 
	
	//declare counter to track # of students enrolled 
	int num_students = 0;
	
	printf("Welcome to The Fresh Start Initiative! \n"); 
	
	//loop to allow for up to MAX_STUDENTS to sign up
	for (i = 0; i < MAX_STUDENTS; i++){	
		if(signup(&s[i])){	
			printf("You are now enrolled in The Fresh Start Initiative!\n");	
			num_students++; 		
		}	
		else
			printf("We apologize for the inconvenience.\n");
	}	
		
	//loop to allow for students to check balance 
	for (i = 0; i < num_students; i++){
		check_balance(s[i].student_id);
	}
	
	//loop to allow students to deposit funds
	for (i = 0; i < num_students; i++){
		if (deposit_funds(&s[i])){
			printf("You have successfully deposited funds. \n\n");
		}
		else
			printf("We apologise for the inconvenience. \n\n");
	}
	
	//loop to allow students to transfer funds
	for (i = 0; i < num_students; i++){
		if (transfer_funds(&s[i])){
			printf("You have sucessfully transfered funds. \n\n");
		}
		else
			printf("We apologise for the inconvenience. \n\n"); 
	}
	
	//print end of program message
	printf("The Fresh Start Initiative has come to a close. \nWe wish you the best of luck in your financial endeavors. \n\n");
	
	return 0; 
}

//signup function 
int signup(student *s) {
	
	//prompt user for info
	printf("Please enter your name: \n"); 
	scanf("%s", s->name);
	printf("Please enter your student ID: \n"); 
	scanf("%d", &s->student_id);
	
	s->end_bal = INIT_BALANCE; 
	printf("You have been given an initial balance of $%.2f \n", s->end_bal); 
	
	return 1; 
}

//check balance function 
int check_balance(int SID){ 
	
	float balance; 
	
	printf("Please enter your student ID: \n");
	scanf("%d", &SID); 
	printf("Your current balance is: $%.2f \n\n", balance);
	
	return 1; 
}

//deposit funds function 
int deposit_funds(student *s){
	
	float deposit;
	
	printf("Please enter your student ID: \n");
	scanf("%d", &s->student_id);
	printf("Please enter the amount you would like to deposit: \n");
	scanf("%f", &deposit);
	
	s->end_bal = s->end_bal + deposit; 
	
	return 1; 
}

//transfer funds function 
int transfer_funds(student *s){
	
	float transfer;
	
	printf("Please enter your student ID: \n");
	scanf("%d", &s->student_id); 
	printf("Please enter the amount you would like to transfer: \n");
	scanf("%f", &transfer);
	
	s->end_bal = s->end_bal - transfer; 
	
	return 1; 
}