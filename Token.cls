public with sharing class Token {

    public interface IEval {
        Integer eval();
    }

 
    public virtual class AbstractToken implements IEval {
        public string what;
        public AbstractToken() {}
        public AbstractToken(String what) {
            this.what = what;
        }

        public virtual Integer eval() {
            system.assert(false, 'impplement eval!');
            return null;
        }
    }

    public class NumberToken extends AbstractToken implements IEval {
        public NumberToken(String what) {
            super(what);
        }

        public override Integer eval() {
            return Integer.valueOf(this.what);
        }
    }

    public class VariableNameToken extends AbstractToken {
        public VariableNameToken(String what) {
            super(what);
        }
    }

    public class OperatorToken extends AbstractToken {
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

    public class ParanthesisToken extends AbstractToken {
        public ParanthesisToken(String what) {
            super(what);
        }

        public Boolean isOpen() {
            return this.what == '(' ? true : false;
        }
    }

}