public with sharing class Tokenizer {
    static String[] numberCharlist = '0123456789'.split('');
    static String[] variableCharList = 'ABCDEFG'.split('');
    // static String[] separatorCharList = ' '.split('');
    
    static String[] operatorCharList = '+-*/'.split('');
    static String[] paranthesisCharList = '()'.split('');


    public String rawCode;
    Integer pos = 0;
    Token.AbstractToken[] tokenList = new Token.AbstractToken[]{};

    public Tokenizer(String rawCode) {
        this.rawCode = rawCode;
    }
    
    private String getChar() {
        return this.rawCode.subString(this.pos, this.pos+1);
    }

    private String nextChar() {
        if (this.pos + 1 < rawCode.length()) {
            return this.rawCode.subString(this.pos+1, this.pos+2);
        } else return null;
    }

    private void step() {
        this.pos++;
    }

    private Boolean askOperator() {
        if (operatorCharList.contains(this.getChar())) {
            tokenList.add(new Token.OperatorToken(this.getChar()));
            this.step();
            return true;
        }
        return false;
    }

    private Boolean askParanthesis() {
        if (paranthesisCharList.contains(this.getChar())) {
            tokenList.add(new Token.OperatorToken(this.getChar()));
            this.step();
            return true;
        }
        return false;
    }

    private Boolean askNumber() {
        if (numberCharlist.contains(this.getChar())) {
            String myNumber = this.getChar();
            
            while(numberCharlist.contains(this.nextChar())) {
                this.step();
                myNumber = myNumber + this.getChar();
            }
            tokenList.add(new Token.NumberToken(myNumber));
            this.step();
            return true;
        }
        return false;
    }

    private Boolean askVariableName() {
        if (variableCharList.contains(this.getChar())) {
            String myNumber = this.getChar();
            
            while(variableCharList.contains(this.nextChar())) {
                this.step();
                myNumber = myNumber + this.getChar();
            }
            tokenList.add(new Token.VariableNameToken(myNumber));
            this.step();
            return true;
        }
        return false;
    }



    public Token.AbstractToken[] tokenize() {

        while(this.pos < this.rawCode.length()) {
            if (this.askOperator()) {} 
            if (this.askParanthesis()) {} 
            if (this.askVariableName()) {} 
            else if (this.askNumber()) {}
            else {
                step();
            }
        }
        system.assert(false, 'xxxx' + this.tokenList);

        return this.tokenList;
    
    }
}