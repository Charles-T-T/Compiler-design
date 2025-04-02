%option noyywrap
%option yylineno
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;   
int yycolno = 1;

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

\n {
  yycolno = 1;
}

[ \t]+ {
  yycolno += yyleng;
}

{token} {
  if (isK(yytext)) {
    printf("%s: K, (%d, %d)\n", yytext, yylineno, yycolno);
  } else {
    printf("%s: I (%d, %d)\n", yytext, yylineno, yycolno);
  }
  yycolno += yyleng;
}

{digit}+ {
  printf("%s: C, (%d, %d)\n", yytext, yylineno, yycolno);
  yycolno += yyleng;
}

":="|{delimiter} {
  printf("%s: D, (%d, %d) \n", yytext, yylineno, yycolno);
  yycolno += yyleng;
}

"<>"|"<="|">="|{operator} {
  printf("%s: O, (%d, %d)\n", yytext, yylineno, yycolno);
  yycolno += yyleng;
}

{digit}+{token} {
  printf("%s: T, (%d, %d)\n", yytext, yylineno, yycolno);
  yycolno += yyleng;
}

. {
  printf("%s: T, (%d, %d)\n", yytext, yylineno, yycolno);
  yycolno += yyleng;
}

%%

int main(int argc, char *argv[]) {
  yylineno = 1;
  yycolno = 1;

  yyin = stdin;
  yylex();
  return 0;
}