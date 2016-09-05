public class LEAD_BecasCtrl{

    public List<SelectOption> becaConvenioRango { get; set; }
    public Lead candidato;
    public Lead getCandidato(){
        return this.candidato;
    }
    public void setCandidato(Lead candidato){
        this.candidato = candidato;
        inicializaBeca();
        inicializaDescuento();
        incializaSolicitudPromocion();
    }
    
    
    /* LÓGICA PARA SECCIÓN DE BECA:
     * 
     * Si se selecciona COMERCIAL:
     * Obtener id del campo OfertaEducativa__c y buscar una Beca asociada.. si existe una, se toman los valores mayores a cero de los campos A__c - H__c y con ellos se llena
     * la lista de selección para indicar PorcentajeBeca__c del Lead.
     * 
     * Si se selecciona CONVENIO:
     * Se llena un listado con con Becas de tipo 'Convenio', coincidentes en Plantel__c, Nivel__c o Programa__c del Lead
     * Dependiendo de la selección, la beca puede ser de tipo porcentaje Fijo o de Rango
     * Si es fijo, se copia su valor de PorcentajeBeca en el campo propio del Lead
     * Si es rango, se llena una lista de selección, desde Inicial__c hasta Final__c con incrementos determinados por el campo Incrementos__c
	*/
    
    //Beca
    public Beca__c becaOferta {get;set;}
    public List<SelectOption> porcentajeBeca {get;set;}//para becas comerciales
    public String PorcentajeBecaString {get;set;}
    
    public List<BecaConvenioAsignacion__c> becasConvenio {get;set;}
    public List<SelectOption> listaBecasConvenio {get;set;}
    public String PorcentajeBecaRango {get;set;}
    public List<SelectOption> becaRango {get;set;}
    public String tipoBecaConvenio {get;set;}
    public OfertaEducativa__c ofertaSeleccionada {get;set;}
    
    //Descuento
    public Descuento__c descuentoVigente {get;set;}
    public Descuento__c aplicaPromocionCero {get;set;}
    public Descuento__c solicitudPromocion {get;set;}
    public String leyendaSolicitudPromocion {get;set;}
    
    public LEAD_BecasCtrl(){
        
    }
    
    public void inicializaBeca(){
        if(candidato==null){candidato = new Lead();}
        listaBecasConvenio = new List<SelectOption>();
        porcentajeBeca = new List<SelectOption>();
        becaOferta = new Beca__c();
    	becasConvenio = new List<BecaConvenioAsignacion__c>();
        becaConvenioRango = new List<SelectOption>();
        
        try{
            aplicaPromocionCero = [SELECT Id, Name 
                                   FROM Descuento__c 
                                   WHERE TipoDescuento__c='Promoción 0' 
                                   AND (
                                       //una opción general
                                       (Nivel__c=:candidato.Nivel__c AND Modalidad__c=null AND Periodo__c=null) 
                                       OR (Nivel__c=null AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=null) 
                                       OR (Nivel__c=null AND Modalidad__c=null AND Periodo__c=:candidato.Periodo__c)
                                       
                                       //dos opciones
                                       OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=null) 
                                       OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=null AND Periodo__c=:candidato.Periodo__c) 
                                       OR(Nivel__c=null AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c) 
                                       
                                       OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c)
                                   )
                                   LIMIT 1];
            if(aplicaPromocionCero!=null){
                candidato.AplicaPromocionCero__c = true;
            }
        }catch(Exception e){
            
        }
        
        
        if(candidato.TipoBeca__c!= null){
            if(candidato.TipoBeca__c!= ''){
                seleccionaBeca();
            }
        }
        seleccionaBeca();
    }
    
    public void incializaSolicitudPromocion(){
        solicitudPromocion = new Descuento__c();
        solicitudPromocion = [SELECT Id, Name, TipoDescuento__c,PorcentajeDescuento__c,FechaInicioVigencia__c,FechaFinVigencia__c,Comentarios__c, Estatus__c 
                              FROM Descuento__c 
                              WHERE Lead__c =: candidato.Id 
                              LIMIT 1];
        if(solicitudPromocion.Id!=null){
            candidato.SolicitudPromocion__c=true;
            if(solicitudPromocion.Estatus__c=='Inactivo'){
                leyendaSolicitudPromocion ='Pendiente de aprobación';
            }
        }
    }
    
    /* SELECCION DE BECAS */
    public void seleccionaBeca(){
        if(candidato.TipoBeca__c =='Comercial'){
            if(candidato.OfertaEducativa__c==null){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Para poder generar una Beca, antes debe seleccionar un grupo' ));
                return;
            }else{
                String ofe = candidato.OfertaEducativa__c;
                becaOferta = new Beca__c();
                try{
                    becaOferta = (Beca__c)Database.query('SELECT  '+String.join(new List<String>(SObjectType.Beca__c.Fields.getMap().keySet()), ', ')+' FROM Beca__c WHERE OfertaEducativa__c =: ofe LIMIT 1');
                    porcentajeBeca = new List<SelectOption>();
                    porcentajeBeca.add(new SelectOption('','-Selecciona un porcentaje-'));
                    List<Double> becasComercial = new List<Double>{becaOferta.A__c,becaOferta.B__c,becaOferta.C__c,becaOferta.D__c,becaOferta.E__c,becaOferta.F__c,becaOferta.G__c,becaOferta.H__c};
                        for(Double d: becasComercial){
                            if(d > 0){
                                if(candidato.PorcentajeBeca__c==d){
                                    PorcentajeBecaString = String.valueOf(d);
                                }
                                porcentajeBeca.add( new SelectOption(String.valueOf(d),String.valueOf(d)) ); 
                            }
                        }
                    if(porcentajeBeca.size()<1){
                        PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La beca asociada no tiene importes válidos' ));
                    	return;
                    }
                }catch(Exception e){
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La oferta asignada no contiene ninguna Beca '+e.getMessage() ));
                    return;
                }
            }
        }else if(candidato.TipoBeca__c =='Convenio'){
            if(candidato.Plantel__c!=null && candidato.Nivel__c!=null && candidato.Programa__c!=null){
                try{
                    becasConvenio = [SELECT Id, Name, Baja__c, Nivel__c, Plantel__c, Programa__c, BecaConvenio__c, 
                                     BecaConvenio__r.Name, BecaConvenio__r.PorcentajeBeca__c, BecaConvenio__r.Inicial__c, BecaConvenio__r.Final__c, 
                                     BecaConvenio__r.Incrementos__c, BecaConvenio__r.TipoPorcentaje__c,BecaConvenio__r.TipoBeca__c , BecaConvenio__r.NombreConvenio__c  
                                     FROM BecaConvenioAsignacion__c 
                                     WHERE BecaConvenio__r.TipoBeca__c='Convenio' 
                                     AND (
                                         Nivel__c=:candidato.Nivel__c OR Plantel__c=:candidato.Plantel__c OR Programa__c=:candidato.Programa__c
                                         
                                     )
                                     LIMIT 100];
                    
                    Map<String,BecaConvenioAsignacion__c> mapaBecasConvenio = new Map<String,BecaConvenioAsignacion__c>();
                    listaBecasConvenio = new List<SelectOption>();
                    listaBecasConvenio.add(new SelectOption('','-Selecciona una Beca-'));
                    
                    for(BecaConvenioAsignacion__c beca: becasConvenio){
                        if(beca.BecaConvenio__c!=null && beca.BecaConvenio__r.NombreConvenio__c!=null){
                            if(!mapaBecasConvenio.containsKey(beca.BecaConvenio__c)){
                                mapaBecasConvenio.put(beca.BecaConvenio__c,beca);
                                listaBecasConvenio.add(new SelectOption(beca.BecaConvenio__c,beca.BecaConvenio__r.NombreConvenio__c));
                            }
                        }
                    }
                }catch(Exception e){
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, e.getMessage()+ e.getLineNumber()+becasConvenio ));
                }
            }else{
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Se debe seleccionar un grupo para poder asignar descuentos' ));
            }
        }
        
        /* NO APLICA CALCULADORA MÁS QUE EN LANDING-PAGE
         * else if(candidato.TipoBeca__c =='Calculadora'){
            porcentajeBeca = new List<SelectOption>();
            try{
                registroCalculadora = [SELECT Id, Name, DescuentoInscripcion__c, CategoriaLetra__c, Promedio__c FROM BecaCalculadora__c WHERE Promedio__c=:Double.valueOf(candidato.Promedio__c) LIMIT 1];
                candidato.PorcentajeBeca__c = Integer.valueOf(registroCalculadora.DescuentoInscripcion__c);
            }catch(Exception e){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Se ha producido un error: '+e.getMessage() ));
            }
        }*/
    }
    
    public void setBecaAplicada(){
        
        if(candidato.TipoBeca__c =='Comercial'){ // Si es comercial, la lista incluye porcentajes en cadena
            candidato.PorcentajeBeca__c = Integer.valueOf(PorcentajeBecaString);
            tipoBecaConvenio = null;
        }else if(candidato.TipoBeca__c =='Convenio'){// La lista incluye id de objeto Beca__c
            for(BecaConvenioAsignacion__c beca: becasConvenio){
                if(beca.BecaConvenio__c==PorcentajeBecaString){
                    if(beca.BecaConvenio__r.TipoPorcentaje__c=='Fijo'){
                        tipoBecaConvenio = 'Fijo';
                        candidato.PorcentajeBeca__c = beca.BecaConvenio__r.PorcentajeBeca__c;
                    }else if(beca.BecaConvenio__r.TipoPorcentaje__c=='Rango'){
                        tipoBecaConvenio = beca.BecaConvenio__r.TipoPorcentaje__c;
                        becaConvenioRango = new List<SelectOption>();
                        becaConvenioRango.add(new SelectOption('','-Selecciona un porcentaje-'));
                        
                        for(Integer i=Integer.valueOf(beca.BecaConvenio__r.Inicial__c); i<=Integer.valueOf(beca.BecaConvenio__r.Final__c); i+=Integer.valueOf(beca.BecaConvenio__r.Incrementos__c)){
                            becaConvenioRango.add(new SelectOption(String.valueOf(i),String.valueOf(i)));                            
                        }
                        System.debug(beca.BecaConvenio__r.TipoPorcentaje__c);
                        System.debug(becaConvenioRango);
                    }else{
                        tipoBecaConvenio = null;
                        //System.debug(beca.BecaConvenio__r.TipoPorcentaje__c);
                    }
                    break;
                }
            }
        }
    }/* TERMINA SELECCION DE BECAS */
    
    
    public void inicializaDescuento(){
        if(candidato.OfertaEducativa__c!=null){
            try{
                ofertaSeleccionada = [SELECT Id, Name, Modalidad__c, Nivel__c, Periodo__c FROM OfertaEducativa__c WHERE Id=:candidato.OfertaEducativa__c LIMIT 1 ];
                descuentoVigente = [SELECT Id, Name, TipoDescuento__c, FechaInicioVigencia__c, FechaFinVigencia__c, Modalidad__c, Nivel__c, Periodo__c, PorcentajeDescuento__c 
                                    FROM Descuento__c 
                                    WHERE Vigente__c=TRUE 
                                    AND TipoDescuento__c='Descuento individual vigente'
                                    AND Modalidad__c=:ofertaSeleccionada.Modalidad__c 
                                    AND Nivel__c=:ofertaSeleccionada.Nivel__c
                                    AND Periodo__c=:ofertaSeleccionada.Periodo__c
                                    LIMIT 1];
                
            }catch(Exception e){
                System.debug(e.getMessage()+'  '+e.getLineNumber());
            }
        }
    }
    public void guardaSolicitudPromocion(){
        try{
            if(candidato.Id==null){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Debe guardar el registro del candidato antes de poder registrar una promoción'));
            }else{
                solicitudPromocion.Lead__c = candidato.Id;
                upsert solicitudPromocion;
                candidato.SolicitudPromocion__c=true;
                leyendaSolicitudPromocion ='Pendiente de aprobación';
                System.debug(solicitudPromocion);
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'Se ha registrado la promoción exitosamente'+solicitudPromocion ));
            }
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, e.getMessage()+ e.getLineNumber() ));
        }
    }
    
}