public with sharing class peterCompi {
 
    virtual class Token implements IEval {
        string what;
        public Token() {}
        public Token(String what) {
            this.what = what;
        }

        public virtual Integer eval() {
            system.assert(false, 'impplement eval!');
            return null;
        }
    }

    public class NumberToken extends Token implements IEval {
        public NumberToken(String what) {
            super(what);
        }

        public override Integer eval() {
            return Integer.valueOf(this.what);
        }
    }

    public class OperatorToken extends Token {
        public OperatorToken(String what) {
            super(what);
        }

        public Integer run(Integer left, Integer right) {
            if (this.what == '+') {
                return left + right;
            }
            if (this.what == '-') {
                return left - right;
            }
            if (this.what == '*') {
                return left * right;
            }
            if (this.what == '/') {
                return left / right;
            }
            system.assert(false, 'what is this operator?: ' + this.what);
            return null;
        }

        public Integer getLevel() {
            if (this.what == '*' || this.what == '/') return 0;
            return 1;
        }
    }

    public class ParanthesisToken extends Token {
        public ParanthesisToken(String what) {
            super(what);
        }
    }

    static String[] numberCharlist = '0123456789'.split('');
    static String[] separatorCharList = ' '.split('');
    
    static String[] operatorCharList = '+-*/'.split('');
    static String[] paranthesisCharList = '()'.split('');



    public static Token[] tokenize(String inp) {
        inp = inp + ' ';
        
        Token[] tokenList = new Token[]{};
        
        String[] collector = new String[]{};
        String what;
        for (String s : inp.split('')) {
            if (operatorCharList.contains(s)) {
                what = 'op';
            }
            if (paranthesisCharList.contains(s)) {
                what = 'par';
            }
            if (numberCharlist.contains(s)) {
                what = 'num';
            }
            if (separatorCharList.contains(s)) {
                what = 'sep';
            }

            if ((what == 'sep' || what == 'op' || what == 'par')
                && !collector.isEmpty()
            ) {
                tokenList.add(new NumberToken(String.join(collector, '')));
                collector = new String[]{};
            }


            if (what == 'op') {
                tokenList.add(new OperatorToken(s));
                continue;
            }

            if (what == 'par') {
                tokenList.add(new ParanthesisToken(s));
                continue;
            }

            if (what == 'num') {
                collector.add(s);
            }
        }

        return tokenList;
    }

    public interface IEval {
        Integer eval();
    }

    public class Expression implements IEval {
        public IEval leftArg;
        public OperatorToken operator;
        public IEval rightArg;

        public Integer eval() {
            return this.operator.run(leftArg.eval(), rightArg.eval());
        }

    }


    public static Expression buildTree(IEval[] tokenList) {

        IEval[] tl = new List<IEval>(tokenList);

        // move 0 level operators to expressions
        Integer i = 1;
        while (i < tl.size()) {
            if (tl[i] instanceOf OperatorToken
                && ((OperatorToken) tl[i]).getLevel() == 0) {
                    Expression e = new Expression();
                    e.leftArg = tl[i-1];
                    e.operator = (OperatorToken) tl[i];
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
            e.operator = (OperatorToken) tl[1];
            e.rightArg = tl[2];
            tl.remove(0);
            tl.remove(0);
            tl[0] = e;
        }
        return (Expression) tl[0];
    }

}