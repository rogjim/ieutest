public with sharing class OFE_OfertaAcademicaMotor {
	public Periodo__c period {get;set;}
    public OFE_OfertaAcademicaMotor(){
    
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        16/05/2016
    * @description: 
    * @param:       Lead
    * @return:      OfertaEducativa__c
    */
    
     public map<lead,OfertaEducativa__c> obtainAcademicOffer(list<lead> leads){
    	OfertaEducativa__c academicOffert = new OfertaEducativa__c();
    	map<lead,OfertaEducativa__c> mapLeadOferta = new map<lead,OfertaEducativa__c>();
    	String modalidad = '';
    /*	modalidad = lead.ModalidadPresencial__c ? modalidad + ' OR ActivoPresencial__c = true ': '';
    	modalidad = lead.ModalidadOnline__c ? modalidad + ' OR ActivoOnline__c = true ': modalidad + '';
    	modalidad = lead.ModalidadEjecutiva__c ? modalidad + ' OR ActivoEjecutiva__c = true ': modalidad + '';*/
    	
    	modalidad = ' AND (ActivoPresencial__c = true  OR ActivoOnline__c = true OR ActivoEjecutiva__c = true)';
        
    	String query = 'SELECT Id,Name,ActivoPresencial__c,ActivoOnline__c,ActivoEjecutiva__c FROM Periodo__c WHERE Activo__c = \'Activo\' ' + modalidad;
        //System.debug('obtainAcademicOffer: ' + query);
        List<Periodo__c> listPeriod= (List<Periodo__c>) Database.query(query);
        //period = listPeriod[0];
        
        for(Periodo__c period:listPeriod ){
        	for(Lead lead:leads){
        		academicOffert = getAccademicOferByPeriodo(period,lead);
                if(academicOffert != null){
	        		mapLeadOferta.put(lead,academicOffert);
                }
        	}
        	
        }
        return mapLeadOferta;
    }
    
    public OfertaEducativa__c obtainAcademicOffer(Lead lead){
        System.debug(lead);
    	OfertaEducativa__c academicOffert = new OfertaEducativa__c();
    	String modalidad = '';
    	modalidad = lead.ModalidadPresencial__c ? modalidad + ' AND ActivoPresencial__c = true ': '';
    	modalidad = lead.ModalidadOnline__c ? modalidad + ' AND ActivoOnline__c = true ': modalidad + '';
    	modalidad = lead.ModalidadEjecutiva__c ? modalidad + ' AND ActivoEjecutiva__c = true ': modalidad + '';
        
    	String query = 'SELECT Id,Name,ActivoPresencial__c,ActivoOnline__c,ActivoEjecutiva__c FROM Periodo__c WHERE Activo__c = \'Activo\' ' + modalidad;
        //System.debug('obtainAcademicOffer: ' + query);
        List<Periodo__c> listPeriod= (List<Periodo__c>) Database.query(query);
        //period = listPeriod[0];
        
        for(Periodo__c period:listPeriod ){
        	academicOffert = getAccademicOferByPeriodo(period,lead);
        	if(academicOffert != null){
        		 return academicOffert;
        	}
        }
        //System.debug(academicOffert);
        return academicOffert;
    }
    
     /**
    * @author:      Rogelio Jiménez
    * @date:        16/05/2016
    * @description: 
    * @param:       
    * @return:     OfertaEducativa__c
    */
     public static OfertaEducativa__c getAccademicOferByPeriodo(Periodo__c period,Lead lead){
     	OfertaEducativa__c accademicOffer = null;
         System.debug('Periodo: ' + period);
         System.debug('lead: '+ lead);
     	list<OfertaEducativa__c> oferts = new list<OfertaEducativa__c>();
     	if(period!= null && lead != null){
     		System.debug('getAccademicOferByPeriodo: ' + period +',' + lead.Modalidad__c +','+ lead.Plantel__c +',' +  lead.Nivel__c + ',' +  lead.Programa__c);
     		if((lead.ModalidadPresencial__c &&  period.ActivoPresencial__c) || 
     				(lead.ModalidadOnline__c &&  period.ActivoOnline__c) || (lead.ModalidadEjecutiva__c &&  period.ActivoEjecutiva__c)){
     					try{
				     	 		oferts = [SELECT id,Name,Periodo__c,Modalidad__c,Plantel__c,Nivel__c,Programa__c
				     	 												FROM OfertaEducativa__c WHERE Periodo__c =: period.Id 
				     	 												AND Modalidad__c =: lead.Modalidad__c AND Plantel__c =: lead.Plantel__c
				     	 												AND Nivel__c =: lead.Nivel__c AND Programa__c =: lead.Programa__c AND Estatus__c =: 'Activo'
				     	 												];
				     	}catch(Exception e){
				     		System.debug('No hay oferta académica que asignar: ' + e.getMessage());
				     	}
     		
     		}
     		
     	
     	//Devolver la que tiene prioridad online. Pendiente RJP
 	 	if(oferts.size() > 0)
 	 		accademicOffer = oferts[0];
     	}
     	System.debug('oferta: ' + accademicOffer);
     	return accademicOffer;
     }
     
     /**
    * @author:      Rogelio Jiménez
    * @date:        16/05/2016
    * @description: 
    * @param:       
    * @return:     OfertaEducativa__c
    */
     public  Grupo__c getGroupByAcademicOffer(OfertaEducativa__c academicOffer){
     	Grupo__c groupAssigned = new Grupo__c() ;
     	list<Grupo__c> groupsAssigned = new list<Grupo__c>();
     	if(academicOffer != null){
     			groupsAssigned = [SELECT id,Name,Grupo__c,OfertaEducativa__c,OfertaEducativa__r.Modalidad__c,OfertaEducativa__r.Modalidad__r.Name,Cupo__c,ProspectosAsignados__c 
     							FROM Grupo__c 
     							WHERE  OfertaEducativa__c =: academicOffer.Id];            	
         	System.debug('size groupasi '+groupsAssigned.size() );
            if(groupsAssigned.size() >= 1){
                        Integer maximoInscribir = 0;
                        Integer prospectosAsignados = 0;
         			    for(Grupo__c grupo:groupsAssigned){
                            if (grupo.OfertaEducativa__r.Modalidad__r.Name == 'Presencial' || grupo.OfertaEducativa__r.Modalidad__r.Name == 'Ejecutiva' ){
                                    maximoInscribir = Integer.valueOf(grupo.Cupo__c) *  Integer.valueOf(Negocio__c.getOrgDefaults().MaximoGrupo__c);
                                    prospectosAsignados = grupo.ProspectosAsignados__c != null ? prospectosAsignados: 0;
                                    if(prospectosAsignados <= maximoInscribir){
                                        groupAssigned = grupo;
                                        break;
                                    }
                            }else{
                                System.debug('grupo.Cupo__c--> '+grupo.Cupo__c);
                                System.debug('Negocio__c.getOrgDefaults().MaximoGrupoOnline__c--> '+Negocio__c.getOrgDefaults().MaximoGrupoOnline__c);
                                
                                 maximoInscribir = Integer.valueOf(grupo.Cupo__c) * Integer.valueOf(Negocio__c.getOrgDefaults().MaximoGrupoOnline__c);
                                  prospectosAsignados = grupo.ProspectosAsignados__c != null ? prospectosAsignados: 0;
                                 if(prospectosAsignados <= maximoInscribir){
                                        groupAssigned = grupo;
                                        break;
                                 }
                            }
                        }
         		}else if (groupsAssigned.size() == 1){
                    groupAssigned = groupsAssigned.get(0);
                    if(groupAssigned.ProspectosAsignados__c == null){
                        groupAssigned.ProspectosAsignados__c = 1;
                    }else{
                        groupAssigned.ProspectosAsignados__c = groupAssigned.ProspectosAsignados__c + 1;
                    }
                }
     	}
     	return groupAssigned;
     }
     
}