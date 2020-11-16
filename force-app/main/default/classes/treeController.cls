public class treeController {
     
    @AuraEnabled
    public static List<item> getAccountTree(){
         
        List<item> items = new List<item>();
        List<Account> acctList = new List<Account>();
        //get list of accounts and respective supplier items
        acctList = [SELECT Id, Name, (SELECT Id, Name,Item__c From Supplier_Materials__r) From Account LIMIT 10];
        for(Account acc: acctList){
             
            List<item> conitems = new List<item>();
            
            //get supplier items of current account record
            for(Supplier_Item__c c: acc.Supplier_Materials__r){
                List<item> supitems = new List<item>();
                List<Item__c> temp = new List<Item__c>();
                temp = [SELECT Id, Name From Item__c where Id=:c.Item__c]; 
                for (Item__c i : temp)
                {
                    // add items__c
                    item supitem = new item(i.Name, String.valueOf(i.Id), false, null);
                    supitems.add(supitem);
                }
                //add supplier items
                item conitem = new item(c.Name, String.valueOf(c.Id), false, supitems);
                conitems.add(conitem);
            }
            //add account items
            item accitem = new item(acc.Name, String.valueOf(acc.Id), false, conitems);
            items.add(accitem);
        }
        return items;
    }

    //Item Wrapper Class
    public class item{
        @AuraEnabled
        public String label {get; set;}
        @AuraEnabled
        public String name {get; set;}
        @AuraEnabled
        public Boolean expanded {get; set;}
        @AuraEnabled
        public List<item> items {get; set;}
         
        public item(String label, String name, Boolean expanded, List<item> items){
            this.label = label;
            this.name = name;
            this.expanded = expanded;
            this.items = items;
        }
    }
}