public with sharing class TriggerCuentaHandler extends TriggerHandler{
    private Map<Id, Account> newMap;
	private Map<Id, Account> oldMap;
	private List<Account> newList;
	private List<Account> oldList;
	
	public TriggerCuentaHandler() {
			this.newMap = (Map<Id, Account>) trigger.newMap;
			this.oldMap = (Map<Id, Account>) trigger.oldMap;
			this.newList = (List<Account>) trigger.new;
			this.oldList = (List<Account>) trigger.old;
	}
	
	 public override void afterUpdate(){
    	sendToERP(this.newList,this.oldMap);
    }
    
     /**
    * @author:      Rogelio Jiménez
    * @date:        27/06/2016
    * @description: Verifica el cambio en los campos para poder ser envaidos en Batch del ERP Master
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
    public void sendToERP(list<Account> newAccounts,map<Id,Account> oldMap){
    	set<Id> ids = new set<Id>();
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Account')){
    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Account')){
    			for(Account account: newAccounts){
    				if(account.get(field) != oldMap.get(account.Id).get(field)){
	    				ids.add(account.Id);
	    			}
    			}
    		}
    	}
    	
    	
    	try{
    		list<Opportunity> opportunities = [SELECT id,ModificadoERP__c FROM Opportunity WHERE AccountId IN : ids];
    		for(Opportunity opp:opportunities){
    			opp.ModificadoERP__c = true;
    		}
    		update opportunities;
    	}catch(Exception e){
    		System.debug('Error al actulizar oportunidades para envío a ERP');
    	}
    }
}