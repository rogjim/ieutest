public with sharing class TriggerPromotorHandler extends TriggerHandler{
	
	private Map<Id, Promotor__c> newMap;
	private Map<Id, Promotor__c> oldMap;
	private List<Promotor__c> newList;
	private List<Promotor__c> oldList;
	
	public TriggerPromotorHandler() {
			this.newMap = (Map<Id, Promotor__c>) trigger.newMap;
			this.oldMap = (Map<Id, Promotor__c>) trigger.oldMap;
			this.newList = (List<Promotor__c>) trigger.new;
			this.oldList = (List<Promotor__c>) trigger.old;
	}
		
    public override void beforeInsert(){
    	set<Id> idUsers = new set<Id>();
    	for(Promotor__c promotor : newList){
    		if(promotor.Promotor__c != null){
    			idUsers.add(promotor.Promotor__c);
    		}
    	}
    	Utils.assignPictureProfileUrl(idUsers,newList);
    }
    
     public override void beforeUpdate(){
     	set<Id> idUsers = new set<Id>();
    	for(Promotor__c promotor : newList){
    		if(promotor.Promotor__c != null){
    			idUsers.add(promotor.Promotor__c);
    		}
    	}
    	Utils.assignPictureProfileUrl(idUsers,newList);
     }
    
   
}