/*
Yacc part of hw2
Justin Kachornvanich
CS 322
Fall 2021
*/

%{
  #include <stdio.h>
  void yyerror (char *str);
  int yywrap ();
  int yylex();
  int yyparse();
  void printBinary (int integer);
%}

%token INTEGER DECIMAL BINARY HEX OCTAL ADD SUBTRACT MULTIPLY DIVIDE MODULO LPAREN RPAREN

%%
expressions : expression | expression expressions; //Accepts one expresssion or one or more expressions

expression : E DECIMAL { printf("Result in decimal = %d", $1); } //Prints in decimal
	   | E BINARY { printf("Result in binary = "); printBinary($1); } //Prints in binary
   	   | E HEX { printf("Result in hex = %x", $1); } //Prints in hex
	   | E OCTAL { printf("Result in octal = %o", $1); }; //Prints in octal
/*
Done:
prints decimal 
prints octal 
prints hex
accepts decimal
accepts binary
accepts hex
accepts octal
accepts multiple parenthesis for each operator 
prints binary
 */

//Performs operations on the input 
E : INTEGER { $$ = $1; }
   | E ADD INTEGER { $$ = $1 + $3; } //Add
   | E ADD LPAREN E RPAREN { $$ = $1 + $4; } //Add expression with second expression with parenthesis 
   | E SUBTRACT INTEGER { $$ = $1 - $3; } //Subtract
   | E SUBTRACT LPAREN E RPAREN { $$ = $1 - $4; } //Subtract expression with sescond expression with parenthesis
   | E MULTIPLY INTEGER { $$ = $1 * $3; } //Multiply
   | E MULTIPLY LPAREN E RPAREN { $$ = $1 * $4; } //Multiply expression with second expression with parenthesis
   | E DIVIDE INTEGER { $$ = $1 / $3; } //Divide
   | E DIVIDE LPAREN E RPAREN { $$ = $1 / $4; } //Divide expression with second expression with parenthesis
   | E MODULO INTEGER {$$ = $1 % $3; } //Modulo
   | E MODULO LPAREN E RPAREN {$$ = $1 % $4; } //Modulo expression with second expression with parenthesis
   | LPAREN E RPAREN {$$ = $2; } //Single expression in parenthesis
%%

//Function to convert input to binary with bit shifting
void printBinary (int integer)
{
        unsigned int mask = 1 << 31; //Bit shift 1 to the end of the line 
	const int BITS = 32;

	for (int i = 0; i < BITS; i++) //For 32 bits
	{
	  	if((mask & integer) == 0) //If the unsigned bit and the bit in the integer are both 0 then print 0 
	    	{
		  	printf("0");
	    	}
	  	else //If the unsigned bit and the bit in the integer are both 1 then print 1
	    	{
		  	printf("1");
	    	}
	  mask >>= 1; //Bit shift to the right
        }
	printf("\n");
}

/* How yacc will print errors, if need be. Just leave this one as is. */

void yyerror(char *str){ fprintf(stderr,"error: %s\n",str); }

/* Needed by yacc; just leave this one */

int yywrap() { return 1; } 

/* Needed by yacc; just leave this one */

int main() { yyparse(); } 
