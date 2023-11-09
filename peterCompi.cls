public with sharing class peterCompi {


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

        // move paranthesises to expressions
        Boolean paranthesisFound;
        do {
            paranthesisFound = false;

            Integer j = 0;
            Integer parStartInd;
            Integer parEndInd;
    
            for (j = 0; j < tl.size(); j++) {
                if (tl[j] instanceOf Token.ParanthesisToken) {
                    if (((Token.ParanthesisToken) tl[j]).isOpen()) {
                        parStartInd = j;
                    } else {
                        parEndInd = j;
                        break;
                    }
                }
            }

            if (parStartInd != null && parEndInd != null) {
                paranthesisFound = true;
                Token.IEval[] tokensInParans = new Token.IEval[]{};
                for (Integer i = parStartInd+1; i<parEndInd; i++) {
                    tokensInParans.add(tl[i]);
                }

                Expression expressionInParanthesis = buildTree(tokensInParans);
                
                // remove the paranthesis
                for (Integer k = parStartInd; k<parEndInd; k++) {
                    tl.remove(parStartInd);
                }
                //put the expr.
                tl[parStartInd] = expressionInParanthesis;
            }
        } while(paranthesisFound);

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