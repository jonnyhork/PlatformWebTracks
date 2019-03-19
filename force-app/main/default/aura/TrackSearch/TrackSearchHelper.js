({
    // code in the helper is reusable by both
    // the controller.js and helper.js files
    handleSearch: function( component, searchTerm ) {
        var action = component.get( "c.searchTracks" );
        action.setParams({
            searchTerm: searchTerm
        });
        action.setCallback( this, function( response ) {
            var event = $A.get( "e.c:TracksLoaded" );
            event.setParams({
                "tracks": response.getReturnValue()
            });
            event.fire();
        });
        $A.enqueueAction( action );
    }
})