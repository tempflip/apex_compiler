@isTest
public with sharing class RunningContextTest {

    @isTest
    public static void RunningContextTest1() {
        RunningContext r = new RunningContext();
        r.setVarValue('ABC', 6);
        r.setVarValue('DD', 10);
        
        Integer xx = (Integer) r.evalExpression(
            peterCompi.buildTree(new Tokenizer('ABC + DD').tokenize())
        );

        system.assertEquals(16, xx);

        xx = (Integer) r.evalExpression(
            peterCompi.buildTree(new Tokenizer('ABC * ABC').tokenize())
        );

        system.assertEquals(36, xx);

        xx = (Integer) r.evalExpression(
            peterCompi.buildTree(new Tokenizer('ABC + ABC + ABC').tokenize())
        );

        system.assertEquals(18, xx);


        
    }

}