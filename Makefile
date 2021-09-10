#This Makefile will work for a lot of different yacc projects
# Note the -i option on flex, which makes the program 
# case-insensitive
# Will Briggs
# Spring 2020

a.out: 		lex.yy.c y.tab.c
		gcc -g lex.yy.c y.tab.c

y.tab.c: 	yacc.y
		bison -d yacc.y -o y.tab.c

y.tab.h: 	yacc.y
		bison -d yacc.y -o y.tab.c

lex.yy.c: 	lex.l
		flex -i lex.l #the -i makes it case-insensitive

clean:
		rm -f *~ *.o lex.yy.c y.tab.c y.tab.h
