public with sharing class peterCompi {
 

    // static String[] numberCharlist = '0123456789'.split('');
    // static String[] separatorCharList = ' '.split('');
    
    // static String[] operatorCharList = '+-*/'.split('');
    // static String[] paranthesisCharList = '()'.split('');



    // public static Token[] tokenize(String inp) {
    //     inp = inp + ' ';
        
    //     Token[] tokenList = new Token[]{};
        
    //     String[] collector = new String[]{};
    //     String what;
    //     for (String s : inp.split('')) {
    //         if (operatorCharList.contains(s)) {
    //             what = 'op';
    //         }
    //         if (paranthesisCharList.contains(s)) {
    //             what = 'par';
    //         }
    //         if (numberCharlist.contains(s)) {
    //             what = 'num';
    //         }
    //         if (separatorCharList.contains(s)) {
    //             what = 'sep';
    //         }

    //         if ((what == 'sep' || what == 'op' || what == 'par')
    //             && !collector.isEmpty()
    //         ) {
    //             tokenList.add(new NumberToken(String.join(collector, '')));
    //             collector = new String[]{};
    //         }


    //         if (what == 'op') {
    //             tokenList.add(new Token.OperatorToken(s));
    //             continue;
    //         }

    //         if (what == 'par') {
    //             tokenList.add(new ParanthesisToken(s));
    //             continue;
    //         }

    //         if (what == 'num') {
    //             collector.add(s);
    //         }
    //     }

    //     return tokenList;
    // }


    public class Expression implements Token.IEval {
        public Token.IEval leftArg;
        public Token.OperatorToken operator;
        public Token.IEval rightArg;

        public Integer eval() {
            return this.operator.run(leftArg.eval(), rightArg.eval());
        }

    }


    public static Expression buildTree(Token.IEval[] tokenList) {

        Token.IEval[] tl = new List<Token.IEval>(tokenList);

        // move 0 level operators to expressions
        Integer i = 1;
        while (i < tl.size()) {
            if (tl[i] instanceOf Token.OperatorToken
                && ((Token.OperatorToken) tl[i]).getLevel() == 0) {
                    Expression e = new Expression();
                    e.leftArg = tl[i-1];
                    e.operator = (Token.OperatorToken) tl[i];
                    e.rightArg = tl[i+1];

                    tl[i-1] = e;
                    tl.remove(i);
                    tl.remove(i);
                }
            i++;
        }

        // wrap up
        while(tl.size() > 1) {
            Expression e = new Expression();
            e.leftArg = tl[0];
            e.operator = (Token.OperatorToken) tl[1];
            e.rightArg = tl[2];
            tl.remove(0);
            tl.remove(0);
            tl[0] = e;
        }
        return (Expression) tl[0];
    }

}