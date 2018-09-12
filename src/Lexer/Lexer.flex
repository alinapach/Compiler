package Lexer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import Utilities.Token;

%%
%public
%class Lexer
%type Token
%unicode
%{
    private ArrayList<Token> tokens;
%}

%init{
    tokens = new ArrayList<Token>();
%init}

%line
%column

Comments =  {LineComment}|{BlockComment}
LineComment = \#[^\n\r]*
BlockComment = \"\"\"([^\"])* ~ \"\"\"

Space = " "
EndOfLine = \n|\r|\r\n
WhiteSpace = {Space}|{EndOfLine}| [ \t\n]

Alphabet = [a-zA-Z]
InvalidCharacter = "&"|"$"|"@"|"á"|"é"|"í"|"ó"|"ú"|"Á"|"É"|"Í"|"Ó"|"Ú"|"ñ"|"Ñ"|"¿"|"ä"|"ë"|"ï"|"ö"|"ü"|"à"|"è"|"ì"|"ò"|"ù"|\\
Identifier = ({Alphabet})({Alphabet}|{Integers}|"_")*
InvalidIdentifier = "_"{Identifier}*{InvalidCharacter}*({Identifier}|{InvalidCharacter})*

Operator = "+"|"-"|"*"|"/"|"%"|":="|"<"|"<="|">"|">="|"="|"<>"
Separator = "."|","|";"|"("|")"|"["|"]"

ReservedWord = "const"|"var"|"begin"|"end"|"if"|"then"|"else"|"while"|"do"|"for"|"to"|"and"|"or"|"not"|"read"|"write"|
                "readchar"|"writechar"|"EOF"

DataType  = "int"|"float"|"chr"|"str"

Integers = {NumDecimal}|{NumHex}
NumDecimal = [1-9][0-9]*|"0"
NumHex = 0[xX]([0-9]|[a-fA-F])+

Numbers = {Integers}

LiteralStr = \"[^\n\r\"]*\"
LitetralStrInvalida = \"+{LiteralStr} | {LiteralStr}\"+
LiteralChr = \'[^\']\'
LiteralChrInvalido = \'[^\']+\' | \'+\'[^\']+\' | \'[^\']+\'\'+

Literal  = ({LiteralStr}|{LiteralChr})
LiteralInvlaido = {LitetralStrInvalida} | {LiteralChrInvalido}|
                    {Integers}({Alphabet} | {InvalidCharacter} | "_"| (({Alphabet}|{InvalidCharacter}|"_"){Integers}))+
%%

<YYINITIAL> {
    {Comments}          {/*Ignore*/}
    {WhiteSpace}        {/*Ignore*/}

    {Literal}           {Token t = new Token(yytext(),"String",yyline,yycolumn);tokens.add(t);return t;}
    {Numbers}           {Token t = new Token(yytext(),"Number",yyline,yycolumn);tokens.add(t);return t;}

    {LiteralInvlaido}   {Token t = new Token(yytext(),"ERROR, invalid literal",yyline,yycolumn);tokens.add(t);return t;}

    {ReservedWord}      {Token t = new Token(yytext(),"Reserved Word",yyline,yycolumn);tokens.add(t);return t;}

    {Operator}          {Token t = new Token(yytext(),"Operator",yyline,yycolumn);tokens.add(t);return t;}

    {Separator}         {Token t = new Token(yytext(),"Separator",yyline,yycolumn);tokens.add(t);return t;}

    {Identifier}        {Token t = new Token(yytext(),"Identifier",yyline,yycolumn);tokens.add(t);return t;}

    {InvalidIdentifier} {Token t = new Token(yytext(),"ERROR, invalid identifier",yyline,yycolumn);tokens.add(t);return t;}
}
[^] {Token t = new Token(yytext(),"ERROR, unrecognized token",yyline,yycolumn);tokens.add(t);return t;}
