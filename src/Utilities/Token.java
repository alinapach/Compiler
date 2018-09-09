package Utilities;

public class Token {


    private String token;
    private String type;
    private int row;
    private int column;

    public Token(String token, String type, int row, int column){

        this.token = token;
        this.type = type;
        this.row = row + 1;
        this.column = column + 1;
    }

    @Override
    public String toString() {
        return "Token --> " + token + "\t Type: " + type + " [Row: "+ row +" Column: " + column + "]";
    }
}
