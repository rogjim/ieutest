@RestResource(urlMapping='/OfertaEducativaService/*')
global with sharing class LNP_OfertaEducativaService {
    @HttpGet
    global static void getList() {
        RestContext.response.addHeader('Content-Type', 'application/json');
        String pageRef = RestContext.request.params.get('page');
        String nivel = RestContext.request.params.get('nivel');
        String ofe = RestContext.request.params.get('ofe');
        String modalidad = RestContext.request.params.get('modalidad');
        String plantel = RestContext.request.params.get('plantel');
        String respuesta = 'ERROR';
        //Ubicacion
        String pais_input = RestContext.request.params.get('paisInput');
        String pais = RestContext.request.params.get('pais');
        String Estado = RestContext.request.params.get('estado');
        
        if(pageRef == '1'){
            if((modalidad != null && modalidad != '0') && (nivel == null || String.isEmpty(nivel) )){
                respuesta = getNiveles(modalidad);
            }else if((nivel != null && nivel != '0') && (plantel == null || String.isEmpty(plantel))){
                respuesta = getPlantel(nivel, modalidad);
            }else if(plantel != null && plantel != '0'){
                respuesta = getPrograma(nivel, modalidad, plantel);
            }
        }else if(pageRef == '0'){
            /*if(ofe != null && ofe != '0' && !String.isEmpty(ofe)){
                respuesta = getDataOfert(ofe, modalidad);
            }else */
            if((modalidad != null && modalidad != '0') && (nivel == null || String.isEmpty(nivel) )){
                respuesta = getNiveles(modalidad);
            }else if(nivel != null && nivel != '0'){
                respuesta = getPrograma(nivel, modalidad,'');
            }            
        }
        else if(pageRef == '2'){
            if((pais != null && pais != '0') && (estado == null || String.isEmpty(estado) )){
                respuesta = getEstados(pais);
            }
            else if((estado != null && estado != '0')){
                respuesta = getMunicipios(pais, estado);
            }
            else if((pais_input.equals('pais')) && (pais == null)){
                respuesta = getPaises();
            }
            
        }
        RestContext.response.responseBody = Blob.valueOf(respuesta);
    }
    
    global static String getNiveles(String modalidad){
    	String sqlModalidad = '';
    	String respuesta = '\"0\" : \"-Seleccione Grado-\",';
        String queryTipoModalidad = 'SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c = \'Modalidad\' ORDER BY Name';
        List<Catalogo__c> listTipoModalidad = (List<Catalogo__c>) Database.query(queryTipoModalidad);
        
		String query = 'SELECT Id,Name FROM Periodo__c WHERE Activo__c = \'Activo\' ';
        if(modalidad.equals(listTipoModalidad[2].Id)){
            query += 'AND ActivoPresencial__c = true';
        }else if(modalidad.equals(listTipoModalidad[1].Id)){
            query += 'AND ActivoOnline__c = true';
        }else if(modalidad.equals(listTipoModalidad[0].Id)){
            query += 'AND ActivoEjecutiva__c = true';
        }
        else{
            query = '';
        }
        
    	try{
        	List<Periodo__c> listPeriod= (List<Periodo__c>) Database.query(query);
        	Periodo__c periodo = listPeriod[0];
	        if(periodo != null){
	        	AggregateResult[] groupedResults = [SELECT Nivel__r.Name label,Nivel__c key 
                                                    FROM OfertaEducativa__c 
                                                    WHERE Periodo__c =: periodo.Id
                                                    	AND (Nivel__r.Name = 'Licenciatura' OR  Nivel__r.Name = 'Maestría' OR Nivel__r.Name = 'Doctorado')
                                                    	AND Estatus__c = 'Activo'
                                                    	AND Modalidad__c =: modalidad
                                                    GROUP BY  Nivel__r.Name,Nivel__c ];
	        	for (AggregateResult ar : groupedResults)  {
	        		respuesta += '"' + ar.get('key') + '" : "' +  ar.get('label') + '",';
	        	}
	        }
    	}catch(Exception e ){
    		respuesta = 'ERROR: ' + e.getMessage() + ' .Query: ' + query;
    	}
        respuesta = respuesta.removeEnd(',');
    	return '{' + respuesta +'}';
    }
    
    global static String getPrograma(String nivel, String modalidad, String plantel){
    	String sqlnivel = '';
    	String respuesta = '\"0\" : \"-Oferta Académica-\",';
        String queryTipoModalidad = 'SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c = \'Modalidad\' ORDER BY Name';
        List<Catalogo__c> listTipoModalidad = (List<Catalogo__c>) Database.query(queryTipoModalidad);
        String queryPlantel = 'SELECT id FROM Plantel__c WHERE Name=\'UNIVERSIDAD VIRTUAL\'';
        List<Plantel__c> listPlantel = (List<Plantel__c>) Database.query(queryPlantel);
        
        String query = 'SELECT Id,Name FROM Periodo__c WHERE Activo__c = \'Activo\' ';
        if(modalidad.equals(listTipoModalidad[2].Id)){
            query += 'AND ActivoPresencial__c = true';
        }else if(modalidad.equals(listTipoModalidad[1].Id)){
            query += 'AND ActivoOnline__c = true';
        }else if(modalidad.equals(listTipoModalidad[0].Id)){
            query += 'AND ActivoEjecutiva__c = true';
        }
        else{
            query = '';
        }
        
    	try{
        	List<SObject> listPeriod= (List<SObject>) Database.query(query);
        	SObject periodo = listPeriod[0];
            if(periodo != null){
                List<OfertaEducativa__c> listPeriod2;
                if(!String.isEmpty(plantel)){
                    listPeriod2 = (List<OfertaEducativa__c>) Database.query('SELECT Id, Programa__c, Programa__r.Name FROM OfertaEducativa__c WHERE Periodo__c = \''+ periodo.Id + '\' AND Nivel__c = \''+nivel+ '\' AND Modalidad__c =\''+ modalidad+ '\' AND Plantel__c =\''+ plantel+ '\' AND Estatus__c = \'Activo\' ORDER BY Programa__r.Name ASC');
                    for (OfertaEducativa__c ar : listPeriod2){                    
                        respuesta += '"' + ar.Id+ '" : "' +  ar.Programa__r.Name + '",';
                    }
                }else{
                    listPeriod2 = (List<OfertaEducativa__c>) Database.query('SELECT Id, Programa__r.Name FROM OfertaEducativa__c WHERE Periodo__c = \''+ periodo.Id + '\' AND Nivel__c = \''+nivel+ '\' AND Modalidad__c =\''+ listTipoModalidad[1].Id +'\' AND Plantel__c=\''+ listPlantel[0].id +'\' AND Estatus__c = \'Activo\' ORDER BY Programa__r.Name ASC');
                    for (OfertaEducativa__c ar : listPeriod2){                    
                        respuesta += '"' + ar.Id + '" : "' +  ar.Programa__r.Name + '",';
                    }
                }
	        }
    	}catch(Exception e ){
    		respuesta = 'ERROR: ' + e.getMessage() + ' .Query: ' + query;
    	}
        respuesta = respuesta.removeEnd(',');
    	return '{' + respuesta +'}';
    }
    
    global static String getPlantel(String nivel, String modalidad){
        String sqlnivel = '';
        String respuesta = '\"0\" : \"-Plantel educativo-\",';
        String queryTipoModalidad = 'SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c = \'Modalidad\' ORDER BY Name';
        List<Catalogo__c> listTipoModalidad = (List<Catalogo__c>) Database.query(queryTipoModalidad);
        
        String query = 'SELECT Id,Name FROM Periodo__c WHERE Activo__c = \'Activo\' ';
        if(modalidad.equals(listTipoModalidad[2].Id)){
            query += 'AND ActivoPresencial__c = true';
        }else if(modalidad.equals(listTipoModalidad[1].Id)){
            query += 'AND ActivoOnline__c = true';
        }else if(modalidad.equals(listTipoModalidad[0].Id)){
            query += 'AND ActivoEjecutiva__c = true';
        }
        else{
            query = '';
        }
        
        try{
            List<SObject> listPeriod= (List<SObject>) Database.query(query);
            SObject periodo = listPeriod[0];
            if(periodo != null){
                List<OfertaEducativa__c> listPeriod2 = (List<OfertaEducativa__c>) Database.query('SELECT Id, Plantel__c, Plantel__r.Name FROM OfertaEducativa__c WHERE Periodo__c = \''+ periodo.Id + '\' AND Nivel__c = \''+nivel+ '\' AND Modalidad__c =\''+ modalidad+ '\' AND Estatus__c = \'Activo\' ORDER BY Plantel__r.Name ASC');
                System.debug(listPeriod2);
                for (OfertaEducativa__c ar : listPeriod2){                    
                    respuesta += '"' + ar.Plantel__c + '" : "' +  ar.Plantel__r.Name + '",';
                }
            }
        }catch(Exception e ){
            respuesta = 'ERROR: ' + e.getMessage() + ' .Query: ' + query;
        }
        respuesta = respuesta.removeEnd(',');
        return '{' + respuesta +'}';
        
    }
    
    /*----------------------Ubicacion--------------------------*/
    global static String getPaises(){
        String respuesta = '\"0\" : \"--Seleccionar--\",';
        String query = 'SELECT IdUbicacion__c, Name FROM Ubicacion__c WHERE TipoUbicacion__c= \'País\' ORDER BY Name';
        try{
            List<Ubicacion__c> listPaises= (List<Ubicacion__c>) Database.query(query);
            if(listPaises.size() != 0){
                for (Ubicacion__c pa : listPaises){                    
                    respuesta += '"' + pa.IdUbicacion__c + '" : "' +  pa.Name + '",';
                }
            }
        }catch(Exception e ){
            respuesta = 'ERROR: ' + e.getMessage() + ' .Query: ' + query;
        }
        respuesta = respuesta.removeEnd(',');
        return '{'+ respuesta +'}';
    }
    
    global static String getEstados(String pais){
        String respuesta = '\"0\" : \"--Seleccionar--\",';
        String query = 'SELECT IdUbicacion__c, Name FROM Ubicacion__c WHERE TipoUbicacion__c= \'Estado\' AND IdEstadoPais__c = \''+pais+'\' ORDER BY Name';
        try{
            if(pais.equals('157')){
                List<Ubicacion__c> listEstados= (List<Ubicacion__c>) Database.query(query);
                if(listEstados.size() != 0){
                    for (Ubicacion__c es : listEstados){                    
                        respuesta += '"' + es.IdUbicacion__c + '" : "' +  es.Name + '",';
                    }
                }
            }
            else{
                respuesta = '\"-1\" : \"--No aplica--\",';
            }
        }catch(Exception e ){
            respuesta = 'ERROR: ' + e.getMessage() + ' .Query: ' + query;
        }
        respuesta = respuesta.removeEnd(',');
        return '{'+ respuesta +'}';
    }
    global static String getMunicipios(String pais, String estado){
        String respuesta = '\"0\" : \"--Seleccionar--\",';
        String query = 'SELECT IdUbicacion__c, Name FROM Ubicacion__c WHERE TipoUbicacion__c= \'Municipio\' AND IdEstadoPais__c = \''+estado+'\' ORDER BY Name';
        try{
            if(pais.equals('157')){
                List<Ubicacion__c> listMuicipios= (List<Ubicacion__c>) Database.query(query);
                if(listMuicipios.size() != 0){
                    for (Ubicacion__c mun : listMuicipios){                    
                        respuesta += '"' + mun.IdUbicacion__c + '" : "' +  mun.Name + '",';
                    }
                }
            }
            else{
                respuesta = '\"-1\" : \"--No Disponible--\",';
            }
        }catch(Exception e ){
            respuesta = 'ERROR: ' + e.getMessage() + ' .Query: ' + query;
        }
        respuesta = respuesta.removeEnd(',');
        return '{'+ respuesta +'}';
    }
    
    public class WrapperOferta{
        public Periodo__c periodo {get; set;}
        public String grupo {get; set;}
        public List<String> conceptos {get; set;}
        public List<String> becas {get; set;}
        
        public WrapperOferta(){
            
        }
    }
}