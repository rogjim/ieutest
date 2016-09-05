public with sharing class OFE_CandidatoMotor {
    
    public OFE_CandidatoMotor(){
    
    }
    /**
    * @author:      Rogelio Jiménez
    * @date:        10/05/2016
    * @description: Obtiene los promotores por plantel
    * @param:       Lead
    * @return:      map<Id,list<Promotor__c>>
    */
    public Promotor__c lookupForPromotor(Lead lead){
        Promotor__c promotorAssigned = null;
        if(Utils.MAP_PROMOTORES_BY_PLANTEL.containsKey(lead.Plantel__c)){
            list<Promotor__c> promotores = Utils.MAP_PROMOTORES_BY_PLANTEL.get(lead.Plantel__c);
              System.debug('lookupForPromotor: Si contiene' );
           	promotorAssigned = getNextPromotor(promotores);
        }else{
        	if(Utils.getCatalogoId('Plantel', 'UNIVERSIDAD VIRTUAL') != null){
	        	list<Promotor__c> promotores = Utils.MAP_PROMOTORES_BY_PLANTEL.get(Utils.getCatalogoId('Plantel', 'UNIVERSIDAD VIRTUAL'));
	           	promotorAssigned = getNextPromotor(promotores);
        	}
        }
        return promotorAssigned;
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        10/05/2016
    * @description: Obtiene y actualiza los promotores de acuerdo al número asignados
    * @param:       list<Promotor__c>
    * @return:     Promotor__c
    */
    public Promotor__c getNextPromotor(list<Promotor__c> promotores){
        Promotor__c promotorChoosen = null;
        boolean hasMaximo = true;
        
        /*if(promotores[0].CandidatosAsignados__c == Utils.MAX_LEAD_BY_PROMOTOR){
	        for(integer indice= 0; indice<promotores.size();indice++){
        		if(promotores[0].CandidatosAsignados__c != promotores[indice].CandidatosAsignados__c){
        			hasMaximo = false;
        		}
	        }
	        if(hasMaximo){
	        	for(Promotor__c promotor: promotores){
	        		promotor.CandidatosAsignados__c = 0;
	        	}
	        	update promotores;
	        }
        }*/
        
        for(integer i= 0; i<promotores.size() -1;i++){
            for(integer j = 0; j<promotores.size() -1 ;j++){
                if(promotores[j+1].CandidatosAsignados__c < promotores[j].CandidatosAsignados__c){
                    promotorChoosen =   promotores[j+1];
                    break;
                }
            }
        } 
        
        if(promotorChoosen != null){
        	return promotorChoosen;
        }else{
        	return promotores[0];
        }
        
    }
}