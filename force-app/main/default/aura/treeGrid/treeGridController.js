({
    doInit : function(component, event, helper) {
        var columns = [
            {
                fieldName: 'linkName',
                label: 'Account Id',
                type: 'url',
                     typeAttributes:{ 
                         target: '_blank',
                         label: {fieldName: 'Id'}
                     }
            },
            {
                type: 'text',
                fieldName: 'Name',
                label: 'Name'
            }
        ];
        component.set('v.gridColumns', columns);

        var columns2 = [
            {
                fieldName: 'linkName',
                label: 'Item Id', 
                type: 'url',
                     typeAttributes:{ 
                         target: '_blank',
                         label: {fieldName: 'Id'}
                     }
            },
            {
                type: 'text',
                fieldName: 'Name',
                label: 'Name'
            },
            {
                type: 'number',
                fieldName: 'Spend__c',
                label: 'Spend'
            },
            {
                type: 'number',
                fieldName: 'Quantity__c',
                label: 'Quantity'
            }
        ];
        component.set('v.gridColumns2', columns2);

        var columns3 = [
            {
                fieldName: 'linkName',
                label: 'Item Id', 
                type: 'url',
                     typeAttributes:{ 
                         target: '_blank',
                         label: {fieldName: 'Id'}
                     }
            },
            {
                type: 'text',
                fieldName: 'Name',
                label: 'Name'
            },
            {
                type: 'Number',
                fieldName: 'Quantity__c',
                label: 'Quantity'
            },
            

        ];
        component.set('v.gridColumns3', columns3);

        var action = component.get("c.getAccountList");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS" ) {
                var resultData = response.getReturnValue();
                console.log('## account list ###' + resultData[0]); 
                for (var i=0; i<resultData.length; i++ ) {
                    resultData[i]._children = resultData[i]['Supplier_Materials__r'];
                    delete resultData[i].Supplier_Materials__r; 
                }
                resultData.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });

                component.set('v.gridData', resultData);
            }
        });
        $A.enqueueAction(action);


        var action2 = component.get("c.getItemsList");
        action2.setCallback(this, function(response){
            var state2 = response.getState();
            if (state2 === "SUCCESS" ) {
                var resultData2 = response.getReturnValue();
                console.log('## items supplier list ###' + resultData2[0]); 
                for (var i=0; i<resultData2.length; i++ ) {
                    resultData2[i]._children = resultData2[i]['Supplier_Items__r'];
                    delete resultData2[i].Supplier_Items__r; 
                }
                resultData2.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                component.set('v.gridData2', resultData2);
            }
        });
        $A.enqueueAction(action2);

        var action3 = component.get("c.getBOM");
        action3.setCallback(this, function(response){
            var state3 = response.getState();
            if (state3 === "SUCCESS" ) {
                var resultData3 = response.getReturnValue();
                console.log('## items BOM list ###' + resultData3[0]); 
                for (var i=0; i<resultData3.length; i++ ) {
                    resultData3[i]._children = resultData3[i]['BoM_Lines__r'];
                    delete resultData3[i].BoM_Lines__r; 
                }
                /*resultData3.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });

{
    type: 'text',
    fieldName: 'Id',
    label: 'Item Id'

},*/

                resultData3.forEach(function(record){
                record.linkName = '/'+record.Id;
                });
                component.set('v.gridData3', resultData3);
            }
        });
        $A.enqueueAction(action3);

    },
    handleSelect: function (cmp, event, helper) {

        var selectedRows = event.getParam('selectedRows');
        console.log( ' ### selectedRows ', selectedRows[0].Id);
        var selectedData = [];
        var data = component.get('v.gridData');
        console.log( ' ### data ', data);

        for (var i = 0; i < selectedRows.length; i++ ) {
            for ( var j = 0; j< data.length; j++ ){
                if ( selectedRows[ i ].Id == data[ j ].Id ) {
                   
                    var childrenRecs = data[j][ '_children' ];
                    selectedData.push( data[j].Id );
                    for ( var k = 0; k < childrenRecs.length; k++ )
                    {
                        selectedData.push(childrenRecs[k].Id );   
                    }
            }
        }
        console.log('### selected data ' , selectedData);
        component.set('v.selectedRows', selectedData );
    }
},
       
handleSelect2: function (cmp, event, helper) {

    var selectedRows = event.getParam('selectedRows');
    console.log( ' ### selectedRows ', selectedRows[0].Id);
    var selectedData = [];
    var data = component.get( 'v.gridData2' );

    for (var i = 0; i < selectedRows.length; i++ ) {
        for ( var j = 0; j< data.length; j++ ){
            if ( selectedRows[ i ].Id == data[ j ].Id ) {
                var childrenRecs = data[j][ '_children' ];
                selectedData.push( data[j].Id );
                for ( var k = 0; k < childrenRecs.length; k++ )
                {
                    selectedData.push(childrenRecs[k].Id );   
                }
        }
    }
    component.set('v.selectedRows2', selectedData );
}
},

handleSelect3: function (cmp, event, helper) {

    var selectedRows = event.getParam( 'selectedRows' );
    console.log( ' ### selectedRows ', selectedRows[0].Id);
    var selectedData = [];
    var data = component.get( 'v.gridData3');

    for (var i = 0; i < selectedRows.length; i++ ) {
        for ( var j = 0; j< data.length; j++ ){
            if ( selectedRows[i].Id == data[j].Id ) {
                var childrenRecs = data[j][ '_children' ];
                selectedData.push( data[j].Id );
                for ( var k = 0; k < childrenRecs.length; k++ )
                {
                    selectedData.push(childrenRecs[k].Id );   
                }
        }
    }
    component.set('v.selectedRows3', selectedData );
}
},

})