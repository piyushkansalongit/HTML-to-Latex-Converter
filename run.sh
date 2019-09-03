bison -d parser.y
lex lexer.l
gcc -o out parser.tab.c lex.yy.c
./out