/* 识别计算器记号 */

%{
  enum yytokentype {
    NUMBER = 258,
    ADD    = 259,
    SUB    = 260,
    MUL    = 261,
    DIV    = 262,
    ABS    = 263,
    EOL    = 264,
  };
  int yylval;
%}

%%
"+"       {return ADD;}
"-"       {return SUB;}
"*"       {return MUL;}
"/"       {return DIV;}
"|"       {return ABS;}
[0-9]+    {yylval = atoi(yytext); return NUMBER;}
\n        {return EOL;}
[ \t]     { /* skip space */ }
.         {printf("Mystery character %c\n", *yytext);}
%%

int main(int argc, char **argv) 
{
  int tok;

  // 用于调试
  /* while (tok = yylex()) { */
  while ((tok = yylex())) {
    printf("%d", tok);
    if(tok == NUMBER) printf(" = %d\n", yylval);
    else printf("\n");
  }

  return 0;
}

int yywrap() {
    return 1;
}
