public with sharing class TriggerBecaHandler extends TriggerHandler{
    private Map<Id, Beca__c> newMap;
    private Map<Id, Beca__c> oldMap;
    private List<Beca__c> newList;
    private List<Beca__c> oldList;
    
    
    public TriggerBecaHandler() {
        this.newMap = (Map<Id, Beca__c>) trigger.newMap;
        this.oldMap = (Map<Id, Beca__c>) trigger.oldMap;
        this.newList = (List<Beca__c>) trigger.new;
        this.oldList = (List<Beca__c>) trigger.old;
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
    
    public void sendToERP(list<Beca__c> newBecas,map<Id,Beca__c> oldMap){
    	set<Id> ids = new set<Id>();
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Beca__c')){
    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Beca__c')){
    			for(Beca__c beca: newBecas){
    				if(beca.get(field) != oldMap.get(beca.Id).get(field)){
	    				ids.add(beca.Id);
	    			}
    			}
    		}
    	}
    	
    	try{
    		list<Lead> leads = [SELECT id,ModificadoERP__c FROM Lead WHERE Beca__c IN : ids];
    		for(Lead lead:leads){
    			lead.ModificadoERP__c = true;
    		}
    		update leads;
    	}catch(Exception e){
    		System.debug('Error al actulizar candidatos para envío a ERP');
    	}
    	
    	try{
    		list<Opportunity> opportunities = [SELECT id,ModificadoERP__c FROM Opportunity WHERE Beca__c IN : ids];
    		for(Opportunity opp:opportunities){
    			opp.ModificadoERP__c = true;
    		}
    		update opportunities;
    	}catch(Exception e){
    		System.debug('Error al actulizar oportunidades para envío a ERP');
    	}
    }
    
}