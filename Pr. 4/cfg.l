%{
            /*Definition Section*/
    #include "y.tab.h" 
%}

            /*Regular Definitions*/
%%
    "0" { return ZERO; }   
    "1" { return ONE; }    
    [\n] { return NL; }    
    . ;                   
%%