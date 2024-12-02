%{
            /*Definition Section*/
    #include <stdio.h>  /* For input-output operations */
    #include <math.h>   /* For handling math operations (if needed) */
    FILE *fp;          /* File pointer to read input file */
%}

      
            /*Regular Definitions*/
    Binary      [0-1]+
    Oct         [0-7]+
    Dec         [0-9]+
    Hex         [0-9A-F]+
    Float       [-+]?([0-9]+)?\.[0-9]+  /* Handles positive and negative floats */
    Exponent    [-+]?([0-9]*\.[0-9]+)?([eE][-+]?[0-9]+)  /* Exponential notation */


            /*Rules Section*/
%%
    {Binary}        { printf("This is a binary number     : %s\n", yytext); }
    {Oct}           { printf("This is an octal number     : %s\n", yytext); }
    {Dec}           { printf("This is a decimal number   : %s\n", yytext); }
    {Hex}           { printf("This is a hexadecimal number: %s\n", yytext); }
    {Float}         { printf("This is a float number     : %s\n", yytext); }
    {Exponent}      { printf("This is an exponent number : %s\n", yytext); }


            /*Subroutine Section*/
%%
    int main(int argc, char *argv[]) {
        /* Check if input file is provided */
        if (argc < 2) {
            printf("Usage: %s <input_file>\n", argv[0]);
            return 1;
        }

            /* Open the input file */
        fp = fopen(argv[1], "r");
        if (fp == NULL) {
            printf("Error opening file: %s\n", argv[1]);
            return 1;
        }

            /* Set the input file for lexical analysis */
        yyin = fp;
        yylex();  /* Perform lexical analysis */
        fclose(fp);

        return 0;
    }