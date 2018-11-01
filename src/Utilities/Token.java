package Utilities;

public class Token {

    private String token;
    private String type;
    public int row;
    public int column;

    public Token(String token, String type, int row, int column){

        this.token = token;
        this.type = type;
        this.row = row + 1;
        this.column = column + 1;
    }

    @Override
    public String toString() {
        return " Token --> " + token + "\t\t" + type + " [Row: "+ row +" Column: " + column + "]";
    }


    public Boolean match(String token){ // if match go to the next one
        if (this.type.equals(token) || (this.token.equals(token))){
            return true;
        }
        return false;
    }

    public void error(){
        System.out.println("Error in line " + this.row + " column: " + this.column);
    }
    public void error(String info){
        System.out.println("Error in line " + this.row + " column: " + this.column + " - " + info);
    }
}