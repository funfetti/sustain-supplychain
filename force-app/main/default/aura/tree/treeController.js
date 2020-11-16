({
    doInit: function (component, event, helper) {
        var spinner = component.find("spnr");
        var action = component.get('c.getAccountTree');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                //get account and respective contact list, and initialize with items
                console.log('return items ' + response.getReturnValue());
                component.set('v.items', response.getReturnValue());
                //hide spinner after getting data
                $A.util.toggleClass(spinner, "slds-hide");
            }else{
                $A.util.toggleClass(spinner, "slds-hide");
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    handleSelect: function (cmp, event, helper) {
        //return name of selected tree item
        var selectedName = event.getParam('name');
        //alert("Selected Name: " + selectedName);
        console.log('selectedName ' , selectedName);
        //return (new ApexPages.StandardController (new SObject(Id=selectedName))).view(); 

    /* var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
        "recordId": selectedName,
        "slideDevName": "related"
    });
    navEvt.fire();
    */
        window.open('/' + selectedName);  


    }
})