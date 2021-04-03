/* for macOS: */
/* %option noyywrap */
%%
"colour" { printf("color"); }
"flavour" { printf("flavor"); }
"clever" { printf("smart"); }
"smart" { printf("elegant"); }
"conservative" { printf("liberal"); }
. { printf("%s", yytext); }
%%

int main() {
    while (yylex());
    return 0;
}

int yywrap() {
    return 1;
}

// echo colour | ./a.out
