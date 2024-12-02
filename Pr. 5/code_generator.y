%{
            /*Definition Section*/
    #include "y.tab.h"  
    #include <stdio.h>  
    char addtotable(char, char, char);  

    int index1 = 0;  /* Index for storing expressions in the table */
    char temp = 'A' - 1;  /* Temporary result variable initialized */

    struct expr {
        char operand1;
        char operand2;
        char operator;
        char result;
    };

        /*Union Section*/
    %union {
        char symbol;
    }

        /*Precedence and Associativity*/
    %left '+' '-'
    %left '*' '/' 

        /*Tokens Section*/
    %token <symbol> LETTER NUMBER
    %type <symbol> exp

        /*Grammar Rules*/
%%
    statement:
        LETTER '=' exp ';' { addtotable((char)$1, (char)$3, '='); };  

    exp:
        exp '+' exp { $$ = addtotable((char)$1, (char)$3, '+'); }   /* Addition */
        | exp '-' exp { $$ = addtotable((char)$1, (char)$3, '-'); }  /* Subtraction */
        | exp '/' exp { $$ = addtotable((char)$1, (char)$3, '/'); }  /* Division */
        | exp '*' exp { $$ = addtotable((char)$1, (char)$3, '*'); }  /* Multiplication */
        | '(' exp ')' { $$ = (char)$2; }  /* Parentheses */
        | NUMBER { $$ = (char)$1; }  /* Number */
        | LETTER { $$ = (char)$1; }   /* Variable */
        ;

%%

            /*Subroutine Section*/

        /* Error Handling Function */
    void yyerror(char *s) {
        printf("Error: %s\n", s);
    }

        /* Function to add expressions to the table */
    char addtotable(char a, char b, char o) {
        temp++;  /* Increment temporary result variable */
        arr[index1].operand1 = a;
        arr[index1].operand2 = b;
        arr[index1].operator = o;
        arr[index1].result = temp;
        index1++;  /* Increment index */
        return temp;
    }

        /* Print Three-Address Code */
    void threeAdd() {
        int i = 0;
        while (i < index1) {
            printf("%c :=\t", arr[i].result);
            printf("%c\t", arr[i].operand1);
            printf("%c\t", arr[i].operator);
            printf("%c\t", arr[i].operand2);
            i++;
            printf("\n");
        }
    }

        /* Print Four-Address Code */
    void fouradd() {
        int i = 0;
        while (i < index1) {
            printf("%c\t", arr[i].operator);
            printf("%c\t", arr[i].operand1);
            printf("%c\t", arr[i].operand2);
            printf("%c", arr[i].result);
            i++;
            printf("\n");
        }
    }

        /* Find the index of a given label */
    int find(char l) {
        int i;
        for (i = 0; i < index1; i++) {
            if (arr[i].result == l) break;
        }
        return i;
    }

        /* Print Triple Address Code */
    void triple() {
        int i = 0;
        while (i < index1) {
            printf("%c\t", arr[i].operator);
            if (!isupper(arr[i].operand1))
                printf("%c\t", arr[i].operand1);
            else {
                printf("pointer");
                printf("%d\t", find(arr[i].operand1));
            }
            if (!isupper(arr[i].operand2))
                printf("%c\t", arr[i].operand2);
            else {
                printf("pointer");
                printf("%d\t", find(arr[i].operand2));
            }
            i++;
            printf("\n");
        }
    }

    /* YYWRAP Function */
    int yywrap() {
        return 1;
    }

        /* Main Function */
    int main() {
        printf("Enter the expression: ");
        yyparse();  /* Start parsing the input expression */
        threeAdd();  /* Print Three-Address Code */
        printf("\n");
        fouradd();  /* Print Four-Address Code */
        printf("\n");
        triple();  /* Print Triple Address Code */
        return 0;
    }