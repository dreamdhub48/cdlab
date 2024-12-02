%{
            /*Definition Section*/
    #include <stdio.h>   
    #include "y.tab.h"      
    extern int yylval;  
%}


            /*Regular Definitions*/
%%
    [0-9]+ { 
        yylval = atoi(yytext);   /* Convert matched text to an integer and store in yylval */
        return NUMBER;           /* Return token for a number */
    }

    [\t] ;  /* Ignore tab spaces */

    [\n] return 0; 

    . return yytext[0];

        
            /*Subroutine Section*/
%%
    int yywrap() {
        return 1;
    }