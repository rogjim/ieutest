public with sharing class TriggerOportunidadHandler extends TriggerHandler{
    private Map<Id, Opportunity> newMap;
	private Map<Id, Opportunity> oldMap;
	private List<Opportunity> newList;
	private List<Opportunity> oldList;
	
	public TriggerOportunidadHandler() {
			this.newMap = (Map<Id, Opportunity>) trigger.newMap;
			this.oldMap = (Map<Id, Opportunity>) trigger.oldMap;
			this.newList = (List<Opportunity>) trigger.new;
			this.oldList = (List<Opportunity>) trigger.old;
			
	}
	
	
    public override void beforeInsert(){
		assignFolio(newList);
	}
	
	public override void afterUpdate(){
		assignWonOpportinities(newList);
		assignVerifiedOpportinities(newList);
		
	}
    
    public override void beforeUpdate(){
        sendToERP(newList,this.oldMap);
    }
	/**
    * @author:      Rogelio Jimenez
    * @date:        09/06/2016
    * @description: Asigna folio si la oportunidad no viene de un lead
    * @param:       list<Opportunity>
    * @return:      
    */
    
    public void assignFolio(List<Opportunity> opportunities){
        //Para verificar si viene de un lead hay que obtener los lead con idOportunidad
        set<Id> idsOpp = new set<Id>();
    	map<Id,Lead> mapOppLead = new map<Id,Lead>();
    	Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
    	Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
    	
    	for(Opportunity opp : opportunities){
    		//idsOpp.add(opp.Id);
    		if(!opp.EsConvertido__c){
    			nextFolio = nextFolio + 1;
    			opp.Folio__c = String.valueOf(nextFolio);
    		}
    	}
    	
    	configuracionNegocio.Folio__c = nextFolio;
     	update configuracionNegocio;
    	
    	/*for(Lead lead: [SELECT id,Name,ConvertedOpportunityId,Folio__c FROM Lead WHERE ConvertedOpportunityId IN : idsOpp ]){
    		System.debug(lead);
            if(!mapOppLead.containsKey(lead.ConvertedOpportunityId)){
    			mapOppLead.put(lead.ConvertedOpportunityId, lead);
    		}
    	}
    	
    	for(Opportunity opp : opportunities){
    		nextFolio = nextFolio + 1;
    		opp.Folio__c = String.valueOf(nextFolio);
    		if(!mapOppLead.containsKey(opp.Id)){
    			nextFolio = nextFolio + 1;
    			opp.Folio__c = String.valueOf(nextFolio);
            }else{
                 Lead lead= mapOppLead.get(opp.Id);
                 opp.Folio__c = String.valueOf(lead.Folio__c);
            }
    	}*/
    	
    	
    }
    
    /**
    * @author:      Rogelio Jimenez
    * @date:        17/06/2016
    * @description: Aumenta el valor de Incritos en el grupo cuando una oportuinda es Inscrito o Ganada
    * @param:       list<Opportunity>
    * @return:      
    */   
    public void assignWonOpportinities(List<Opportunity> opportunities){
    	list<Opportunity> opportunitesWon = new list<Opportunity>();
    	set<Id> idGrupos = new set<Id>();
    	map<Id,Grupo__c> mapGrupo = new map<Id,Grupo__c>();
    	
    	for(Opportunity oportunidad : opportunities){
    		if(oldMap.get(oportunidad.Id).StageName != oportunidad.StageName && oldMap.get(oportunidad.Id).StageName != 'Inscrito' && (oportunidad.StageName == 'Ganada' || oportunidad.StageName == 'Inscrito')){
    			opportunitesWon.add(oportunidad);
    			if(oportunidad.Grupo__c != null){
    				idGrupos.add(oportunidad.Grupo__c);
    			}
    		}
    	}
    	
    	mapGrupo = new Map<ID,Grupo__c>([SELECT Id,Inscritos__c FROM Grupo__c WHERE Id IN : idGrupos]);
    	
    	for(Opportunity oportunidad : opportunitesWon){
    		if(mapGrupo.containsKey(oportunidad.Grupo__c)){
    			Decimal inscritosAux = mapGrupo.get(oportunidad.Grupo__c).Inscritos__c != null ? mapGrupo.get(oportunidad.Grupo__c).Inscritos__c : 0;
    			inscritosAux = inscritosAux + 1;
    			mapGrupo.get(oportunidad.Grupo__c).Inscritos__c = inscritosAux;
    		}
    	}
    	if(mapGrupo.values().size() >0){
    		update mapGrupo.values();
    	}
    }
    
    /**
    * @author:      Rogelio Jimenez
    * @date:        17/06/2016
    * @description: Aumenta el valor de Verificados en el grupo cuando una oportuinda es verificada
    * @param:       list<Opportunity>
    * @return:      
    */
     public void assignVerifiedOpportinities(List<Opportunity> opportunities){
    	list<Opportunity> opportunitesVerify = new list<Opportunity>();
    	set<Id> idGrupos = new set<Id>();
    	map<Id,Grupo__c> mapGrupo = new map<Id,Grupo__c>();
    	
    	for(Opportunity oportunidad : opportunities){
    		if(oldMap.get(oportunidad.Id).Validado__c != oportunidad.Validado__c && oportunidad.Validado__c ){
    			opportunitesVerify.add(oportunidad);
    			if(oportunidad.Grupo__c != null){
    				idGrupos.add(oportunidad.Grupo__c);
    			}
    		}
    	}
    	
    	mapGrupo = new Map<ID,Grupo__c>([SELECT Id,Inscritos__c,Validados__c FROM Grupo__c WHERE Id IN : idGrupos]);
    	
    	for(Opportunity oportunidad : opportunitesVerify){
    		if(mapGrupo.containsKey(oportunidad.Grupo__c)){
    			Decimal validadadosAux = mapGrupo.get(oportunidad.Grupo__c).Validados__c != null ? mapGrupo.get(oportunidad.Grupo__c).Validados__c : 0;
    			validadadosAux = validadadosAux + 1;
    			mapGrupo.get(oportunidad.Grupo__c).Validados__c = validadadosAux;
    		}
    	}
    	if(mapGrupo.values().size() >0){
    		update mapGrupo.values();
    	}
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        27/06/2016
    * @description: Verifica el cambio en los campos para poder ser envaidos en Batch del ERP Master
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
    public void sendToERP(list<Opportunity> newLeads,map<Id,Opportunity> oldMap){
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Opportunity')){
    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Opportunity')){
    			for(Opportunity opp: newLeads){
	    			if(opp.get(field) != oldMap.get(opp.Id).get(field) &&!opp.ModificadoERP__c){
	    				opp.ModificadoERP__c = true;
	    				break;
	    			}
    			}
    		}
    	}
    }
    
}