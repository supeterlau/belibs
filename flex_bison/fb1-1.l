/* flex version wc */ 

%{
  int chars = 0;
  int words = 0;
  int lines = 0;
%}
/* for macOS: */
%option noyywrap
%%
/* [a-zA-Z]+     { words++; chars += strlen(yytext); } */
[^ \t\n\r\f\v]+    { words++; chars += strlen(yytext); }
\n            { chars++; lines++; }
.             { chars++; }
%%

int main(int argc, char **argv)
{
  yylex();
  printf("lines: %8d\nwords: %8d\nchars: %8d\n", lines, words, chars);
  return 0;
}
