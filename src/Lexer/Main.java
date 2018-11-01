package Lexer;

import Utilities.Token;
import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
import Parser.Parser;




public class Main {

    public static void main(String[] args) throws IOException {
        ArrayList<Token> tokens = new ArrayList<>();
        ArrayList<Token> errorTokens = new ArrayList<>();

        //String path = "src/Lexer/Lexer.flex";
        //File file = new File(path);
        //jflex.Main.generate(file);

        System.out.println("File path: ");
        Scanner scanner = new Scanner(System.in);
        //String filePath = scanner.nextLine();
        String filePath = "/Users/alina/test.txt";



        try {
            Reader reader = new BufferedReader(new FileReader(filePath));
            Lexer lexer = new Lexer(reader);

            while (true) {
                Token token = lexer.yylex();
                if (token == null) {
                    break;
                }
                else{
                    tokens.add(token);
                }
            }

            Parser parser = new Parser(tokens);
            parser.run();


        } catch (FileNotFoundException ex) {
            System.out.println("Error");
        }
    }
}


/*

try {
            Parser asin = new Parser(
                    new Lexer( new FileReader(args[0])));
            Object result = asin.parse().value;
            System.out.println("\n*** Final finales ***");
        } catch (Exception ex) {
            ex.printStackTrace();
        }



        String[] Parser_args = {"-parser", "Parser", "-destdir", "/Users/alina/IdeaProjects/Lexical_Analyzer/src/Lexer" ,"/Users/alina/IdeaProjects/Lexical_Analyzer/src/Lexer/Parser.cup"};
        try {
            java_cup.Main.main(Parser_args);
        } catch (Exception ex) {
            System.out.println("Parser error");
        }
/*

        Parser asin = new Parser(new Lexer(new FileReader(filePath)));
        try {
            Object result = asin.parse().value;
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
        }
        System.out.println("\n*** Resultados finales ***");

 */
