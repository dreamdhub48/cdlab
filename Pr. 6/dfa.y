%{
            /*Definition Section*/
    #include <stdio.h>  /* Include standard input-output functions */
    int flag = 0;  /* Flag to indicate the result (divisible by 3 or not) */
%}

%{
    int yylex();  /* Declare the lexer function */
    void yyerror();  /* Declare error handling function */
%}

        /*Tokens Section*/
    %token ZERO ONE TWO NL  /* Tokens for '0', '1', and '2' */
    %start q0  /* Starting state for the DFA */

        /*Grammar Rules*/
%%
    q0:
        ZERO q0 { $$ = $2; }
        | ONE q1 { $$ = $2; }
        | TWO q2 { $$ = $2; }
        | NL { 
            printf("Number is divisible by 3\n");
            return(0); 
        }
        ;

    q1:
        ZERO q1 { $$ = $2; }
        | ONE q2 { $$ = $2; }
        | TWO q0 { $$ = $2; }
        | NL { 
            printf("Number is not divisible by 3, remainder is 1\n"); 
            return(0); 
        }
        ;

    q2:
        ZERO q2 { $$ = $2; }
        | ONE q0 { $$ = $2; }
        | TWO q1 { $$ = $2; }
        | NL { 
            printf("Number is not divisible by 3, remainder is 2\n"); 
            return(0); 
        }
        ;

%%

            /*Subroutine Section*/

        /* Error Handling Function */
    void yyerror() {
        printf("Error in input\n");
    }

        /* Main Function to handle multiple inputs */
    void main() {
        char choice;
        do {
            printf("\nEnter a decimal number to check divisibility by 3:\n");
            yyparse();  /* Parse the input using YACC grammar rules */
            
            printf("\nWould you like to check another number? (y/n): ");
            scanf(" %c", &choice);  /* Take user input to decide if they want to enter another number */
        } while (choice == 'y' || choice == 'Y');
    }