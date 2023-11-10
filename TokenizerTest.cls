@isTest
public with sharing class TokenizerTest {

    @isTest
    public static void test1() {
        Token.AbstractToken[] tokens = new Tokenizer('3+5').tokenize();
        system.assertEquals(3, tokens.size());
        system.assert(tokens[0] instanceOf Token.NumberToken);
        system.assert(tokens[1] instanceOf Token.OperatorToken);
        system.assert(tokens[2] instanceOf Token.NumberToken);
    
        tokens = new Tokenizer(' 3  +   5  ').tokenize();
        system.assertEquals(3, tokens.size());
        system.assert(tokens[0] instanceOf Token.NumberToken);
        system.assert(tokens[1] instanceOf Token.OperatorToken);
        system.assert(tokens[2] instanceOf Token.NumberToken);

 
        tokens = new Tokenizer('38+5').tokenize();
        system.assertEquals(3, tokens.size());
        system.assert(tokens[0] instanceOf Token.NumberToken);
        system.assert(tokens[1] instanceOf Token.OperatorToken);
        system.assert(tokens[2] instanceOf Token.NumberToken);
        system.assertEquals('38', tokens[0].what);
        system.assertEquals('+', tokens[1].what);
        system.assertEquals('5', tokens[2].what);

        tokens = new Tokenizer('3899*125').tokenize();
        system.assertEquals(3, tokens.size());
        system.assert(tokens[0] instanceOf Token.NumberToken);
        system.assert(tokens[1] instanceOf Token.OperatorToken);
        system.assert(tokens[2] instanceOf Token.NumberToken);
        system.assertEquals('3899', tokens[0].what);
        system.assertEquals('*', tokens[1].what);
        system.assertEquals('125', tokens[2].what);   
    }

    @isTest
    public static void test_invalid() {

        Boolean catched = false;
        try {
            Token.AbstractToken[] tokens = new Tokenizer('|').tokenize();
        } catch(Tokenizer.TokenizerException e) {
            catched = true;
        }

        catched = false;
        try {
            Token.AbstractToken[] tokens = new Tokenizer('1 + 2$').tokenize();
        } catch(Tokenizer.TokenizerException e) {
            catched = true;
        }

        catched = false;
        try {
            Token.AbstractToken[] tokens = new Tokenizer('    1  #2').tokenize();
        } catch(Tokenizer.TokenizerException e) {
            catched = true;
        }

        system.assert(catched);
    }

}