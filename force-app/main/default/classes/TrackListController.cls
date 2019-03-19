public with sharing class TrackListController {
    @AuraEnabled
    public static List<Track__c> searchTracks( String searchTerm ) {
        List<Track__c> tracks = new List<Track__c>();
        if ( String.isNotBlank( searchTerm ) ) {
            List<List<SObject>> searchResults = [
                FIND :searchTerm
                RETURNING Track__c(
                    Name, Name__c, Image__c, Artist__c
                    ORDER BY Name
                    LIMIT 10
                )
            ];
            tracks = searchResults[0];
        }
        return tracks;
    }
}
