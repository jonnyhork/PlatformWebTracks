public with sharing class TracksAPI {
    public TracksAPI() {

        
        /* Properties */
        List<Object> topTracksResult =  null;
    
        /* Methods */
        
        // get all tracks from lastFM
        public void getAllTracks() {
            Http http = new Http();
            HttpRequest request = new HttpRequest();

            request.setEndpoint('http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=dcb52cb30d8bd2517d9a69b72d25e23f&format=json')
            request.setMethod('GET');

            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> allTracksData = (Map<String, Object>) results.get('tracks');
                
                this.topTracksResult = (List<Object>) allTracksData.get('track');
            }
        }

        // update the model with API data

        public void parseAndInsertAPIData(List<Object> topTracks) {
            
            for (Object track: topTracks) {
                Map<String, Object> singleTrack = (Map<String, Object>) track;
                
                // Track name
                String trackName = (String) singleTrack.get('name');
                
                // Artist Name
                Map<String, Object> artist = (Map<String, Object>) singleTrack.get('artist');
                String artistName = (String) artist.get('name');
                
                // Image URL
                List<Object> images = (List<Object>) singleTrack.get('image');
                Map<String, Object> largeImage = (Map<String, Object>) images[3];
                String largeImageURL = (String)largeImage.get('#text');
            
                CustomObject__c myTrackObject = new CustomObject__c (
                    Name = trackName,
                    Name__c = trackName,
                    Artist__c = artistName,
                    Image__c = largeImageURL,
                    
                );

                insert myTrackObject;
            }
        } 
    }
}
