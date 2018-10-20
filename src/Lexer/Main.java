package Lexer;

import Utilities.Token;

import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws IOException {
        ArrayList<Token> tokens = new ArrayList<>();
        ArrayList<Token> errorTokens = new ArrayList<>();

        //String path = "src/Lexer/Lexer.flex";
        //File file = new File(path);
        //jflex.Main.generate(file);

        System.out.println("File path: ");
        Scanner scanner = new Scanner(System.in);
        String filePath = scanner.nextLine();

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

            System.out.println("\nTokens \n");
            for (Token token : tokens) {
                System.out.println(token.toString());
            }

        } catch (FileNotFoundException ex) {
            System.out.println("Error");
        } /**/
    }
}
