%option noyywrap
%option yylineno
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* Ks[] = {
  "CONST", "VAR", "PROCEDURE", "IF", "THEN", "BEGIN", "END", "WHILE", "DO", "CALL", "ODD", "RAED", "WRITE", NULL
};

int isK(char* str) {
  for (int i = 0; Ks[i] != NULL; i++) {
    if (strcmp(Ks[i], str) == 0) {
      return 1;
    }
  }
  return 0;
}

%}

digit [0-9]
letter [a-zA-Z]
token {letter}({digit}|{letter})*
delimiter [;,.()]
operator [+*/=<>-]


%%

[ \t\n]   ; 

{token} {
  if (isK(yytext)) {
    printf("%s: K\n", yytext);
  } else {
    printf("%s: I\n", yytext);
  }
}

{digit}+ {
  printf("%s: C\n", yytext);
}

":="|{delimiter} {
  printf("%s: D\n", yytext);
}

"<>"|"<="|">="|{operator} {
  printf("%s: O\n", yytext);
}

{digit}+{token} {
  printf("%s: T\n", yytext);
}

. {
  printf("%s: T\n", yytext);
}

%%

int main(int argc, char *argv[]) {
    yyin = stdin;
    yylex();
    return 0;
}