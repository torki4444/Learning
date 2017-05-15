/**
 * Created by CIVCIZ on 08-May-17.
 */

public with sharing class AccountProcessor {

    @future
    public static void countContacts (List<id> accountIds){

        List<Account> accountsToUpdate = new List<Account> ();

        for (ID accID : accountIds){
            List<Contact> accountContacts = [SELECT Id FROM Contact WHERE Account.Id =: accID];
            Account acc = new Account (Id = accId);
            acc.Number_of_Contacts__c = accountContacts.size();
            Account accToAdd = new Account (Id = accID);
            accountsToUpdate.add(accToAdd);
        }

        update accountsToUpdate;

    }
}