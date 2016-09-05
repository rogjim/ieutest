public with sharing class TriggerCandidatoHandler extends TriggerHandler{
    private Map<Id, Lead> newMap;
	private Map<Id, Lead> oldMap;
	private List<Lead> newList;
	private List<Lead> oldList;
	
	public list<Lead> leadsToWork {get;set;}
	public OFE_CandidatoMotor ofeMotorAsignacionCandidatos = new OFE_CandidatoMotor();
	public OFE_OfertaAcademicaMotor ofeMotorAsignacionOferta = new OFE_OfertaAcademicaMotor();
	
	public TriggerCandidatoHandler() {
			this.newMap = (Map<Id, Lead>) trigger.newMap;
			this.oldMap = (Map<Id, Lead>) trigger.oldMap;
			this.newList = (List<Lead>) trigger.new;
			this.oldList = (List<Lead>) trigger.old;
			leadsToWork = new list<Lead> ();
	}
	
	public override void beforeInsert(){
		for(Lead lead : newList){
			if(lead.AsignacionAutomatica__c && !Negocio__c.getInstance(lead.CreatedBy.ProfileId).OmiteAsignacionAutomaticaLead__c){
				leadsToWork.add(lead);
			}
			
		}
		
		addKeyLead(newList);
		verifyLeadDupicated(newList);
		
		verifyLeads(leadsToWork);
		assignOwner(leadsToWork);
		//WebToLead 
		if(putInformationWebToLead(newList).size() > 0){
			leadsToWork.addAll(putInformationWebToLead(newList));
		}
		assignAcademicOffert(leadsToWork);
        assignPrices(newList);
        assignFolio(newList);
        
	}

	public override void afterInsert(){
		sentMail(newList);
		agregateLeadtoGroup(newList);
        createPayToken(newList);
	}
	

	
	public override void afterUpdate(){
		list<Lead> leadGroups = new list<Lead>();
		for(Lead lead : newList){
			if(lead.GrupoAsignado__c != null && oldMap.get(lead.Id).GrupoAsignado__c != lead.GrupoAsignado__c){
				leadGroups.add(lead);
			}
		}

		if(leadGroups.size() > 0){
			agregateLeadtoGroup(leadGroups);
			
		}
		sendToGA(newList);
        convertMapingFields(newList);
        convertMapingFieldsSolicitudBeca(newList);
		convertMapingFieldsDescuento(newList);
	}
	
	
	public override void beforeUpdate(){
		list<Lead> leadUpdateKey = new list<Lead>();
		list<Lead> leadUpdateAcademicOffert = new list<Lead>();
		list<Lead> leadUpdateOwner = new list<Lead>();
		for(Lead lead : newList){
			
				if(lead.FirstName != oldMap.get(lead.id).FirstName || lead.LastName != oldMap.get(lead.id).LastName 
					|| lead.ApeMaterno__c != oldMap.get(lead.id).ApeMaterno__c || lead.Periodo__c != oldMap.get(lead.id).Periodo__c 
					|| lead.Email != oldMap.get(lead.id).Email || lead.Nivel__c != oldMap.get(lead.id).Nivel__c 
					|| lead.Programa__c != oldMap.get(lead.id).Programa__c || lead.Nivel__c != oldMap.get(lead.id).Nivel__c
					|| lead.ModalidadEjecutiva__c != oldMap.get(lead.id).ModalidadEjecutiva__c || lead.ModalidadOnline__c != oldMap.get(lead.id).ModalidadOnline__c 
					|| lead.ModalidadPresencial__c != oldMap.get(lead.id).ModalidadPresencial__c){
						leadUpdateKey.add(lead);
				}
				if(lead.ModalidadPresencial__c != oldMap.get(lead.id).ModalidadPresencial__c ||  lead.ModalidadOnline__c != oldMap.get(lead.id).ModalidadOnline__c
					||  lead.ModalidadEjecutiva__c != oldMap.get(lead.id).ModalidadEjecutiva__c){
					lead.Modalidad__c = Utils.getModalidad(lead).Id;
				}
				if(lead.AsignacionAutomatica__c){
					if(lead.Modalidad__c != oldMap.get(lead.id).Modalidad__c || lead.Plantel__c != oldMap.get(lead.id).Plantel__c 
						|| lead.Nivel__c != oldMap.get(lead.id).Nivel__c || lead.Programa__c != oldMap.get(lead.id).Programa__c  ){
							leadUpdateAcademicOffert.add(lead);
					}
				}
				if((lead.Promotor__c != null && oldMap.get(lead.Id).Promotor__c != lead.Promotor__c) 
					|| (lead.ActivarAsignacionW2L__c && oldMap.get(lead.Id).ActivarAsignacionW2L__c != lead.ActivarAsignacionW2L__c)){
					leadUpdateOwner.add(lead);
				}
					
		}
		
		addKeyLead(leadUpdateKey);
		if(leadUpdateAcademicOffert.size() > 0){
			assignAcademicOffert(leadUpdateAcademicOffert);
            assignPrices(newList);
		}
		if(leadUpdateOwner.size() >0){
			assignOwner(leadUpdateOwner);
		}

		
		sendToERP(newList,this.oldMap);
	}
	
	public void sentMail(list<Lead> newLeads){
		list<lead> leadsMail = new list<lead>();
		set<Id> ids = new set<Id>();
        for(Lead lead : newList){
            if(lead.AsignacionAutomatica__c == true && lead.Promotor__c != null && lead.SubOrigenCandidato__c != 'Calcula tu colegiatura'){
               leadsMail.add(lead);
               ids.add(lead.Id);
            }
		}
		MailAsignacionPromotor.sendMail(String.valueOf(ids));
	}
	
	/**
    * @author:      Rogelio Jimenez
    * @date:        09/05/2016
    * @description: Genera la llave por la cual se buscara coincidencia exacta entre los lead
    * @param:       list<Lead>
    * @return:      
    */
	public void addKeyLead(list<Lead> newLeads){
			for(Lead lead : newList){
				String modEjecutiva;
				String modOnline;
				String modPresencial;
				modEjecutiva = lead.ModalidadEjecutiva__c ? 'Ejecutiva': '';
				modOnline = lead.ModalidadOnline__c ? 'Online': '';
				modPresencial =lead.ModalidadPresencial__c ? 'Presencial' : '';
				lead.LlaveCandidato__c = lead.FirstName + ','+ lead.LastName + ',' + lead.ApeMaterno__c + ',' + lead.Periodo__c + ','
										 + lead.Email + ',' + lead.Nivel__c + ',' + lead.Programa__c + modEjecutiva + modOnline + modPresencial;
			}
	}
	
	/**
    * @author:      Rogelio Jimenez
    * @date:        09/05/2016
    * @description: Verifica que tengas los elementos necesarios para buscar un grupo a la oferta
    * @param:       list<Lead>
    * @return:      
    */
	public void verifyLeads(list<Lead> newLeads){
		list<Lead> leads = new list<Lead>();
		for(Lead lead : newLeads){
			if(lead.AsignacionAutomatica__c){
				lead.Modalidad__c = Utils.getModalidad(lead).Id;
				if(lead.Modalidad__c == null || lead.Plantel__c == null || lead.Nivel__c == null || lead.Programa__c == null ){
					lead.addError('Faltan campos requeridos para la asignación de oferta');
				}else if(lead.Email == null || lead.LastName == null){
					lead.addError('Faltan campos requeridos para el contacto');
				}
			}
		}
	}
	
	
	/**
    * @author:      Rogelio Jimenez
    * @date:        16/05/2016
    * @description: Al prospecto se le asigna un promotor y se actuliza el contador de este último
    * @param:       list<Lead>
    * @return:      
    */
	public void assignOwner(list<Lead> newLeads){
		list<Promotor__c> promotoresUpdate = new list<Promotor__c>();
		map<Id,Promotor__c> mapPromotoresAux = new map<Id,Promotor__c>();
		map<Id,Decimal> mapPromotoresCount = new map<Id,Decimal>();
		for (Lead lead : newLeads){
			Promotor__c promotor = ofeMotorAsignacionCandidatos.lookupForPromotor(lead);
			if(promotor != null){
				lead.Promotor__c = promotor.Id;
				lead.OwnerId = promotor.Promotor__c;
				//promotor.CandidatosAsignados__c++;
				mapPromotoresAux.put(promotor.Id,promotor);
				if(!mapPromotoresCount.containsKey(promotor.Id)){
					mapPromotoresCount.put(promotor.Id,promotor.CandidatosAsignados__c);
				}
				Decimal countAux = mapPromotoresCount.get(promotor.Id) + 1;
				mapPromotoresCount.put(promotor.Id,countAux);
			}
		}
		for(String promotorId:mapPromotoresAux.keySet()){
			Promotor__c proAux = mapPromotoresAux.get(promotorId);
			proAux.CandidatosAsignados__c = mapPromotoresCount.get(promotorId);
			promotoresUpdate.add(proAux);
		}
		update promotoresUpdate;
	}
	
	/**
    * @author:      Rogelio Jimenez
    * @date:        16/05/2016
    * @description: Al prospecto se le asigna un grupo y su oferta académica
    * @param:       list<Lead>
    * @return:      
    */
	public void assignAcademicOffert(list<Lead> newLeads){
		List<Grupo__c> gruposUpdate = new list<Grupo__c>();
		map<Id,Integer> mapGruposLlamados = new map<Id,Integer>();
		map<Lead,OfertaEducativa__c> mapLeadOferta = new map<Lead,OfertaEducativa__c>();
		mapLeadOferta =  ofeMotorAsignacionOferta.obtainAcademicOffer(newLeads);
		System.debug('mapaOfer: ' + mapLeadOferta);
		
		for(Lead lead: newLeads){
			OfertaEducativa__c accademicOffert = mapLeadOferta.get(lead);
			if(accademicOffert != null){
				Grupo__c grupoAsignado = ofeMotorAsignacionOferta.getGroupByAcademicOffer(accademicOffert);
				lead.Periodo__c = accademicOffert.Periodo__c;
				lead.OfertaEducativa__c = accademicOffert.Id;
				lead.GrupoAsignado__c = grupoAsignado.Id;
			}
		}
	}
	
	    /**
    * @author:      Rogelio Jiménez
    * @date:        18/05/2016
    * @description: Verifica la duplicidad del candidato
    * @param:       
    * @return:     
    */
    public void verifyLeadDupicated(list<Lead> newLeads){
    	set<String> keys = new set<String>();
    	map<String,Integer> mapKeyLead = new map<String,Integer>();
    	for (Lead lead : newLeads){
    		keys.add(lead.LlaveCandidato__c);
    	}
    	mapKeyLead = Utils.getMapLeadsByKey(keys);
    	
    	for(Lead lead: newLeads){
    		if(mapKeyLead.containsKey(lead.LlaveCandidato__c)){
    			if(mapKeyLead.get(lead.LlaveCandidato__c) >= Negocio__c.getOrgDefaults().MaximoRepeticionCandidatos__c){
    				lead.addError(Utils.ERROR_LEAD_DUPLICADO);
    			}
    		}
    	}
    }

     /**
    * @author:      Rogelio Jiménez
    * @date:        03/06/2016
    * @description: Aumenta el numero de prospectos inscritos a un frupo
    * @param:       
    * @return:     
    */
    public void agregateLeadtoGroup(list<Lead> newLeads){
    	List<Grupo__c> gruposUpdate = new list<Grupo__c>();
    	map<Id,Integer> mapGruposLlamados = new map<Id,Integer>();
    	for(Lead lead : newLeads){
    		if(lead.GrupoAsignado__c != null){
    			if(mapGruposLlamados.containsKey(lead.GrupoAsignado__c)){
					mapGruposLlamados.put(lead.GrupoAsignado__c, 1);
				}else{
					Integer contador = mapGruposLlamados.get(lead.GrupoAsignado__c) == null ? 0 : mapGruposLlamados.get(lead.GrupoAsignado__c);
					contador++;
					mapGruposLlamados.put(lead.GrupoAsignado__c, contador);
				}
    		}
    	}
    	gruposUpdate = [SELECT Id,Name,ProspectosAsignados__c FROM Grupo__c WHERE Id IN : mapGruposLlamados.keySet()];
		for(Grupo__c grupo :  gruposUpdate){
			Integer prospectosAsignados = grupo.prospectosAsignados__c != null ? Integer.valueOf(grupo.prospectosAsignados__c) : 0;
			prospectosAsignados = prospectosAsignados + mapGruposLlamados.get(grupo.Id);
			grupo.prospectosAsignados__c = prospectosAsignados;
		}
		update gruposUpdate;
    }

    /**
    * @author:      Rogelio Jiménez
    * @date:        03/06/2016
    * @description: Asigna los coneptos de pago correspondientes a lead para la Ficha de pago
    * @param:       
    * @return:     
    */

    public void assignPrices(list<Lead> newLeads){
    	set<Id> idsOferts = new set<Id>();
		map<String,List<OfertaConceptoPagos__c>> mapOfertPaymentConcept=  new map<String,List<OfertaConceptoPagos__c>>();
		map<String,String> mapConceptFieldLead = new map<String,String>();
		for(Lead lead : newLeads){
			if(lead.OfertaEducativa__c != null){
				idsOferts.add(lead.OfertaEducativa__c);
			}
		}
		System.debug('leadOfertasId'+ idsOferts);
		try{
				for (OfertaConceptoPagos__c conceptoPago : [SELECT Id,Monto__c,ConceptoPago__r.Name,OfertaEducativa__c  FROM OfertaConceptoPagos__c 
															WHERE OfertaEducativa__c IN : idsOferts]){
					if(!mapOfertPaymentConcept.containsKey(conceptoPago.OfertaEducativa__c)){
                        List<OfertaConceptoPagos__c> listOfe = new List<OfertaConceptoPagos__c>();
                        listOfe.add(conceptoPago);
						mapOfertPaymentConcept.put(conceptoPago.OfertaEducativa__c, listOfe);
                    }else{
                        mapOfertPaymentConcept.get(conceptoPago.OfertaEducativa__c).add(conceptoPago);
                    }
				}
		}catch(Exception e){
				System.debug('No se encontraron conceptos de pago para alguna de las ofertas: ' + e.getMessage());
		}
        System.debug(Utils.MAP_CONCEPT_FIELD_LEAD);
		for(Lead lead : newLeads){
            if(lead.FichaMovil__c == null){
                if(mapOfertPaymentConcept.containsKey(lead.OfertaEducativa__c)){
                    List<OfertaConceptoPagos__c>  conceptos = mapOfertPaymentConcept.get(lead.OfertaEducativa__c);
                    for(OfertaConceptoPagos__c concepto: conceptos){
                        if(Utils.MAP_CONCEPT_FIELD_LEAD.containsKey(concepto.ConceptoPago__r.Name)){
                            lead.put(Utils.MAP_CONCEPT_FIELD_LEAD.get(concepto.ConceptoPago__r.Name), concepto.Monto__c);                            
                        }
                    }
                }
            }
		}
    }
	
    /**
    * @author:      Salvador Reyna
    * @date:        03/06/2016
    * @description: 
    * @param:       
    * @return:     
    */

    public void createPayToken(list<Lead> newLeads){
        //Lead leadData = [SELECT Folio__c, ImporteTotal__c, FirstName, LastName, ApeMaterno__c, nivel__r.Name, plantel__c FROM Lead WHERE Id =: infoLead.Id];
        //
        List<Catalogo__c> niveles = [SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c = 'Nivel'];
        List<FichaPago__c> tokens = new List<FichaPago__c>();
        for(Lead leadData: newLeads){
            if(leadData.SubOrigenCandidato__c =='Preinscripción'){
                FichaPago__c newToken = new FichaPago__c();
              	newToken.FolioLead__c = Decimal.valueOf(leadData.Folio__c.replace('C-',''));
                newToken.RecibimosDe__c = (leadData.FirstName != null ? leadData.FirstName : '') + ' ' + leadData.LastName + ' ' + (leadData.ApeMaterno__c != null ? leadData.ApeMaterno__c : '');
                newToken.TotaPagar__c = leadData.ImporteTotal__c;
                newToken.TipoFicha__c = 'Nivel';
                String nivelLead = '';
                for(Catalogo__c nivel: niveles){
                    if(nivel.Id == leadData.Nivel__c){
                        nivelLead = nivel.Name;
                    }
                }
                
                System.debug('****************** '+nivelLead);
                if(nivelLead.equals('Doctorado')){
                    newToken.TipoFicha__c = 'Nivel Doctorado';
                }
                newToken.Lead__c = leadData.Id;
                newToken.Hasta__c = leadData.VigenciaDescuento__c;
                newToken.Plantel__c = leadData.plantel__c;
                tokens.add(newToken);
            }
        }
        insert tokens;
    }
    
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        09/06/2016
    * @description: Obtiene el número de folio correspondiente
    * @param:       
    * @return:     
    */
     public void assignFolio(list<Lead> newLeads){
     	Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
    	Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
     	for(Lead lead: newLeads){
     		nextFolio = nextFolio + 1;
     		lead.Folio__c = String.valueOf(nextFolio);
     	}
     	configuracionNegocio.Folio__c = nextFolio;
     	update configuracionNegocio;
     }

  /**
    * @author:      Gerardo Martínez
    * @date:        09/06/2016
    * @description: Al convertir un Lead en Oportunity mapea la ficha de pago del lead en la oportunidad
    * @param:       List<Lead> newLeads
    * @return:     
    */

    public void convertMapingFields(list<Lead> newLeads){

	     set<Id> oppIds =new set<Id>();
	     set<Id> leads = new set<Id>();
		 List<Opportunity> opps = new List<Opportunity>();
		 Map<Id,Lead> leadOpp = new Map<Id,Lead>(); // Map of the converted Contact ID and the Lead Status
		 Map<Id,Id> Opplead = new Map<Id,Id>();
		 List<FichaPago__c> fichasUpdate= new LIST<FichaPago__c>();
	    
	    
	    for(Lead lead : newLeads) {
	        if (lead.IsConverted) {
	            leads.add(lead.Id);
	            leadOpp.put(lead.Id, lead);
	        }
	    }
	    

	    List<FichaPago__c> fichas = [Select Id, Name, Lead__c, Oportunidad__c FROM FichaPago__c WHERE FichaPago__c.Lead__c IN :leads];
	    System.debug(fichas);
	    for(FichaPago__c ficha: fichas){
	        Lead lead = leadOpp.get (ficha.Lead__c);
	        ficha.Oportunidad__c = lead.ConvertedOpportunityId;
	        fichasUpdate.add(ficha);        
	    }
	    
	    if(fichasUpdate.size()>0){
	        upsert fichasUpdate;
	    }
	}
    
    /**
    * @author:      Salvador Reyna
    * @date:        16/06/2016
    * @description: Al convertir un Lead en Oportunity mapea Las solicitudes de beca de un lead en la oportunidad
    * @param:       List<Lead> newLeads
    * @return:     
    */
    public void convertMapingFieldsSolicitudBeca(list<Lead> newLeads){
    set<Id> oppIds =new set<Id>();
    set<Id> leads = new set<Id>();
	List<Opportunity> opps = new List<Opportunity>();
	Map<Id,Lead> leadOpp = new Map<Id,Lead>(); // Map of the converted Contact ID and the Lead Status
	List<SolicitudBeca__C> solicitudesUpdate= new LIST<SolicitudBeca__C>();
	   
	   
	   for(Lead lead : newLeads) {
	       if (lead.IsConverted) {
	           leads.add(lead.Id);
	           leadOpp.put(lead.Id, lead);
	       }
	   }
	   List<SolicitudBeca__C> solicitudesBeca = [Select Id, Name, Lead__c, Oportunidad__c FROM SolicitudBeca__C WHERE Lead__c IN :leads];
	   for(SolicitudBeca__C solicitud: solicitudesBeca){
	       Lead lead = leadOpp.get (solicitud.Lead__c);
	      solicitud.Oportunidad__c = lead.ConvertedOpportunityId;
	      solicitudesUpdate.add(solicitud);
	
	   }
	   
	   if(solicitudesUpdate.size()>0){
	       update solicitudesUpdate;
	   }
	}
	
    /**
   * @author:      Gerardo Martínez
   * @date:        16/06/2016
   * @description: Al convertir un Lead en Oportunity mapea Los descuentos de un lead en la oportunidad
   * @param:       List<Lead> newLeads
   * @return:     
   */

   public void convertMapingFieldsDescuento(list<Lead> newLeads){
    set<Id> oppIds =new set<Id>();
    set<Id> leads = new set<Id>();
	List<Opportunity> opps = new List<Opportunity>();
	Map<Id,Lead> leadOpp = new Map<Id,Lead>(); // Map of the converted Contact ID and the Lead Status
	List<Descuento__c> descuentosUpdate= new LIST<Descuento__c>();
	   
	   
	   for(Lead lead : newLeads) {
	       if (lead.IsConverted) {
	           leads.add(lead.Id);
	           leadOpp.put(lead.Id, lead);
	       }
	   }
	   
	
	   List<Descuento__c> descuentos = [Select Id, Name, Lead__c, Oportunidad__c FROM Descuento__c WHERE Descuento__c.Lead__c IN :leads];
	   
	   for(Descuento__c descuento: descuentos){
	       Lead lead = leadOpp.get (descuento.Lead__c);
	      descuento.Oportunidad__c = lead.ConvertedOpportunityId;
	      descuentosUpdate.add(descuento);
	
	   }
	   
	   if(descuentosUpdate.size()>0){
	       update descuentosUpdate;
	   }
	}
	
	/**
    * @author:      Rogelio Jiménez
    * @date:        14/06/2016
    * @description: Se colocan valores por default para los lead que vienen de webToLead
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
    public list<Lead>  putInformationWebToLead(list<Lead> newLeads){
    	list<Lead> leadWeb = new list<Lead>();
    	for(Lead lead:newLeads){
    		if(lead.LeadSource == 'Marketing' && lead.SubOrigenCandidato__c == 'Verticales IEU (por programa)' && lead.WebToLead__c){
    			leadWeb.add(lead);
    		}
    	}
    	
    	for(Lead lead:leadWeb){
    		//UNIVERSIDAD VIRTUAL
    		lead.Plantel__c = Utils.getCatalogoId('Plantel',lead.W2LPlantel__c);
    		lead.Modalidad__c = Utils.getCatalogoId('Modalidad',lead.W2LModalidad__c);
    		lead.Nivel__c = Utils.getCatalogoId('Nivel',lead.W2LNivel__c);
    		lead.Programa__c =  Utils.getProgramByRVOE(lead.Modalidad__c,lead.Nivel__c,lead.Plantel__c,lead.W2LPrograma__c);
    		lead.AsignacionAutomatica__c = true;
    	}
    	//assignOwner(leadWeb);
    	return leadWeb;
    	
    }
    /**
    * @author:      Rogelio Jiménez
    * @date:        27/06/2016
    * @description: Verifica el envío a Google Analitycs
    * @param:       List<Lead> newLeads
    * @return:     
    */
    public void sendToGA(list<Lead> newLeads){
    	list<Lead>leadsToSend = new list<Lead>();
    	for(Lead lead : newLeads){
    		if((lead.Status	!= oldMap.get(lead.Id).Status || lead.Plantel__c != oldMap.get(lead.Id).Plantel__c) && lead.GACID__c != null ){
    			leadsToSend.add(lead);
    		}
    	}
       if(leadsToSend.size() > 0){
	       GA_Queueable ga = new GA_Queueable(leadsToSend);
	       ID jobID = System.enqueueJob(ga);
	       Utils.createLogOK('sendToGA','',String.valueOf(jobID),0);
	       System.debug('ID trabajo envio GA: ' + jobID);
       }
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        27/06/2016
    * @description: Verifica el cambio en los campos para poder ser envaidos en Batch del ERP Master
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
    public void sendToERP(list<Lead> newLeads,map<Id,Lead> oldMap){
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Lead')){
    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Lead')){
    			for(Lead lead: newLeads){
	    			if(lead.get(field) != oldMap.get(lead.Id).get(field)){
	    				lead.ModificadoERP__c = true;
	    				break;
	    			}
    			}
    		}
    	}
    }
     
}