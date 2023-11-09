@isTest
public with sharing class peterCompiTest {
    @isTest
    public static void run() {

        system.assertEquals(8,
            peterCompi.buildTree(new Tokenizer('3+5').tokenize()).eval());

        system.assertEquals(15,
            peterCompi.buildTree(new Tokenizer('3*5').tokenize()).eval());

        system.assertEquals(1111,
            peterCompi.buildTree(new Tokenizer(' 1 + 10 + 100 + 1000').tokenize()).eval());

        system.assertEquals(110,
            peterCompi.buildTree(new Tokenizer(' 100 + 5 * 2').tokenize()).eval(), 0);

        system.assertEquals(502,
            peterCompi.buildTree(new Tokenizer(' 100 * 5 + 2').tokenize()).eval());
            
        system.assertEquals(46,
            peterCompi.buildTree(new Tokenizer('2*3 + 20*2').tokenize()).eval());

        system.assertEquals(64,
            peterCompi.buildTree(new Tokenizer('2+3 * 20+2').tokenize()).eval());

        system.assertEquals(64,
            peterCompi.buildTree(new Tokenizer('8 * 8').tokenize()).eval());

        system.assertEquals(512,
            peterCompi.buildTree(new Tokenizer('8 * 8 * 8').tokenize()).eval());

        system.assertEquals(4096,
            peterCompi.buildTree(new Tokenizer('8 * 8 * 8 * 8').tokenize()).eval());

        system.assertEquals(80,
            peterCompi.buildTree(new Tokenizer('8 + 8 + 8 * 8').tokenize()).eval());

        // paranthesis
        system.assertEquals(8,
            peterCompi.buildTree(new Tokenizer('(3+5)').tokenize()).eval());

        system.assertEquals(80,
            peterCompi.buildTree(new Tokenizer('(3+5)*10').tokenize()).eval());

        system.assertEquals(800,
            peterCompi.buildTree(new Tokenizer('10 * (3+5)*10').tokenize()).eval());

        system.assertEquals(36,
            peterCompi.buildTree(new Tokenizer('(2+4) * (3+3)').tokenize()).eval());

        system.assertEquals(50,
            peterCompi.buildTree(new Tokenizer('((2*2) + 1) + 10').tokenize()).eval());


    }

}