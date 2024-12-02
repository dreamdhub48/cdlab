%{
            /*Definition Section*/
    #include <stdio.h>
    FILE *fp;
%}


            /*Regular Definitions*/
    digit         [0-9]+
    header        "#include<"[a-zA-Z]+".h>"
    inbuilt       [\t]*"printf(".*")"|[\t]*"scanf(".*")"|[\t]*"clrscr()"|[\t]*"getch()"|[\t]*"exit(.+)"
    comment       [\t ]*"/*".*"*/"[\t]*\n
    main_function "void main()"
    function      [\t]*[a-zA-Z_]+\(.*\)[\t]*\n
    datatype      [\t ]*"int"|[\t ]*"char"|[\t ]*"float"
    operator      [+*/%-]
    terminator    ";"
    bracket1      [\t]*"{"
    bracket2      [\t]*"}"
    loop          [\t ]*"if(".*")"|[\t ]*"else"|[\t ]*"for"|[\t ]*"while"|[\t ]*"do"
    relational    [<>=!]=?|%
    logical       &&|\|\|
    word          [a-zA-Z_][a-zA-Z0-9_]*

            
            /*Rules Section*/
%%
    {digit}         { printf("\n Numbers               :: %s", yytext); }
    {header}        { printf("\n Header File           :: %s", yytext); }
    {inbuilt}       { printf("\n Inbuilt Function      :: %s", yytext); }
    {comment}       { printf("\n Comment               :: %s", yytext); }
    {main_function} { printf("\n Main Function         :: %s", yytext); }
    {function}      { printf("\n User-Defined Function :: %s", yytext); }
    {datatype}      { printf("\n Datatype              :: %s", yytext); }
    {operator}      { printf("\n Operator              :: %s", yytext); }
    {terminator}    { printf("\n Terminator            :: %s", yytext); }
    {bracket1}      { printf("\n Opening Bracket       :: %s", yytext); }
    {bracket2}      { printf("\n Closing Bracket       :: %s", yytext); }
    {relational}    { printf("\n Relational Operator   :: %s", yytext); }
    {loop}          { printf("\n Loop Statement        :: %s", yytext); }
    {logical}       { printf("\n Logical Operator      :: %s", yytext); }
    {word}          { printf("\n Variable or Keyword   :: %s", yytext); }


            /*Subroutine Section*/
%%
    int main(int argc, char *argv[]) {
        if (argc < 2) {
            printf("Usage: %s <input_file>\n", argv[0]);
            return 1;
        }

        fp = fopen(argv[1], "r");
        if (fp == NULL) {
            printf("Error opening file: %s\n", argv[1]);
            return 1;
        }

        yyin = fp;
        yylex();
        fclose(fp);

        return 0;
    }