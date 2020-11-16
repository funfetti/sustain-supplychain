public with sharing class treeAuraController {
    @AuraEnabled
    public static List<wrapperitem> getAccountTree()
    {
    System.debug('in getAccount Tree ');
    List<wrapperitem> items = new List<wrapperitem>();
    List<Account> acctList = new List<Account>();
        //get list of accounts and respective contacts
        List<Supplier_Item__c> suppliers = new List<Supplier_Item__c>(); 
        suppliers = [SELECT Id, Name, Spend__c, Supplier__r.Name, Supplier__c, Item__c, Item__r.Name FROM Supplier_Item__c]; 

        //acctList = [SELECT Id, Name, (SELECT Id, Name From Contacts) From Account LIMIT 10];
            for(Supplier_Item__c acc: suppliers){
            
            List<wrapperitem> conitems = new List<wrapperitem>();
            List<Bill_of_Materials__c> bom = new List<Bill_of_Materials__c>();
            bom = [SELECT Id, Name, Item__c, Item__r.Name, Effectivity_Start_Date__c, Effectivity_End_Date__c From Bill_of_Materials__c WHERE Item__c =:acc.Item__c];
            System.debug('supplier and bom ' + acc.Name + ' ' + bom); 
        

            for(Bill_of_Materials__c b : bom)
            {

                System.debug('bom ' + b.Name);   
                wrapperitem conitem = new wrapperitem(b.Item__r.Name, String.valueOf(b.Item__c),false, null); 
                conitems.add(conitem);
            }

            System.debug('con Items ' + conitems);      
            wrapperitem supplieritem = new wrapperitem(acc.Name, String.valueOf(acc.Id),false, null);
            items.add(supplieritem);
        }

        System.debug(' Final Items ' + items);      
        return items;
    }
    
       //Item Wrapper Class
       public class wrapperitem{
       @AuraEnabled
       public String itemName {get; set;}
       @AuraEnabled
       public String itemId {get; set;}
       @AuraEnabled
       public Boolean expanded {get; set;}
       @AuraEnabled
       public List<wrapperitem> items {get; set;}

       
       public wrapperitem(String itemName, String itemId,Boolean expanded,List<wrapperitem> items){
           this.itemName = itemName;
           this.itemId = itemId;
           this.expanded = expanded;
           this.items = items;
       }
   }
}

        //List<Bill_of_Materials__c> bom = New List<Bill_of_Materials__c>();
        //bom = [SELECT Id, Name, Item__c, Item__r.Name, Effectivity_Start_Date__c, Effectivity_End_Date__c From Bill_of_Materials__c WHERE Item__c =:acc.Item__c LIMIT 10];

    /* String itemName; 
    String itemType;
    String itemId; 

    itemId = bom[0].Item__c; 
    itemId = acc.Item__c; 
    
    Item__c item = [SELECT Id, Name, Item_Type__c, Primary_BoM__c From Item__c Where Id =:itemId];

    List<wrapperitem> conitems = new List<wrapperitem>();
    
        wrapperitem conitem = new item(acc.Name, bom.Name, false, null);
        conitems.add(conitem);
    */
    
    
            
        //add account items


                /*List<wrapperitem> primarybom = new List<wrapperitem>();
                List<Item__c> itm = new List<Item__c>();
                itm = [SELECT Id, Name, Primary_BoM__c From Item__c  WHERE Primary_BoM__c =:b.Id];
                System.debug('item ' + itm); 

                for(Item__c i: itm)
                {
                    System.debug('itm ' + i.Name);   
                    wrapperitem i_item = new wrapperitem(i.Name, String.valueOf(i.Id),false, null); 
                    primarybom.add(i_item);
                }*/
