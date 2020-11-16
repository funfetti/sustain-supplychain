public with sharing class SampleAuraController {
    @AuraEnabled
    public static List <Account> getAccountList() {
        System.debug('## inside get Account list'); 

        List<Account> accList = new List<Account>();
        /*accList = [SELECT Id, Name, NumberOfEmployees, Phone,
                   (SELECT FirstName, LastName, Email FROM Contacts)
                   FROM Account LIMIT 10];*/

        accList= [SELECT Id, Name, (SELECT Id, Name, Spend__c, Supplier__r.Name, Supplier__c, Item__c, Item__r.Name from Supplier_Materials__r) From Account];
        System.debug('## account list ' + accList); 
        return accList;
    }

    @AuraEnabled
    public static List <Item__c> getItemsList() {

        System.debug('## inside get Items list'); 
        List<Item__c> itmList = new List<Item__c> (); 
        itmList = [SELECT Id, Name, (SELECT Id, Name,Quantity__c,Spend__c from Supplier_Items__r) From Item__c  LIMIT 10];
        System.debug('## item supplier list ' + itmList); 
        return itmList;
    }

    @AuraEnabled
    public static List <Item__c> getBOM() {

        System.debug('## inside get BOM list'); 
        List<Item__c> itmList = new List<Item__c> (); 
        itmList = [SELECT Id, Name, (SELECT Id, Name, Quantity__c from BoM_Lines__r) From Item__c  LIMIT 10];
        System.debug('## item Bom list ' + itmList); 
        return itmList;
    }
}
