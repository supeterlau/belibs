/* bison 规则 */
/* 只能用这种注释，不支持 // */

%{
#include <stdio.h>

int yylex(); /* C99 */
int yyerror(char *s);
%}

/* 声明 tokens */

%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL 

%%

calctokens: 
  | calctokens exp EOL { printf(" = %d\n", $2); }
  ;

exp: factor /* default $$ = $1 */
  | exp ADD factor { $$ = $1 + $3; }
  | exp SUB factor { $$ = $1 - $3; }
  ;

factor: term /* default $$ = $1 */
  | factor MUL term { $$ = $1 * $3; }
  | factor DIV term { $$ = $1 / $3; }
  ;

term: NUMBER /* default $$ = $1 */
  | ABS term { $$ = $2 >= 0 ? $2 : -$2; }
  /* 处理括号 */
  | OP exp CP { $$=$2; }
  ;

%%

int main(int argc, char **argv) 
{
  yyparse();
  return 0;
}


/* void yyerror(char *s) */
int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
  return 0;
}
