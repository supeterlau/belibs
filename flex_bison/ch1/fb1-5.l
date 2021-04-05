%{
#include "fb1-5.tab.h"
%}

%%
"+"       { return ADD;}
"-"       { return SUB;}
"*"       { return MUL;}
"/"       { return DIV;}
"|"       { return ABS;}
"("       { return OP; }
")"       { return CP; }
"//".*    {  }/* 注释部分，忽略 */
[0-9]+    { yylval = atoi(yytext); return NUMBER;}
\n        { return EOL;}
[ \t]     { /* skip space */ }
.         { printf("Mystery character %c\n", *yytext);}
%%

/* 不需要第三部分代码 */

int yywrap() {
    return 1;
}
