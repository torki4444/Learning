/**
 * Created by CIVCIZ on 02-May-17.
 */

public with sharing class SessionSpeakerService {

    public static void sendConfirmationEmail (List<Session_Speaker__c> sessionSpeakers){

        //collect ID's in one list of a single SOQL query
        List<Id> sessionSpeakerIds = new List<Id>();
        for(Session_Speaker__c newItem : sessionSpeakers) {
        sessionSpeakerIds.add(newItem.Id);
        }

        // Retrieve session name and time + speaker name and email address related to ID's
        List<Session_Speaker__c> sessionSpeakersToSendEmail = SessionSpeakerSelector.getSessionSpeakers(sessionSpeakerIds);

        if(sessionSpeakersToSendEmail.size() > 0) {
        // Send confirmation email if we know the speaker's email address
        Session_Speaker__c sessionSpeaker = sessionSpeakersToSendEmail[0];
            if (sessionSpeaker.Speaker__r.Email__c != null) {
            String address = sessionSpeaker.Speaker__r.Email__c;
            String subject = 'Speaker Confirmation';
            String message = 'Dear ' + sessionSpeaker.Speaker__r.First_Name__c +
                    ',\nYour session "' + sessionSpeaker.Session__r.Name + '" on ' +
                    sessionSpeaker.Session__r.Session_Date__c + ' is confirmed.\n\n' +
                    'Thanks for speaking at the conference!';
            EmailManager.sendMail(address, subject, message);
            }
        }
    }

    public static void rejectDoubleBooking (List<Session_Speaker__c> sessionSpeakers){

        //collect ID's to reduce data calls
        List<Id> speakerIds = new List<Id>();
        Map<Id,DateTime> requested_bookings = new Map<Id,DateTime>();

        //get all speakers related to the trigger
        //set booking map with ids to fill later
        for(Session_Speaker__c newItem : sessionSpeakers) {
            requested_bookings.put(newItem.Session__c,null);
            speakerIds.add(newItem.Speaker__c);
        }

        //fill out the start date/time for the related sessions
        List<Session__c> related_sessions = SessionSpeakerSelector.getRelatedSessions(requested_bookings);
        for(Session__c related_session : related_sessions) {
            requested_bookings.put(related_session.Id,related_session.Session_Date__c);
        }

        //get related speaker sessions to check against
        List<Session_Speaker__c> related_speakers = SessionSpeakerSelector.getRelatedSpeakerSession(speakerIds);

        //check one list against the other
        for(Session_Speaker__c requested_session_speaker : sessionSpeakers) {
            DateTime booking_time = requested_bookings.get(requested_session_speaker.Session__c);
            for(Session_Speaker__c related_speaker : related_speakers) {
                if(related_speaker.Speaker__c == requested_session_speaker.Speaker__c &&
                        related_speaker.Session__r.Session_Date__c == booking_time) {
                    requested_session_speaker.addError('The speaker is already booked at that time');
                }
            }
        }




    }

}