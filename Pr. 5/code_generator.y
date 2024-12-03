- code_generator.y

%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>  /* For strcpy and handling strings */

int index1 = 0;  /* Index to track the expressions in the table */
char temp = 'A' - 1;  /* Temporary variable for storing results */
FILE fpOut;  / Output file pointer */

/* Structure to store operands, operators, and results */
struct expr {
    char operand1;
    char operand2;
    char operator;
    char result;
};

%}

%union {
    char symbol;
}

%left '+' '-'
%left '*' '/'
%token <symbol> LETTER NUMBER
%type <symbol> expression

%%

input:
    line '\n' input
    | '\n' input
    | ;

line:
    LETTER '=' expression {
        fprintf(fpOut, "MOV %s, AX\n", $1);  /* Store the result in AX */
        fprintf(fpOut, "MOV %s, AX\n", $1);  /* Example for storing the result */
    }
    ;

expression:
    LETTER '+' LETTER {
        fprintf(fpOut, "MOV AX, %s\n", $1);
        fprintf(fpOut, "ADD AX, %s\n", $3);
        $$ = $1;  /* Temporary result assignment */
    }
    | LETTER '-' LETTER {
        fprintf(fpOut, "MOV AX, %s\n", $1);
        fprintf(fpOut, "SUB AX, %s\n", $3);
        $$ = $1;
    }
    | LETTER '*' LETTER {
        fprintf(fpOut, "MOV AX, %s\n", $1);
        fprintf(fpOut, "MUL AX, %s\n", $3);
        $$ = $1;
    }
    | LETTER '/' LETTER {
        fprintf(fpOut, "MOV AX, %s\n", $1);
        fprintf(fpOut, "DIV AX, %s\n", $3);
        $$ = $1;
    }
    | LETTER {
        fprintf(fpOut, "MOV AX, %s\n", $1);
        strcpy($$, $1);  /* Copy the result to the $$ symbol */
    }
    ;

%%

int main() {
    FILE *fpInput;

    fpInput = fopen("input.txt", "r");
    if (fpInput == NULL) {
        printf("Error reading input file.\n");
        exit(0);
    }

    fpOut = fopen("output.txt", "w");
    if (fpOut == NULL) {
        printf("Error creating output file.\n");
        exit(0);
    }

    yyin = fpInput;
    yyparse();  /* Start parsing */

    fclose(fpInput);
    fclose(fpOut);
    return 0;
}

void yyerror(char *s) {
    printf("Error: %s\n", s);
}
