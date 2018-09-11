package Lexer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

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
InvalidCharacter = "%"|"&"|"$"|"@"|"á"|"é"|"í"|"ó"|"ú"|"Á"|"É"|"Í"|"Ó"|"Ú"|"ñ"|"Ñ"|"¿"|"ä"|"ë"|"ï"|"ö"|"ü"|"à"|"è"|"ì"|"ò"|"ù"|\\
Identifier = ({Alphabet}|"_")({Alphabet}|{Integers}|"_")*
InvalidIdentifier = {Identifier}*{InvalidCharacter}+({Identifier}|{InvalidCharacter})*

Operator = "+"|"-"|"*"|"/"|"//"|"%"|"**"|"="|
            "=="|"!="|"<>"|">"|"<"|">="|"<="|
            "+="|"-="|"*="|"/="|"**="|"//="|
            ">>"|"<<"|"|"|"^"|"~"|"!"

Separator = "("|")"|","|":"|"["|"]"

ReservedWord = "and"|"del"|"from"|"not"|"while"|"as"|"elif"|"global"|"or"|"with"|"assert"|"else"|
            "if"|"pass"|"yield"|"break"|"except"|"import"|"print"|"class"|"exec"|"in"|"raise"|
            "continue"|"finally"|"is"|"return"|"def"|"for"|"lambda"|"try"

DataType  = "int"|"float"|"chr"|"str"

Integers = {NumDecimal}|{NumOctal}|{NumHex}|{NumBin}
NumDecimal = [1-9][0-9]*|"0"
NumOctal = 0 [oO][0-7]+
NumHex = 0[xX]([0-9]|[a-fA-F])+
NumBin = 0 [bB][01]+

PtoFlotante = {Flotante}|{Exponente}
Flotante = [0-9]+?("."[0-9]+)|([0-9]+)"."
Exponente  = ([0-9]+|{Flotante})([eE][+-][0-9]+)

Numbers = {Integers}|{PtoFlotante}

LiteralStr = \"[^\n\r\"]*\"
LitetralStrInvalida = \"+{LiteralStr} | {LiteralStr}\"+
LiteralChr = \'[^\']\'
LiteralChrInvalido = \'[^\']+\' | \'+\'[^\']+\' | \'[^\']+\'\'+
Null = "None"
Booleano = "True"|"False"
Literal  = ({LiteralStr}|{LiteralChr})
LiteralInvlaido = {LitetralStrInvalida} | {LiteralChrInvalido}|
                    {Integers}({Alphabet} | {InvalidCharacter} | "_"| (({Alphabet}|{InvalidCharacter}|"_"){Integers}))+
%%

<YYINITIAL> {
    {Comments}    {/*Ignorar*/}
    {WhiteSpace} {/*Ignorar*/}

    {Literal}       {Token t = new Token(yytext(),"Literal String",yyline,yycolumn);tokens.add(t);return t;}
    {Numbers}       {Token t = new Token(yytext(),"Literal Numerico",yyline,yycolumn);tokens.add(t);return t;}
    {Booleano}      {Token t = new Token(yytext(),"Literal Booleano",yyline,yycolumn);tokens.add(t);return t;}
    {Null}          {Token t = new Token(yytext(),"Nulo",yyline,yycolumn);tokens.add(t);return t;}

    {LiteralInvlaido} {Token t = new Token(yytext(),"ERROR, literal no válido",yyline,yycolumn);tokens.add(t);return t;}
    {DataType}    {Token t = new Token(yytext(),"Tipo de dato",yyline,yycolumn);tokens.add(t);return t;}
    {ReservedWord}     {Token t = new Token(yytext(),"Palabra reservada",yyline,yycolumn);tokens.add(t);return t;}

    {Operator}      {Token t = new Token(yytext(),"Operador",yyline,yycolumn);tokens.add(t);return t;}

    {Separator}     {Token t = new Token(yytext(),"Separador",yyline,yycolumn);tokens.add(t);return t;}

    {Identifier} {Token t = new Token(yytext(),"Identificador",yyline,yycolumn);tokens.add(t);return t;}
    {InvalidIdentifier} {Token t = new Token(yytext(),"ERROR, identificador no válido",yyline,yycolumn);tokens.add(t);return t;}
}
[^] {Token t = new Token(yytext(),"Error, token no reconocido",yyline,yycolumn);tokens.add(t);return t;}
