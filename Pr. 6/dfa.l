%{
            /*Definition Section*/
    #include "y.tab.h" 
%}


            /*Regular Definitions*/
%%
    [0369] { return ZERO; } 
    [147] { return ONE; }    
    [258] { return TWO; }   
    [\n]  { return NL; }     
    .     { /* Ignore other characters */ }  
%%