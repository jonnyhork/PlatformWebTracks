({
    onTracksLoaded: function( component, event, helper ) {
        var cols = [
            {
                'label': 'Name',
                'fieldName': 'Name__c',
                'type': 'text'
            },
            {
                'label': 'Artist',
                'fieldName': 'Artist__c',
                'type': 'phone'
            },
            {
                'label': 'Image',
                'fieldName': 'Image__c',
                'type': 'url'
            },
            {
                'label': 'Action',
                'type': 'button',
                'typeAttributes': {
                    'label': 'View Image',
                    'name': 'view_image'
                }
            }
        ];
        component.set( 'v.cols', cols );
        component.set( 'v.rows', event.getParam( 'tracks' ) );
    },
    onRowAction: function( component, event, helper ) {
        var action = event.getParam( 'action' );
        var row = event.getParam( 'row' );
        if ( action.name == 'view_image' ) {
            var navigation = component.find( 'navigation' );
            navigation.navigate({
                'type': 'standard__recordPage',
                'attributes': {
                    'objectApiName': 'Track__c',
                    'recordId': row.Id,
                    'actionName': 'view'
                }
            });
        }
    }
})
