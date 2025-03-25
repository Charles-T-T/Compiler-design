flex example.l
gcc lex.yy.c -o a
./a < test.sy

rm a lex.yy.c