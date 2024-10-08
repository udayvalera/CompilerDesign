%{
#include <stdio.h>

int valid = 1;
int parens = 0;
int braces = 0;
int semicolons = 0;
int for_keyword = 0;
%}

%%

"for"    { for_keyword = 1; }
"("      { parens++; }
")"      { if (semicolons != 2) valid = 0; parens--; }
"{"      { braces++; }
"}"      { braces--; }
";"      { semicolons++; }

[a-zA-Z_][a-zA-Z0-9_]*  { /* Ignore identifiers */ }
[0-9]+                  { /* Ignore numbers */ }
[ \t\n]+                { /* Ignore whitespace */ }

.       { /* Ignore other characters */ }

%%

int main() {
    yylex();
    if (valid && for_keyword == 1 && parens == 0 && braces == 0 && semicolons == 2) {
        printf("Input parsed successfully.\n");
    } else {
        printf("Input failed to parse.\n");
    }
    return 0;
}

int yywrap() {
    return 1;
}
