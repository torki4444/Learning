/**
 * Created by CIVCIZ on 08-May-17.
 */
@IsTest

public with sharing class AccountProcessorTest {
/*
    @IsTest
    private static void testAccountFieldUpdate() {
        List<Account> accounts = [SELECT Id FROM Account];
        List<Id> accountIds = new List<Id> ();
        for (Account acc : accounts){
            accountIds.add(acc.Id);
        }
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
// runs callout and check results


//System.assertEquals(1, logs.size());
//System.assertEquals('success', logs[0].msg__c);


    }

*/



    public static testmethod void TestAccountProcessorTest() {
        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;

        Contact cont = New Contact();
        cont.FirstName ='Bob';
        cont.LastName ='Masters';
        cont.AccountId = a.Id;
        Insert cont;

        List<Id> listAccId = new List<ID>();
        listAccId.add(a.id);

    Test.startTest();
    AccountProcessor.countContacts(listAccId);
    Test.stopTest();

    Account ACC = [select Number_of_Contacts__c from Account where id = :a.id LIMIT 1];
    System.assertEquals ( Integer.valueOf(ACC.Number_of_Contacts__c) ,1);
}


}