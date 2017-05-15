/**
 * Created by CIVCIZ on 02-May-17.
 */

public with sharing class SessionSpeakerSelector {

    public static List<Session_Speaker__c> getSessionSpeakers(List<Id> sessionSpeakerIds) {
        // Retrieve session name and time + speaker name and email address related to ID's
        List<Session_Speaker__c> sessionSpeakers =
        [SELECT Session__r.Name,
            Session__r.Session_Date__c,
            Speaker__r.First_Name__c,
            Speaker__r.Last_Name__c,
            Speaker__r.Email__c
        FROM Session_Speaker__c WHERE Id IN :sessionSpeakerIds];

        return sessionSpeakers;
    }

    public static List<Session__c> getRelatedSessions (Map<ID,DateTime> requestedBookings){
        List<Session__c> relatedSessions = [SELECT ID, Session_Date__c from Session__c WHERE ID IN :requestedBookings.keySet()];
        return relatedSessions;
    }

    public static List<Session_Speaker__c> getRelatedSpeakerSession (List<Id> speakerIds){
        List<Session_Speaker__c> relatedSpeakers = [SELECT ID, Speaker__c, Session__c, Session__r.Session_Date__c from Session_Speaker__c WHERE Speaker__c IN :speakerIds];
        return relatedSpeakers;
    }

}