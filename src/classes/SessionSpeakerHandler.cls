/**
 * Created by CIVCIZ on 02-May-17.
 */

public with sharing class SessionSpeakerHandler {

    public static void afterInsert (List<Session_Speaker__c> sessionSpeakers){
        SessionSpeakerService.sendConfirmationEmail(sessionSpeakers);
    }

    public static void beforeInsertOrUpdate (List<Session_Speaker__c> sessionSpeakers){
        SessionSpeakerService.rejectDoubleBooking (sessionSpeakers);
    }
}