#!/bin/bash

DEFAULT_INPUT="test-cases-pl0/1.pl0"
INPUT_FILE="${1:-$DEFAULT_INPUT}"

flex lab1.l
gcc lex.yy.c -o lab1
./lab1 < "$INPUT_FILE"

rm lab1 lex.yy.c
