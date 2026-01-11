
%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"  
%}

%option noyywrap
%option yylineno

%%

[ \t\r]+                ;
"//".* ; 
"/*"([^*]|"*"[^/])*"*/" ;

"intval"    { return intval; }
"ifit"      { return ifit; }
"elseit"    { return elseit; }
"whloop"    { return whloop; }
"show"      { return show; }
"start"     { return start; }
"del"       { return del; }

"+>"        { return PLUSOP; }
"->"        { return ARROW; }

"(("        { return LPAR; }
"))"        { return RPAR; }
";;"        { return SEMI; }

[0-9]+_            { return INTEGER; }
[0-9]+\.[0-9]+_    { return FLOAT; }
[A-Z]+[0-9]*_      { return IDENTIFIER; }

.                  { printf("Unknown character: %s\n", yytext); }

%%