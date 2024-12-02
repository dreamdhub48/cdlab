%{
            /*Definition Section*/
    #include <stdio.h> 
    int flag = 0;         
%}

%{
    int yylex();     
    void yyerror();      
%}

        /*Token Section*/
    %token ONE ZERO NL  /* Tokens for '0', '1', and newline */

        /*Grammar Rules*/
%%
    str1:
        str2 n1 { }       /* The start symbol that leads to the grammar checking */

    str2:
        ZERO str2 ONE { } /* Rule to match zero or more '0's followed by an equal number of '1's */
    | ZERO ONE { }      /* Base case: '0' followed by '1' */

    n1:
        NL { return(0); }  /* End of string with newline character (valid case) */

%%

            /*Subroutine Section*/

        /* Driver Code */
    void main() {
        printf("\nEnter a string (any combination of 0 and 1):\n");
        yyparse();  /* Parse the input string using YACC grammar rules */
        if (flag == 0) {
            printf("\nEntered string is valid for L=[0^n1^n]\n\n");
        }
    }

        /* Error Handling Function */
    void yyerror() {
        printf("\nEntered string is invalid for L=[0^n1^n]\n\n");
        flag = 1;
    }