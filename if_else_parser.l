%{
#include <stdio.h>
int valid = 1;
int parens = 0;
int braces = 0;
int if_keyword = 0;
int has_condition = 0;
%}

%%
"if"     { if_keyword = 1; }
"("      { if (if_keyword && parens == 0) has_condition = 1; parens++; }
")"      { parens--; }
"{"      { braces++; }
"}"      { braces--; }
[a-zA-Z_][a-zA-Z0-9_]*  { /* Ignore identifiers */ }
[0-9]+                  { /* Ignore numbers */ }
[ \t\n]+                { /* Ignore whitespace */ }
.        { /* Ignore other characters */ }

%%

int main() {
    yylex();
    if (valid && if_keyword == 1 && has_condition == 1 && parens == 0 && braces == 0) {
        printf("Input parsed successfully.\n");
    } else {
        printf("Input failed to parse.\n");
    }
    return 0;
}

int yywrap() {
    return 1;
}
