package Parser;

import Utilities.Token;

import java.util.ArrayList;

public class Parser {

    private ArrayList<Token> tokens;
    private int token_number;
    private Token token;

    public Parser(ArrayList<Token> p_tokens) {
        tokens = p_tokens;
        token_number = 0;
    }

    public void run() {
        nextToken();
        int i = 0;
        for (Token token : tokens){
            System.out.println(Integer.toString(i) + token.toString());
            i++;
        }
        Program();
    }

    private void nextToken(){
        token = tokens.get(token_number);
        token_number++;
    }

    private void Program() {
        if (token.match("const")) {
            P1();
            nextToken();
        }
        if (token.match("var")) {
            P2();
            nextToken();
        }
        if (token.match("begin")) {
            CompoundStatement();
            if (!token.match(".")) token.error("Expected . at the end of the file");
        }
    }

    private void P1(){
        nextToken(); // we already matched the const

        if (!token.match("Identifier")) token.error();
        nextToken();
        if (!token.match("=")) token.error();
        nextToken();
        if (!token.match("Number")) token.error();
        nextToken();
        if (token.match(",")) {
            P1();
        }
        else if (!token.match(";")) token.error();

    }

    private void P2(){
        nextToken(); // we already matched var
        if (!token.match("Identifier")) token.error();
        nextToken();
        if (token.match("[")){
            nextToken();
            if (token.match("Literal") || token.match("Number")){
                nextToken();
                if (!token.match("]")) {
                    token.error();

                } else nextToken();

            }
        } if (token.match(",")){
            P2();
        } else if (!token.match(";")) token.error("Error expected ;");
    }

    private void CompoundStatement() {

        Statement();

        if (token.match("End")){
            nextToken();
        } else if (token.match(";")){
            CompoundStatement();
        }
    }

    private void Statement() {
        nextToken();
        if (token.match("Identifier")) {
            Lvalue();
            if (!token.match(":=")) token.error(":=");
            else Expression();
        }
        if (token.match("begin")) {
            CompoundStatement();
        }
        if (token.match("if")){
            IfStatement();
        }
        if (token.match("while")){
            WhileStatement();
        }
        if (token.match("for")){
            ForStatement();
        }
        if (token.match("readchar") || token.match("writechar")
            || token.match("read") || token.match("write")){
            IOStatement();
        }
    }

    private void ForStatement() {
        if (token.match("for")){
            nextToken();
            if (token.match("Identifier")){
                nextToken();
                if (token.match(":=")){
                    Expression();
                    nextToken();
                    if (token.match("to")){
                        Expression();
                        nextToken();
                        if (token.match("do")){
                            Statement();
                        }
                    }
                }
            }
        }
    }

    private void WhileStatement() {
        if (token.match("while")){
            nextToken();
            BooleanExpression();
            nextToken();
            if (token.match("do")){
                Statement();
            } else token.error("Expected do");
        }
    }

    private void IfStatement(){
        if (token.match("if")){
            nextToken();
            BooleanExpression();
            nextToken();
            if (token.match("then")){
                Statement();
                nextToken();
                if (token.match("else")) {
                    Statement();
                }
            } else token.error("expected then");
        }
    }

    private void IOStatement() {
        if (token.match("readchar") || token.match("writechar")) {
            nextToken();
            Lvalue();
        }
        if (token.match("read")){
            nextToken();
            Lvalue();
            nextToken();
            if (token.match(",")) {
                nextToken();
                Lvalue();
            } else token.error();
        }
        if (token.match("write")){
            Value();
        }
    }

    private void Lvalue() {

        if (!token.match("Identifier")){
            token.error();
        } else {
            nextToken();
            if (token.match("[")) {
                Expression();
                nextToken();
                if (!token.match("]"))
                    token.error();
            }
        }
    }

    private void Value() {
        //nextToken();
        if (token.match("Identifier")) {
           nextToken();
           if (token.match("[")){
               Expression();
               nextToken();
               if (!token.match("]")) token.error("Value expected ]");
           }
        } else if (!token.match("Number")) {
            token.error("Expected Identif or Number");
        }
    }

    private void BooleanExpression() {
        BoolTerm();
        nextToken();

        if (token.match("or")){
            nextToken();
            BoolTerm();
        } else token_number--;
    }

    private void BoolTerm() {
        BoolFactor();
        nextToken();

        if (token.match("and")){
            nextToken();
            BoolFactor();
        } else token_number--;
    }

    private void BoolFactor() {

        if (token.match("Identifier") || token.match("Number")){
            Condition();
        }
        if (token.match("(")){
            BooleanExpression();
            nextToken();
            if (!token.match(")")){
                token.error("Expected )");
            }
        }
        if (token.match("not")){
            nextToken();
            BoolFactor();
        }
    }

    private void Condition() {
        Value();
        nextToken();
        if (token.match("=") || token.match("<>") || token.match("<=")
                || token.match("<") || token.match(">") || token.match(">=")){
            Value();
        } // or ODD???
    }

    private void Expression() {
        nextToken();
        Term();
        nextToken();
        if (token.match("+") || token.match("-")){

            Expression();
        } else token_number--;
    }

    private void Term() {
        Factor();
        nextToken();
        if (token.match("*") || token.match("/") || token.match("%")){
            nextToken();
            Term();
        } else token_number--;
    }

    private void Factor() {
        if (token.match("Number")){
            return;
        } else if (token.match("-")){
            nextToken();
            Factor();
        } else if (token.match("(")) {
            Expression();
            nextToken();
            if (!token.match(")")) token.error();
        } else if (token.match("Identifier")) {
            nextToken();
            if (token.match("[")){
                Expression();
                nextToken();
                if (!token.match("]")) token.error("Factor expected ]");
            } else token_number--;
        }



    }
}
