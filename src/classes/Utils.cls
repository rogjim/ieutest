public with sharing class Utils {
    
    public final static String MODALIDAD_EJECUTIVA = 'Ejecutiva';
    public final static String MODALIDAD_ONLINE = 'Online';
    public final static String MODALIDAD_PRESENCIAL = 'Presencial';
    public final static String ERROR_LEAD_DUPLICADO = 'Ya ha registrado el correo, para la modalidad y carrera seleccionada.';
    public final static String ERROR_PERIODO_SIN_GRUPOS = 'El periodo no puede ser activado sin una oferta académica con un grupo asignado.';
    
    public  enum Estatus {CORRECTO, ERROR}
    /**
    * @author:      Rogelio Jiménez
    * @date:        03/16/2016
    * @description: Regresa una lista con los nombres de los campos del objeto especificado
    * @param:       Schema.SObjectType targetObject
    * @return:      List<String>
    */
    public static List<String> getListCampos(Schema.SObjectType targetObject){
        List<String> listCampos = new List<String>();
        Set<String> setCamposParaExcluir = new Set<String>{'CreatedById', 'CreatedDate', 'SystemModstamp', 'LastModifiedDate', 'LastModifiedById', 'LastReferencedDate', 'LastViewedDate', 'IsDeleted'};


        List<Schema.sObjectField> lSobjectFields = targetObject.getDescribe().fields.getMap().values();
        for(Schema.sObjectField sob : lSobjectFields){
      
            Schema.DescribeFieldResult f = sob.getDescribe();
            //NO agregar campos que no se necesitan
            String nombreCampo = f.getName();
            if(!setCamposParaExcluir.contains(nombreCampo)) listCampos.add(nombreCampo);
        }
        return listCampos;
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        03/16/2016
    * @description: Regresa una cadena con los nombres de los campos de un objeto especificado separados por coma
    * @param:       Schema.SObjectType targetObject
    * @return:      String
    */
    public static String getStrCampos(Schema.SObjectType targetObject){
        return String.join(getListCampos(targetObject), ', ');
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        06/05/2016
    * @description: Obtiene todos los promotores por plantel
    * @param:       
    * @return:      map<Id,list<Promotor__c>>
    */
     public static map<Id,list<Promotor__c>> MAP_PROMOTORES_BY_PLANTEL{ 
    	get{
            if(MAP_PROMOTORES_BY_PLANTEL == null){
                     MAP_PROMOTORES_BY_PLANTEL = new map<Id,list<Promotor__c>>();
                     String query = 'SELECT ' + getStrCampos(Promotor__c.SObjectType) + 
                       ' FROM Promotor__c WHERE Activo__c = true ORDER BY OrdenNumerico__c ASC, CandidatosAsignados__c DESC ';
				     List<Promotor__c> listPromotores = (List<Promotor__c>) Database.query(query);
				        
			        for(Promotor__c promotor :listPromotores){
			            if(!MAP_PROMOTORES_BY_PLANTEL.containsKey(promotor.Plantel__c)){
			                MAP_PROMOTORES_BY_PLANTEL.put(promotor.Plantel__c, new list<Promotor__c>());
			            }
			            MAP_PROMOTORES_BY_PLANTEL.get(promotor.Plantel__c).add(promotor);
			        }
                     
                }
              return MAP_PROMOTORES_BY_PLANTEL;
            }
        set;
    }
    
    public static map<Id,list<Promotor__c>> getPromotoresByPlantel(){
        map<Id,List<Promotor__c>> mapPromotoresByPlantel = new map<Id,List<Promotor__c>>();
        String query = 'SELECT ' + getStrCampos(Promotor__c.SObjectType) + 
                       ' FROM Promotor__c WHERE Activo__c = true ORDER BY OrdenNumerico__c ASC, CandidatosAsignados__c DESC ';
        List<Promotor__c> listPromotores = (List<Promotor__c>) Database.query(query);
        
        for(Promotor__c promotor :listPromotores){
            if(!mapPromotoresByPlantel.containsKey(promotor.Plantel__c)){
                mapPromotoresByPlantel.put(promotor.Plantel__c, new list<Promotor__c>());
            }
            mapPromotoresByPlantel.get(promotor.Plantel__c).add(promotor);
        }
        return mapPromotoresByPlantel;
    }
    
    
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        16/05/2016
    * @description: 
    * @param:       
    * @return:      map<Id,OfertaEducativa__c>
    */
     public static map<Id,OfertaEducativa__c> getAccademicOfertByPeriodo(Periodo__c period){
        map<Id,OfertaEducativa__c> mapAccademicOffertByPeriodo = new map<Id,OfertaEducativa__c>();
        if(period!= null){
            mapAccademicOffertByPeriodo = new Map<Id, OfertaEducativa__c>([SELECT id,Name,Grupo__c 
                                                        FROM OfertaEducativa__c WHERE Periodo__c =: period.Id]);
        }
        return mapAccademicOffertByPeriodo;
     }
     
    
 
     
     /**
    * @author:      Rogelio Jiménez
    * @date:        16/05/2016
    * @description: 
    * @param:       Lead
    * @return:      Catalogo__c
    */
     public static map<String,Catalogo__c> MAP_MODALIDAD{ 
    	get{
            if(MAP_MODALIDAD == null){
                    MAP_MODALIDAD = new map<String,Catalogo__c>();
                     for(Catalogo__c catalog: [SELECT id,Name FROM Catalogo__c WHERE TipoCatalogo__c =: 'Modalidad']){
		                MAP_MODALIDAD.put(catalog.Name, catalog);
		            }
                }
              return MAP_MODALIDAD;
            }
        set;
    }
     public static Catalogo__c getModalidad(Lead lead){
            Catalogo__c catalogModalidad = null;
            
            
            if(lead.ModalidadPresencial__c && MAP_MODALIDAD.containsKey(Utils.MODALIDAD_PRESENCIAL)){
                catalogModalidad = MAP_MODALIDAD.get(Utils.MODALIDAD_PRESENCIAL);
            }else if(lead.ModalidadOnline__c && MAP_MODALIDAD.containsKey(Utils.MODALIDAD_ONLINE)){
                catalogModalidad = MAP_MODALIDAD.get(Utils.MODALIDAD_ONLINE);
            }else if(lead.ModalidadEjecutiva__c && MAP_MODALIDAD.containsKey(Utils.MODALIDAD_EJECUTIVA)){
                catalogModalidad = MAP_MODALIDAD.get(Utils.MODALIDAD_EJECUTIVA);
            }else{
                catalogModalidad = MAP_MODALIDAD.get(Utils.MODALIDAD_ONLINE);
            }
        return catalogModalidad;
     }
     
    /**
    * @author:      Rogelio Jiménez
    * @date:        06/05/2016
    * @description: Obtiene la url de la fotografia correspondiente del promotor
    * @param:       
    * @return:      map<Id,list<Promotor__c>>
    */
    public static void  assignPictureProfileUrl(set<Id> idUsers , list<Promotor__c> newList){
        map<Id, User> mapUser = new Map<Id, User>([SELECT id,Name,FullPhotoUrl,SmallPhotoUrl FROM User WHERE Id IN : idUsers]);
        for(Promotor__c promotor : newList){
            if(mapUser.containsKey(promotor.Promotor__c)){
                ConnectApi.Photo ph =  ConnectApi.ChatterUsers.getPhoto(null, promotor.Promotor__c);
                promotor.UrlFotoGrande__c = ph.fullEmailPhotoUrl;
                promotor.UrlFotoPequena__c = ph.smallPhotoUrl;
            }
        }
    }
    
    public static map<String,Integer> getMapLeadsByKey(set<String> keys){
        map<String,Integer> mapLeadByKey = new map<String,Integer>();
        AggregateResult[] leadResults = [SELECT COUNT(Id) accountant, LlaveCandidato__c key FROM Lead WHERE LlaveCandidato__c IN : keys  GROUP BY LlaveCandidato__c];
        for(AggregateResult ar: leadResults){
            if(!mapLeadByKey.containsKey(String.valueOf(ar.get('key')))){
                mapLeadByKey.put(String.valueOf(ar.get('key')), Integer.valueOf(ar.get('accountant')));
            }
        }
        return mapLeadByKey;
    }
    
   
    
    public static String nullToEmpty(String value){
        if(value == null || value == 'null' || value == 'NULL')
            return '';
        else
            return value;
    }
    
    /**
    * @author:      Salvador Reyna
    * @date:        27/05/2016
    * @description: Devuelve la referencia de Pago HSBC
    * @param:       
    * @return:      String
    */
    public static String getHSBCReference(String folio, String fechaCond, String constante, String pago){
        String referenceHSBC = folio + fechaCond;
        List<Integer> ponderado = new List<Integer>{7,3,1};
        List<Integer> ponderado2 = new List<Integer>{11,13,17,19,23};
        String payRefe = pago.replace('.', '');
        List<String> payArray = payRefe.split('');
        Decimal condensed = 0;
        Integer itj = 0;
        
        for(Integer i = payArray.size()-1; i>0; i--){
            condensed += (Integer.valueOf(payArray[i]) * ponderado[itj]);
            itj ++;
            if(itj > 2){
                itj = 0;
            }
        }
        Decimal divCond = condensed.Divide(10,1);
        List<String> valueM = String.valueOf(divCond).split('');
        referenceHSBC += '' +  valueM[valueM.size()-1] + constante;
        List<String> arrayHSBC = referenceHSBC.split('');
        
        Integer condensed2 = 0;
        itj = 0;
        for(Integer i = arrayHSBC.size()-1; i>0; i--){
            condensed2 += (Integer.valueOf(arrayHSBC[i]) * ponderado2[itj]);
             itj ++;
            if(itj > 4){
                itj = 0;
            }
        }
        Integer divFinal = Math.mod(condensed2,97) +1;
        referenceHSBC += '' + String.valueOf(divFinal);
        return referenceHSBC;
    }
    
    /**
    * @author:      Salvador Reyna
    * @date:        27/05/2016
    * @description: Devuelve la referencia de Pago OXXO
    * @param:       
    * @return:      String
    */
    
    public static String getOXXOReference(String cadenaCodigo){
        if(cadenaCodigo.contains('.')){
            cadenaCodigo = cadenaCodigo.replace('.','');
            cadenaCodigo += '0';
        }else{  
        }
        List<Integer> ponderado = new List<Integer>{2,1};
        List<String> arrayCode = cadenaCodigo.split('');
        Integer condensed = 0;
        Integer itj = 0;
        for(Integer i = arrayCode.size()-1; i > 0; i--){
            System.debug(arrayCode[i]);
            Integer valueStep = Integer.valueOf(arrayCode[i]) * ponderado[itj];
            if(valueStep > 9){
                String stringStep = String.valueOf(valueStep);
                List<String> listStep = stringStep.split('');
                System.debug(listStep);
                valueStep = Integer.valueOf(listStep[1]) + Integer.valueOf(listStep[2]);
            }
            
            condensed += valueStep;
            itj ++;
            if(itj > 1){
                itj = 0;
            }
        }
        Integer divFinal = Math.mod(condensed,10);
        if(divFinal == 0){
            cadenaCodigo += String.valueOf(divFinal);
        }else{
            Integer divFinalValue = divFinal -10;
            cadenaCodigo += String.valueOf(divFinalValue * -1);
        }
        System.debug(cadenaCodigo);
        return cadenaCodigo;
    }

    /**
    * @author:      Rogelio Jiménez
    * @date:        27/05/2016
    * @description: Map con campos de conceptos de pago del Lead
    * @param:       
    * @return:      map<String, String>
    */

    public static map<String,String> MAP_CONCEPT_FIELD_LEAD{
        get{
            if(MAP_CONCEPT_FIELD_LEAD == null){
                    MAP_CONCEPT_FIELD_LEAD = new map<String,String>();
                    for(Catalogo__c catalog : [SELECT Id,Name,NombreCampoCandidato__c FROM Catalogo__c WHERE TipoCatalogo__c =: 'Concepto Pagos']){
                        MAP_CONCEPT_FIELD_LEAD.put(catalog.Name,catalog.NombreCampoCandidato__c);
                    }
                }
              return MAP_CONCEPT_FIELD_LEAD;
            }
        set;
    }
    /*
    	Mapas de catalogos
    */
    
     public static map<String,Catalogo__c> MAP_CATALOGO_NIVEL{
        get{
            if(MAP_CATALOGO_NIVEL == null){
                    MAP_CATALOGO_NIVEL = new map<String,Catalogo__c>();
                    for(Catalogo__c catalog : [SELECT Id,Name,NombreCampoCandidato__c FROM Catalogo__c WHERE TipoCatalogo__c =: 'Nivel']){
                        MAP_CATALOGO_NIVEL.put(catalog.Name,catalog);
                    }
                }
              return MAP_CATALOGO_NIVEL;
            }
        set;
    }
    
       public static map<String,Catalogo__c> MAP_CATALOGO_MODALIDAD{
        get{
            if(MAP_CATALOGO_MODALIDAD == null){
                    MAP_CATALOGO_MODALIDAD = new map<String,Catalogo__c>();
                    for(Catalogo__c catalog : [SELECT Id,Name,NombreCampoCandidato__c FROM Catalogo__c WHERE TipoCatalogo__c =: 'Modalidad']){
                        MAP_CATALOGO_MODALIDAD.put(catalog.Name,catalog);
                    }
                }
              return MAP_CATALOGO_MODALIDAD;
            }
        set;
    }
    
     
       public static map<String,Plantel__c> MAP_PLANTEL{
        get{
            if(MAP_PLANTEL == null){
                    MAP_PLANTEL = new map<String,Plantel__c>();
                    for(Plantel__c plantel : [SELECT Id, Name FROM Plantel__c]){
                        MAP_PLANTEL.put(plantel.Name,plantel);
                    }
                }
              return MAP_PLANTEL;
            }
        set;
    }
    
      public static map<String,Programa__c> MAP_PROGRAMA{
        get{
            if(MAP_PROGRAMA == null){
                    MAP_PROGRAMA = new map<String,Programa__c>();
                    for(Programa__c plantel : [SELECT Id, Name FROM Programa__c]){
                        MAP_PROGRAMA.put(plantel.Name,plantel);
                    }
                }
              return MAP_PROGRAMA;
            }
        set;
    }
    
    public static String getCatalogoId(String tipo, String valor){
    	String id = null;
    	try{
	    	if(tipo == 'Nivel'){
				Catalogo__c catalogo = MAP_CATALOGO_NIVEL.get(valor);
				id = catalogo.Id;   		
	    	}else if(tipo == 'Modalidad'){
	    		Catalogo__c catalogo = MAP_CATALOGO_MODALIDAD.get(valor);
	    		id = catalogo.Id;   
	    	}else if(tipo == 'Plantel'){
	    		Plantel__c plantel = MAP_PLANTEL.get(valor);
	    		id = plantel.Id;
	    	}else if(tipo == 'Programa'){
	    		Programa__c programa = MAP_PROGRAMA.get(valor);
	    		id = programa.Id;
	    	}
    	}catch(Exception e){
    		System.debug('No se encontró información para el tipo: ' + tipo + ' con el valor: ' + valor);
    	}
    	return id;
    }
    
     /**
    * @author:      Rogelio Jiménez
    * @date:        20/06/2016
    * @description: Utiletias para crear registros en el objeto LogIntegracion
    * @param:       
    * @return:      
    */
    
     // Se mueven métodos a UtilsLog.cls -calvarez
    public static void createLog(Estatus estatus,String metodo, String enviado, String respuesta){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = String.valueOf(estatus), Metodo__c = metodo,
    												 EnvioWS__c = enviado,RespuestaWS__c = respuesta);
    	insert log;
    }
    
    public static void createLogOK(String metodo,String respuesta){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'CORRECTO', Metodo__c = metodo,RespuestaWS__c = respuesta);
    	insert log;
    }
    
    public static void createLogError(String metodo,String enviado, String respuesta){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'ERROR', Metodo__c = metodo,EnvioWS__c = enviado,RespuestaWS__c = respuesta);
    	insert log;
    }
    
    public static void createLogOK(String metodo,String respuesta, String jobId, Integer elements){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'CORRECTO', Metodo__c = metodo,RespuestaWS__c = respuesta, ApexJobId__c = jobId, NumeroRegistros__c = elements);
    	insert log;
    }
    
    public static void createLogError(String metodo,String enviado, String respuesta, String jobId, Integer elements){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'ERROR', Metodo__c = metodo,EnvioWS__c = enviado,RespuestaWS__c = respuesta, ApexJobId__c = jobId, NumeroRegistros__c = elements);
    	insert log;
    }
    
     /**
    * @author:      Rogelio Jiménez
    * @date:        22/06/2016
    * @description: Regresa el programa buscando en el RVOE
    * @param:       
    * @return:      
    */
   
   public static Id getProgramByRVOE(String idModalidad, String idNivel, String idPlantel, String programa){
   	Id idPrograma = null;
   		try{
   			RVOE__c rvoe = [SELECT Id,Name, Programa__c,Programa__r.Name FROM RVOE__c 
   							WHERE Modalidad__c =: idModalidad AND Nivel__c =: idNivel AND Plantel__c =: idPlantel AND Programa__r.Name =: programa LIMIT 1];
   			idPrograma =  rvoe.programa__c;
   		}catch(Exception e){
   			System.debug('No hay REvoe para los parametros enviados:' + e.getMessage());
   		}
   	return IdPrograma;
   }
   
   public static string encodeQueryParam(String paramName , String paramVal){
   		return paramName + '=' + EncodingUtil.urlEncode(paramVal, 'UTF-8');
   }
   
    /**
    * @author:      Rogelio Jiménez
    * @date:        28/06/2016
    * @description: Regresa un mapa con el objeto y campos que estamos buscanod cambios, se lee de la configuracion personalizada "Configuración personalizada"
    * @param:       
    * @return:      
    */
    
    public static map<String,list<String>> MAP_OBJECT_FIELDS{ 
    	get{
            if(MAP_OBJECT_FIELDS == null){
                    MAP_OBJECT_FIELDS = new map<String,list<String>>();
                    for(ConfiguracionObjetoCambio__c configuracion : ConfiguracionObjetoCambio__c.getAll().values()){
                       if(!MAP_OBJECT_FIELDS.containsKey(configuracion.Objeto__c)){
                       		MAP_OBJECT_FIELDS.put(configuracion.Objeto__c,new list<String>());
                       }
                       MAP_OBJECT_FIELDS.get(configuracion.Objeto__c).add(configuracion.Campo__c);
                    }
                }
              return MAP_OBJECT_FIELDS;
            }
        set;
    }
}