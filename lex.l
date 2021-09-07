/*
Lex part of Program 1
Justin Kachornvanich
CS 322
Fall 2021
*/

%{
#include "y.tab.h"
%}

integer [0-9]
decimal [=]
binary [bB]
hex [xX]
octal [oO]
binaryNumbers [01]
hexNumbers [0-9A-Fa-f]
octalNumbers [0-7]

%%
{decimal}                   { yylval = atoi(yytext); return DECIMAL; }
{binary}                    { yylval = atoi(yytext); return BINARY; }
{hex}                       { yylval = atoi(yytext); return HEX; }
{octal}                     { yylval = atoi(yytext); return OCTAL; }
{integer}+                  { yylval = atoi(yytext); return INTEGER; }
0{binary}{binaryNumbers}+   { yylval = strtol(yytext + 2, NULL, 2); return INTEGER; } 
0{hex}{hexNumbers}+         { yylval = strtol(yytext + 2, NULL, 16); return INTEGER; } 
0{octal}{octalNumbers}+     { yylval = strtol(yytext + 1, NULL, 8); return INTEGER; }
\+          return (ADD);
\-          return (SUBTRACT);
\*          return (MULTIPLY);
\/          return (DIVIDE);
\%          return (MODULO);
\(          return (LPAREN);
\)          return (RPAREN);


%%
