%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
extern int yylineno;
%}

%token IDENTIFIER
%token INTEGER FLOAT
%token intval ifit elseit whloop show start del
%token ARROW PLUSOP
%token LPAR RPAR SEMI


%define parse.error verbose 

%%

Prog : start Block del
     ;

Block : LPAR CmdList RPAR
      ;

CmdList : Cmd CmdList
        | /* empty */
        ;

Cmd : VarDecl SEMI
    | AssignCmd SEMI
    | CondCmd
    | LoopCmd
    | OutCmd SEMI
    ;

VarDecl : intval IDENTIFIER
        ;

AssignCmd : IDENTIFIER ARROW Expr
          ;

OutCmd : show Expr
       ;

CondCmd : ifit LPAR Expr RPAR Block elseit Block
        ;

LoopCmd : whloop LPAR Expr RPAR Block
        ;

Expr : IDENTIFIER
     | INTEGER
     | FLOAT
     | Expr PLUSOP Expr
     ;

%%

void yyerror(const char *s) {
    printf("Syntax Error at line %d: %s\n", yylineno, s);
}

int main() {
    if (yyparse() == 0) {
        printf("Syntax analysis successful\n");
    }
    return 0;
}