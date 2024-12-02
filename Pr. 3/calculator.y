%{
            /*Definition Section*/
    #include <stdio.h>   /* Standard input-output header */
    int flag = 0;         /* Flag to check validity of arithmetic expression */
%}

%{
    int yylex();           /* Declare the lexer function */
    void yyerror();        /* Declare error handling function */
%}


        /*Token Section*/
    %token NUMBER 

        /*Precedence Rules*/
    %left '+' '-'   /* Left associative addition and subtraction */
    %left '*' '/' '%'  /* Left associative multiplication, division, and modulus */
    %left '(' ')'   /* Parentheses for grouping */

        /*Grammar Rules*/
%%
    ArithmeticExpression:
        E { 
            printf("\nResult = %d\n", $$);  
            return 0; 
        };

    E:
        E '+' E { $$ = $1 + $3; }    /* Addition */
        | E '-' E { $$ = $1 - $3; }  /* Subtraction */
        | E '*' E { $$ = $1 * $3; }  /* Multiplication */
        | E '/' E { $$ = $1 / $3; }  /* Division */
        | E '%' E { $$ = $1 % $3; }  /* Modulus */
        | '(' E ')' { $$ = $2; }     /* Parentheses grouping */
        | NUMBER { $$ = $1; }        /* Numeric values */
        ;

%%
            /*Subroutine Section*/

        /* Driver Code */
    void main() {
        printf("\nEnter any arithmetic expression which can have operations Addition, Subtraction, Multiplication, Division, Modulus, and Round Brackets:\n");
        yyparse();  /* Parse the input using YACC grammar rules */
        if (flag == 0) {
            printf("\nEntered arithmetic expression is valid\n\n");
        }
    }

    void yyerror() {
        printf("\nEntered arithmetic expression is invalid\n\n");
        flag = 1;
    }