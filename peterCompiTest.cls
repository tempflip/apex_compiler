@isTest
public with sharing class peterCompiTest {
    @isTest
    public static void run() {

        system.assertEquals(8,
            peterCompi.buildTree(peterCompi.tokenize('3+5')).eval());

        system.assertEquals(15,
            peterCompi.buildTree(peterCompi.tokenize('3*5')).eval());

        system.assertEquals(1111,
            peterCompi.buildTree(peterCompi.tokenize(' 1 + 10 + 100 + 1000')).eval());

        system.assertEquals(110,
            peterCompi.buildTree(peterCompi.tokenize(' 100 + 5 * 2')).eval(), 0);

        system.assertEquals(502,
            peterCompi.buildTree(peterCompi.tokenize(' 100 * 5 + 2')).eval());

            
        system.assertEquals(46,
            peterCompi.buildTree(peterCompi.tokenize('2*3 + 20*2')).eval());


        system.assertEquals(64,
            peterCompi.buildTree(peterCompi.tokenize('2+3 * 20+2')).eval());


        system.assertEquals(64,
            peterCompi.buildTree(peterCompi.tokenize('8 * 8')).eval());

        system.assertEquals(512,
            peterCompi.buildTree(peterCompi.tokenize('8 * 8 * 8')).eval());

        system.assertEquals(4096,
            peterCompi.buildTree(peterCompi.tokenize('8 * 8 * 8 * 8')).eval());

            system.assertEquals(80,
            peterCompi.buildTree(peterCompi.tokenize('8 + 8 + 8 * 8')).eval());

        }

}