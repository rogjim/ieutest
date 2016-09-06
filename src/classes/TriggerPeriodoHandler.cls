public with sharing class TriggerPeriodoHandler extends TriggerHandler{
    private Map<Id, Periodo__c> newMap;
	private Map<Id, Periodo__c> oldMap;
	private List<Periodo__c> newList;
	private List<Periodo__c> oldList;
	
	public TriggerPeriodoHandler() {
			this.newMap = (Map<Id, Periodo__c>) trigger.newMap;
			this.oldMap = (Map<Id, Periodo__c>) trigger.oldMap;
			this.newList = (List<Periodo__c>) trigger.new;
			this.oldList = (List<Periodo__c>) trigger.old;
	}
		
    public override void beforeInsert(){
    	verifyDuplicatedDate();
    }

    public override void beforeUpdate(){
    	verifyActivation();
    }

    /*@author: Rogelilo Jimenez
    *@description:
    */
    private void verifyDuplicatedDate(){
    	for(Periodo__c newPeriodo : newList){
    		String skey = '' + newPeriodo.FechaInicio__c.month() + newPeriodo.FechaInicio__c.year() + newPeriodo.FechaFin__c.month() + newPeriodo.FechaFin__c.year();
    		if(setPeriodoFecha.contains(skey)){
    			newPeriodo.addError('No puede crearse un periodo activo en el mismo mes y año');
    		}
    	}
    }

   private void verifyActivation(){
   		for(Periodo__c newPeriodo : newList){
   			if(newPeriodo.Activo__c != oldMap.get(newPeriodo.Id).Activo__c && newPeriodo.Activo__c == 'Activo'){
   				try{
   					list<Grupo__c> grupos = [SELECT Id, Name FROM Grupo__c WHERE OfertaEducativa__r.Periodo__c =: newPeriodo.Id];
   					if(grupos.size() == 0){	
   						newPeriodo.addError(Utils.ERROR_PERIODO_SIN_GRUPOS);
   					}
   				}catch(Exception e){
   					newPeriodo.addError(Utils.ERROR_PERIODO_SIN_GRUPOS);
   				}
   			}
   		}

   }
    
   private  map<String,List< Periodo__c>> mapPeriodos{
		get{
			if(mapPeriodos == null){
				mapPeriodos = new Map<String, List<Periodo__c>>();
			}
			return mapPeriodos;
		}set;
	}
	
	private  set<String> setPeriodoFecha{
		get{
			if(setPeriodoFecha == null){
				setPeriodoFecha = new set<String>();
				for(Periodo__c periodo : [SELECT Id,Name,FechaInicio__c,FechaFin__c FROM Periodo__c]){
					String skey = '' + periodo.FechaInicio__c.month() + periodo.FechaInicio__c.year() + periodo.FechaFin__c.month() + periodo.FechaFin__c.year();
					setPeriodoFecha.add(skey);
				}
			}
			return setPeriodoFecha;
		}set;
	}
}