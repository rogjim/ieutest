global class UtilsExternal {
	/**
    * @author:      Salvador Reyna
    * @date:        28/06/2016
    * @description: 
    * @param:       
    * @return:      
    */
    public Id idLead {get;set;}
    public String email {get;set;}
    
    @RemoteAction
    global static ComboWrapper getExternalOfertaAcademica(){
        List<OfertaEducativa__c> listOffer = [SELECT Id, Modalidad__c, Modalidad__r.Name,
                                        		Nivel__c, Nivel__r.Name,
                                        		Plantel__c, Plantel__r.Name,
                                        		Programa__c, Programa__r.Name,
                                                Periodo__r.ActivoEjecutiva__c, 
                                                Periodo__r.ActivoOnline__c, 
                                                Periodo__r.ActivoPresencial__c
                                        		FROM OfertaEducativa__c WHERE 
                                         		Periodo__r.Activo__c = 'Activo' 
                                         		AND (Nivel__r.Name = 'Licenciatura' 
                                                OR Nivel__r.Name = 'Maestría' 
                                                OR Nivel__r.Name = 'Doctorado')
                                                AND (Periodo__r.ActivoEjecutiva__c = true OR 
                                                Periodo__r.ActivoOnline__c = true OR 
                                                Periodo__r.ActivoPresencial__c = true)];
        
        ItemWrapper itemModalidad = new ItemWrapper('Modalidad');
        ItemWrapper itemNivel = new ItemWrapper('Nivel');
        ItemWrapper itemPlantel = new ItemWrapper('Plantel');
        ItemWrapper itemPrograma = new ItemWrapper('Programa');
        
        String modalidadBussy = '';
        String nivelBussy = '';
        String plantelBussy = '';
        String programaBussy = '';
        for(OfertaEducativa__c offer: listOffer){
            InfoWrapper infoModalidad = new infoWrapper();
            InfoWrapper infoNivel = new infoWrapper();
            InfoWrapper infoPlantel = new infoWrapper();
            InfoWrapper infoPrograma = new infoWrapper();
            
            if(((offer.Modalidad__r.Name).equals('Online') && offer.Periodo__r.ActivoOnline__c == true) ||
               ((offer.Modalidad__r.Name).equals('Ejecutiva') && offer.Periodo__r.ActivoEjecutiva__c == true) ||
               ((offer.Modalidad__r.Name).equals('Presencial') && offer.Periodo__r.ActivoPresencial__c == true)){
                   //Informacion de la modalidad
                   infoModalidad.dataId = offer.Modalidad__c;
                   infoModalidad.name = offer.Modalidad__r.Name;
                   //Información del nivel
                   infoNivel.dataId = String.valueOf(offer.Nivel__c) + '-' +String.valueOf(offer.Modalidad__c);
                   infoNivel.name = offer.Nivel__r.Name;
                   infoNivel.parent = offer.Modalidad__c;
                   //Información del Plantel
                   infoPlantel.dataId = String.valueOf(offer.Plantel__c) + '-' + String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   infoPlantel.name = offer.Plantel__r.Name;
                   infoPlantel.parent = String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   //Información del Programa
                   infoPrograma.dataId =  String.valueOf(offer.Id) + '-' +String.valueOf(offer.Programa__c) + '-' + String.valueOf(offer.Plantel__c) + '-' + String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   infoPrograma.name = offer.Programa__r.Name;
                   infoPrograma.parent = String.valueOf(offer.Plantel__c) + '-' + String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   
                   if(!modalidadBussy.contains(offer.Modalidad__c)){
                       itemModalidad.items.add(infoModalidad);
                       modalidadBussy += '-' + offer.Modalidad__c;
                   }
                   
                   String toNivel = String.valueOf(offer.Nivel__c) + String.valueOf(offer.Modalidad__c);
                   if(!nivelBussy.contains(toNivel)){
                       itemNivel.items.add(infoNivel);
                       nivelBussy += '-' + offer.Nivel__c + offer.Modalidad__c;
                   }
                   
                   String toPlantel = String.valueOf(offer.Plantel__c) + String.valueOf(offer.Nivel__c) + String.valueOf(offer.Modalidad__c);
                   if(!plantelBussy.contains(toPlantel)){
                       itemPlantel.items.add(infoPlantel);
                       plantelBussy += '-' + offer.Plantel__c + offer.Nivel__c + offer.Modalidad__c;
                   }
                   
                   String toPrograma = String.valueOf(offer.Programa__c) + String.valueOf(offer.Plantel__c) + String.valueOf(offer.Nivel__c) + String.valueOf(offer.Modalidad__c);
                   if(!programaBussy.contains(toPrograma)){
                       itemPrograma.items.add(infoPrograma);
                       programaBussy += '-' + offer.Programa__c + offer.Plantel__c + offer.Nivel__c + offer.Modalidad__c;
                   }
               }
        }
        ComboWrapper cw = new ComboWrapper();
		cw.modalidad = itemModalidad;
        cw.nivel = itemNivel;
        cw.plantel = itemPlantel;
        cw.programa = itemPrograma;
        return cw;
    }

	/**
    * @author:      Gabriel Garcia
    * @date:        04/07/2016
    * @description: Método para obtener los cátalogos de ubicación
    * @param:       
    * @return:      
    */
    @RemoteAction
    global static Map<String, List<SObject>> getExternalUbicacion(){
        Map<String, List<SObject>> ubicacion = new Map<String, List<SObject>>();
        ubicacion.put('pais', Database.query('SELECT Id, IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= \'País\' ORDER BY Name'));
        ubicacion.put('estado', Database.query('SELECT IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= \'Estado\' ORDER BY Name'));
        ubicacion.put('municipio', Database.query('SELECT IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= \'Municipio\' ORDER BY Name'));
        
        return ubicacion;
    }
    
    @RemoteAction
    //@future(callout=true)
    global static void sendEmailCalculadora(String idLead, String email, String promedio, String descuentoInsc, String descuentoMens, String vigencia){
        System.debug('*********** ' + idLead + ' ' + email);
        Id leadId = Id.valueOf(idLead);
        PlantillaCalculoRegistradoController.sendMail(leadId, email, promedio, descuentoInsc, descuentoMens, vigencia);   
    }
        
    /*
    @RemoteAction
    global static ComboUbicacionWrapper getExternalUbicacion(){
    
        ItemWrapper itemPais = new ItemWrapper('País');
        ItemWrapper itemEstado = new ItemWrapper('Estado');
        ItemWrapper itemMunicipio = new ItemWrapper('Municipio');
        
        String paisBussy = '';
        String estadoBussy = '';
        String municipioBussy = '';
        
        List<Ubicacion__c> listMunicipios = [SELECT IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= 'Municipio' ORDER BY Name];
        for(Ubicacion__c municipio: listMunicipios){
            InfoWrapper infoMunicipio = new infoWrapper();
            //Informacion de Municipio
            infoMunicipio.dataId = municipio.IdUbicacion__c;
            infoMunicipio.name = municipio.Name;
            infoMunicipio.parent = municipio.IdEstadoPais__c;        
            itemMunicipio.items.add(infoMunicipio);
        }
        
        List<Ubicacion__c> listPaises = [SELECT IdUbicacion__c, Name FROM Ubicacion__c WHERE TipoUbicacion__c= 'País' ORDER BY Name];
        for(Ubicacion__c pais: listPaises){
            InfoWrapper infoPais = new infoWrapper();
            //Informacion del pais
            infoPais.dataId = pais.IdUbicacion__c;
            infoPais.name = pais.Name;
            itemPais.items.add(infoPais);
        }
        
        List<Ubicacion__c> listEstados = [SELECT IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= 'Estado' ORDER BY Name];
        for(Ubicacion__c estado: listEstados){
            InfoWrapper infoEstado = new infoWrapper();
            //Informacion de Estado
            infoEstado.dataId = estado.IdUbicacion__c;
            infoEstado.name = estado.Name;
            infoEstado.parent = estado.IdEstadoPais__c;
            itemEstado.items.add(infoEstado);
        }
        
        
        ComboUbicacionWrapper cw = new ComboUbicacionWrapper();
		cw.pais = itemPais;
        cw.estado = itemEstado;
        cw.municipio = itemMunicipio;
        return cw;
    }
    */
    @RemoteAction
    global static Map<String, String> getMontos(String ofe){
    	Map<String, String> montos = new Map<String , String>();
        List<OfertaConceptoPagos__c> listMontos = new List<OfertaConceptoPagos__c>();
        listMontos = [SELECT Id, Monto__c, ConceptoPago__r.Name, OfertaEducativa__c FROM OfertaConceptoPagos__c  WHERE OfertaEducativa__c =: ofe];
        for(OfertaConceptoPagos__c mont: listMontos){
            montos.put(mont.ConceptoPago__r.Name, String.valueOf(mont.Monto__c));
        }
        return montos;
    }
    
    global class InfoWrapper{
        public String dataId {get;set;}
        public String parent {get;set;}
        public String name {get;set;}
    	
        public InfoWrapper(){}
    }
    
    global class ItemWrapper{
        public List<InfoWrapper> items {get;set;}
        public String titulo {get; set;}
        public ItemWrapper(String titulo){
            items = new List<InfoWrapper>();
            this.titulo = titulo;
        }
        
    }
    
    global class ComboWrapper{
        public ItemWrapper modalidad {get;set;}
        public ItemWrapper nivel {get;set;}
        public ItemWrapper plantel {get;set;}
        public ItemWrapper programa {get;set;}
        
        public ComboWrapper(){
            modalidad = new ItemWrapper('Modalidad');
            nivel = new ItemWrapper('Nivel');
            plantel = new ItemWrapper('Plantel');
            programa = new ItemWrapper('Programa');
        }
    }
    
 /*   global class ComboUbicacionWrapper{
        public ItemWrapper pais {get;set;}
        public ItemWrapper estado {get;set;}
        public ItemWrapper municipio {get;set;}
        
        public ComboUbicacionWrapper(){
            pais = new ItemWrapper('País');
            estado = new ItemWrapper('Estado');
            municipio = new ItemWrapper('Municipio');
        }
    }*/
}