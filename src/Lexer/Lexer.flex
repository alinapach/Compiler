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



Const = "const"
Var = "var"
Begin = "begin"
End = "End"
If = "if"
Then = "then"
Else = "else"
While = "while"
Do = "do"
For = "for"
To= "to"
And = "and"
Or = "or"
Not = "not"
Read = "read"
Write = "write"
Readchar = "readchar"
Writechar = "writechar"
Eof = "EOF"

Integers = {NumDecimal}|{NumHex}
NumDecimal = [1-9][0-9]*|"0"
NumHex = 0[xX]([0-9]|[a-fA-F])+

Numbers = {Integers}|"-"{Integers}

LiteralStr = \"[^\n\r\"]*\"
LiteralStrInvalid = \"+{LiteralStr} | {LiteralStr}\"+
LiteralChr = \'[^\']\'

Literal  = ({LiteralStr}|{LiteralChr})
LiteralInvalid = {LiteralStrInvalid} |
                    {Integers}({Alphabet} | {InvalidCharacter} | "_"| (({Alphabet}|{InvalidCharacter}|"_"){Integers}))+
%%

<YYINITIAL> {
    {Comments}          {/*Ignore*/}
    {WhiteSpace}        {/*Ignore*/}

    {Literal}           {Token t = new Token(yytext(),"String",yyline,yycolumn);tokens.add(t);return t;}
    {Numbers}           {Token t = new Token(yytext(),"Number",yyline,yycolumn);tokens.add(t);return t;}

    {LiteralInvalid}    {Token t = new Token(yytext(),"ERROR, invalid literal",yyline,yycolumn);tokens.add(t);return t;}
    {Const}             {Token t = new Token(yytext(),"Const: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Var}               {Token t = new Token(yytext(),"Var: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Begin}                  {Token t = new Token(yytext(),"Begin: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {End}                  {Token t = new Token(yytext(),"End: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {If}                  {Token t = new Token(yytext(),"If: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Then}                  {Token t = new Token(yytext(),"Then: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Else}                  {Token t = new Token(yytext(),"Else: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {While}                  {Token t = new Token(yytext(),"While: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Do}                  {Token t = new Token(yytext(),"Do: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {For}                  {Token t = new Token(yytext(),"For: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {To}                  {Token t = new Token(yytext(),"To: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {And}                  {Token t = new Token(yytext(),"And: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Or}                  {Token t = new Token(yytext(),"Or: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Not}                  {Token t = new Token(yytext(),"Not: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Read}                  {Token t = new Token(yytext(),"Read: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Write}                  {Token t = new Token(yytext(),"Write: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Readchar}                  {Token t = new Token(yytext(),"Readchar: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Writechar}                  {Token t = new Token(yytext(),"Writechar: Reserved word",yyline,yycolumn);tokens.add(t);return t;}
    {Eof}                  {Token t = new Token(yytext(),"EOF",yyline,yycolumn);tokens.add(t);return t;}

    {Operator}          {Token t = new Token(yytext(),"Operator",yyline,yycolumn);tokens.add(t);return t;}

    {Separator}         {Token t = new Token(yytext(),"Separator",yyline,yycolumn);tokens.add(t);return t;}

    {Identifier}        {Token t = new Token(yytext(),"Identifier",yyline,yycolumn);tokens.add(t);return t;}

    {InvalidIdentifier} {Token t = new Token(yytext(),"ERROR, invalid identifier",yyline,yycolumn);tokens.add(t);return t;}
}
[^] {Token t = new Token(yytext(),"ERROR, unrecognized token",yyline,yycolumn);tokens.add(t);return t;}
