public class OPP_LayoutCtrl {
    
    public Opportunity oportunidad {get;set;}
    public String idOpportunity {get;set;}
    public Decimal promotorAverage {get; set;}
    public Boolean isOverBecas {get; set;}
    public Boolean tieneFichaMovil {get; set;}
    public Account cuentaAsociada {get;set;}
    
    public date fechaActual{get;set;}
    public Boolean guardoOk{get;set;}
    
    
    
    //listas de selección para oferta acádemica, cargan de Catalogo__c, Plantel__c y Periodo__c de forma dependiente
    //public List<SelectOption> modalidades {get{return UtilsOferta.getModalidades();}set;}
    public List<SelectOption> modalidades {get;set;}
    public List<SelectOption> planteles {get;set;}
    public List<SelectOption> niveles {get;set;}
    public List<SelectOption> programas {get;set;}
    public List<SelectOption> periodos {get;set;}
    public List<OfertaEducativa__c> ofertasEducativas {get;set;}
    public List<Id> idOfertasEducativas {get;set;}
    public List<OfertaConceptoPagos__c> pagos {get;set;}
    
    //la clase envolvente incluye al objeto de Pagos y de Grupos, coincidentes con los filtros de oferta elegible
    public List<grupoWrapped> listaGrupos {get;set;}
    public List<Grupo__c> grupos {get;set;}
    public List<Catalogo__c> conceptosPagos {get{
        return [SELECT Id, Name, ConceptoFijo__c, MontoCostoFijo__c FROM Catalogo__c WHERE TipoCatalogo__c='Concepto Pagos' ORDER BY Name LIMIT 100];
    }set;}
    public String IdGrupoSeleccionado {get;set;}
    public String IdCortoGrupo {get;set;}
    public String grupoSeleccionadoName {get;set;}
    
    
    //Variable para controlar fichas moviles
    public FichaPago__c fichaMovil {get;set;}
    
    //Beca
    public Beca__c becaOferta {get;set;}
    public OfertaEducativa__c ofertaSeleccionada {get;set;}
    //Beca comercial
    public List<SelectOption> porcentajeBeca {get;set;}
    public String PorcentajeBecaString {get;set;}
    public Map<String,Double> mapaLetrasBeca {get;set;}
    public String LetraBecaString {get;set;}
    public SolicitudBeca__c solicitudBecaComercial {get;set;}
    
    //Beca convenio
    public List<BecaConvenioAsignacion__c> becasConvenio {get;set;}
    public List<SelectOption> listaBecasConvenio {get;set;}
    public String PorcentajeBecaRango {get;set;}
    public List<SelectOption> becaRango {get;set;}
    public String tipoBecaConvenio {get;set;}
    public Map<Id,BecaConvenioAsignacion__c> MapaBecasConvenioAsignacion {get;set;}
    public Map<Id,BecaConvenioAsignacion__c> MapaBecasConvenio {get;set;}
        
    public List<SelectOption> listaBecasConvenioAsignacion {get;set;}
    public Map<id,SolicitudBeca__c> becasConvenioSolicitadas {get;set;}
    public SolicitudBeca__c solicitudBeca {get;set;}
    public Double porcentajeSolicitadoBeca {get;set;}
    
    public Boolean tieneRequisitos {get;set;}
    public Double importeTotal {get;set;}
    public Double inscripcionConDescuento {get;set;}
    public Double colegiaturaConDescuento {get;set;}
    //Descuento
    public BecaConvenioAsignacion__c descuentoVigente {get;set;}
    public BecaConvenioAsignacion__c aplicaPromocionCero {get;set;}
    public Double mayorDescuentoGeneral {get;set;}
    public Double descuentoIndividualVigente {get;set;}
    //public Descuento__c descuentoVigente {get;set;}
    //public Descuento__c aplicaPromocionCero {get;set;}
    public Descuento__c solicitudPromocion {get;set;}
    public String leyendaSolicitudPromocion {get;set;}
    public Boolean solicitudPromocionRegistrada {get;set;}
    public Integer importeSolicitud {get;set;}
    
    public List<RequisitoBeca__c> requisitosBecas {get;set;}
    
    public OPP_LayoutCtrl(ApexPages.StandardController stdController){
        idOpportunity = System.currentPagereference().getParameters().get('Id');
        
        if(idOpportunity!=null){
            oportunidad = (Opportunity)Database.query('SELECT Account.Id, Account.Name, Grupo__r.Name, Plantel__r.Name, Nivel__r.Name, Periodo__r.Name,'+String.join(new List<String>(SObjectType.Opportunity.Fields.getMap().keySet()), ', ')+' FROM Opportunity WHERE Id =: idOpportunity');
        }else{
            oportunidad = new Opportunity();
        }
        
        tieneFichaMovil = true;
        if(oportunidad.FichaMovil__c == null){
            tieneFichaMovil = false;
        }
        isOverBecas = false;
        inicializaObjetos();
    }
    
    private void inicializaObjetos(){
        modalidades= UtilsOferta.getModalidades();
        fechaActual  = date.today();
        guardoOk=false;
        mayorDescuentoGeneral=0;
        if( (oportunidad.SubOrigenCandidato__c=='Preinscripción' || oportunidad.SubOrigenCandidato__c=='Calcula tu colegiatura') && oportunidad.DescuentoInicial__c!=null){
            mayorDescuentoGeneral = oportunidad.DescuentoInicial__c;
        }
        
        String idCuenta = ApexPages.currentPage().getParameters().get('accid');
        System.debug('id cuenta: ' + idcuenta);
        if(idCuenta!=null){
            oportunidad.AccountId = idCuenta;
        }
        fechaActual  = date.today();
        /*****Cambios 30/06/2016*******/
        guardoOk=false;
        mayorDescuentoGeneral=0;
        if(oportunidad.SubOrigenCandidato__c=='Preinscripción' || oportunidad.SubOrigenCandidato__c=='Calcula tu colegiatura'){
            mayorDescuentoGeneral = oportunidad.PorcentajeDescuento__c;
        }
        //SYSTEM.debug('mayorDescuentoGeneral');
        /******************************/
        requisitosBecas = new List<RequisitoBeca__c>();
        
        IdGrupoSeleccionado = oportunidad.Grupo__c;
        grupoSeleccionadoName = oportunidad.Grupo__r.Name;
        IdCortoGrupo = IdGrupoSeleccionado==null?'': IdGrupoSeleccionado.substring(0,15);
        
        idOfertasEducativas = new List<Id>();
        grupos = new List<Grupo__c>(); 
        listaGrupos = new List<grupoWrapped>();
        
        // CONDICIONES INICIALES PARA SELECCIÓN DE GRUPO / OFERTA ACADEMICA
        if(oportunidad.Id==null){oportunidad.Modalidad__c=null;}
        
        if(oportunidad.FichaMovil__c!=null){
            isFichaMovil();
            //Validaciones adicionales
            //	no deben dispararse a menos que se le haya asignado una beca de forma inválida (manual o por validaciones anteriores)
            if(periodos==null){
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -')); 
            }
            if(programas==null){
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));    
            }
            if(planteles==null){
                planteles = new List<SelectOption>();
                planteles.add(new SelectOption('','- Debe seleccionar una modalidad -'));
            }
            if(niveles==null){
                niveles = new List<SelectOption>();
                niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
            }
        }else{
            if(oportunidad.Modalidad__c!=null){ getPlanteles(); }
            else{
                oportunidad.Plantel__c=oportunidad.Nivel__c=oportunidad.Programa__c=oportunidad.Periodo__c=null;
                planteles = new List<SelectOption>();
                planteles.add(new SelectOption('','- Debe seleccionar una modalidad -'));
                niveles = new List<SelectOption>();
                niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
            if(oportunidad.Plantel__c==null){
                oportunidad.Nivel__c=oportunidad.Programa__c=oportunidad.Periodo__c=null;
                niveles = new List<SelectOption>();
                niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
            if(oportunidad.Nivel__c==null){
                oportunidad.Programa__c=oportunidad.Periodo__c=null;
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
            if(oportunidad.Programa__c==null){
                oportunidad.Periodo__c=null;
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
        }
        
        inicializaBeca();
        incializaSolicitudPromocion();
        inicializaDescuento();
        /*******Cambio 28/06/2016******/
        //define el tipo de promoción que se aplica a la inscripción y recalcula:
        /*if(oportunidad.AplicaPromocionCero__c){
            oportunidad.PorcentajeDescuento__c=100;
        }else{
            if( solicitudPromocion.Estatus__c=='Activo' ){
                oportunidad.PorcentajeDescuento__c=solicitudPromocion.PorcentajeDescuento__c;
            }else if(descuentoVigente!=null){
                if(descuentoVigente.Id!=null)
                    oportunidad.PorcentajeDescuento__c = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
            }else{
                oportunidad.PorcentajeDescuento__c=0;
            }
        }
        if(oportunidad.AplicaPromocionCero__c){
            oportunidad.PorcentajeDescuento__c=100;
        }else{
            if( solicitudPromocion.Estatus__c=='Activo' ){
                oportunidad.PorcentajeDescuento__c=solicitudPromocion.PorcentajeDescuento__c;
            }else if(descuentoVigente!=null){
                if(descuentoVigente.Id!=null && (mayorDescuentoGeneral<=descuentoVigente.Descuento__r.PorcentajeDescuento__c) ){
                    oportunidad.PorcentajeDescuento__c = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                }else{
                    oportunidad.PorcentajeDescuento__c=mayorDescuentoGeneral;
                }
            }else{
                oportunidad.PorcentajeDescuento__c=mayorDescuentoGeneral;
            }
        }*/
        /************************************/
        actualizaImporteTotal();
        setBecaAplicada();
        
    }
    
    public void actualizaImporteTotal(){
        importeTotal=0;
        inscripcionConDescuento=0;
    	colegiaturaConDescuento=0;
        importeTotal=0;
        inscripcionConDescuento=0;
        colegiaturaConDescuento=0;
        
        if(oportunidad.AplicaPromocionCero__c && aplicaPromocionCero!=null){
            oportunidad.PorcentajeDescuento__c=100;
            oportunidad.VigenciaDescuento__c = aplicaPromocionCero.Descuento__r.FechaFinVigencia__c;
        }else{
            if(solicitudPromocion!=null){
                
System.debug('solicitudPromocion.Estatus__c--> '+solicitudPromocion.Estatus__c);             
                if( solicitudPromocion.Estatus__c=='Activo' ){
                    System.debug('solicitudPromocion.Estatus__c--> '+solicitudPromocion.Estatus__c);
                    oportunidad.PorcentajeDescuento__c = solicitudPromocion.PorcentajeDescuento__c;
                    oportunidad.VigenciaDescuento__c = solicitudPromocion.FechaFinVigencia__c;
                }else if(descuentoVigente!=null){
                    if(descuentoVigente.Id!=null && (mayorDescuentoGeneral<=descuentoVigente.Descuento__r.PorcentajeDescuento__c) ){
                        oportunidad.PorcentajeDescuento__c = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                        oportunidad.VigenciaDescuento__c = descuentoVigente.Descuento__r.FechaFinVigencia__c;
                    }else{
                        oportunidad.PorcentajeDescuento__c=mayorDescuentoGeneral;
                    }
                }
            }else {
                if(descuentoVigente!=null){
                    if(descuentoVigente.Id!=null && (mayorDescuentoGeneral<=descuentoVigente.Descuento__r.PorcentajeDescuento__c) ){
                        oportunidad.PorcentajeDescuento__c = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                        oportunidad.VigenciaDescuento__c = descuentoVigente.Descuento__r.FechaFinVigencia__c;
                    }else{
                        oportunidad.PorcentajeDescuento__c=mayorDescuentoGeneral;
                    }
                }else{
                    oportunidad.PorcentajeDescuento__c=mayorDescuentoGeneral;
                }
            }
        }
        
        if(oportunidad.Antologia__c!=null){
            importeTotal=importeTotal+oportunidad.Antologia__c;
        }
        if(oportunidad.Colegiatura__c!=null){
            if(oportunidad.PorcentajeBeca__c!=null){
                colegiaturaConDescuento=oportunidad.Colegiatura__c-(oportunidad.Colegiatura__c*(oportunidad.PorcentajeBeca__c/100));
            }else{
                colegiaturaConDescuento=oportunidad.Colegiatura__c;
            }
            importeTotal=importeTotal+colegiaturaConDescuento;
        }
        if(oportunidad.Inscripcion__c!=null){
            if(oportunidad.AplicaPromocionCero__c==true){
                inscripcionConDescuento=0;
            }else if(oportunidad.AplicaPromocionCero__c==false){
                if(oportunidad.PorcentajeDescuento__c!=null){
                    inscripcionConDescuento=oportunidad.Inscripcion__c -(oportunidad.Inscripcion__c * (oportunidad.PorcentajeDescuento__c/100));
                }else{
                    inscripcionConDescuento=(oportunidad.Inscripcion__c);
                }
            }
            importeTotal=importeTotal+inscripcionConDescuento;
        }
        if(oportunidad.ExamenAdmision__c!=null){
            importeTotal=importeTotal+oportunidad.ExamenAdmision__c;
        }
        if(oportunidad.Propedeutico__c!=null){
            importeTotal=importeTotal+oportunidad.Propedeutico__c;
        }
        if(oportunidad.Uniforme__c!=null){
            importeTotal=importeTotal+oportunidad.Uniforme__c;
        }
        /*****Cambio 28/06/2016*****/
        /*if(oportunidad.AplicaPromocionCero__c && aplicaPromocionCero!=null){
            if(aplicaPromocionCero.Id!=null){
                oportunidad.VigenciaDescuento__c = aplicaPromocionCero.Descuento__r.FechaFinVigencia__c;
                //candidato.PorcentajeDescuento__c = 100;
            }
        }*/
        /***************************/
    }
    
    /* OBTIENE CONDICIONES DE OFERTA ACADEMICA PARA SELECCION DE GRUPO */
    public class grupoWrapped{
        public Boolean check {get;set;}
        public Grupo__c grupo {get;set;}
        public Map<Id,Double> pagos {get;set;}
        
        public grupoWrapped(Grupo__c gpo, Map<Id,Double> pagoActual){
            check = false;
            grupo = gpo;
            pagos = pagoActual;
        }
    }
    public void getPlanteles(){
        planteles = UtilsOferta.getPlanteles(oportunidad.Modalidad__c);
        niveles = new List<SelectOption>();
        niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
        programas = new List<SelectOption>();
        programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
        periodos = new List<SelectOption>();
        periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        for(SelectOption plan: planteles){
            if(plan.getValue()!=''){
                if(plan.getValue()==oportunidad.Plantel__c){
                    getNiveles();
                    break;
                }
            }
        }
    }
    public void getNiveles(){
        niveles = UtilsOferta.getNiveles(oportunidad.Plantel__c, oportunidad.Modalidad__c);
        programas = new List<SelectOption>();
        programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
        periodos = new List<SelectOption>();
        periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        for(SelectOption niv: niveles){
            if(niv.getValue()!=''){
                if(niv.getValue()==oportunidad.Nivel__c){
                    getProgramas();
                    break;
                }
                if(niv.getValue()==oportunidad.Nivel__c && oportunidad.FichaMovil__c != null){
                    getProgramasMovil();
                    break;
                }
            }
        }
    }
    public void getProgramas(){
        programas = UtilsOferta.getProgramas(oportunidad.Plantel__c, oportunidad.Modalidad__c , oportunidad.Nivel__c);
        periodos = new List<SelectOption>();
        periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        
        for(SelectOption prog: programas){
            if(prog.getValue()!=''){
                if(prog.getValue()==oportunidad.Programa__c){
                    getPeriodos();
                }
            }
        }
    }
    public void getPeriodos(){
        listaGrupos = new List<grupoWrapped>();
        ofertasEducativas = UtilsOferta.getPeriodos(oportunidad.Plantel__c, oportunidad.Modalidad__c, oportunidad.Nivel__c, oportunidad.Programa__c);
        
        periodos = new List<SelectOption>();
        Map<String,OfertaEducativa__c> mapaPeriodos = new Map<String,OfertaEducativa__c>();
        periodos.add(new SelectOption('','-- Seleccione un Periodo --'));
        //idOfertasEducativas= new List<Id>();
        try{
            for(OfertaEducativa__c cat: ofertasEducativas){
                if(!mapaPeriodos.containsKey(cat.Periodo__c)){
                    mapaPeriodos.put(cat.Periodo__c, cat);
                    periodos.add(new SelectOption(cat.Periodo__c,cat.Periodo__r.Name));
                    
                    //idOfertasEducativas.add(cat.Id);
                }
                if(cat.Periodo__c==oportunidad.Periodo__c){
                    getGrupos();
                }
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    public void getGrupos(){
        
        listaGrupos = new List<grupoWrapped>();
        pagos = new List<OfertaConceptoPagos__c>();
        idOfertasEducativas= new List<Id>();
        
        if(oportunidad.FichaMovil__c==null){
            try{
                for(OfertaEducativa__c cat: ofertasEducativas){
                    if(cat.Periodo__c==oportunidad.Periodo__c){
                        idOfertasEducativas.add(cat.Id);
                    }
                }
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }else{
            try{
                for(OfertaEducativa__c cat: ofertasEducativas){
                    if(cat.Modalidad__c==oportunidad.Modalidad__c){
                        idOfertasEducativas.add(cat.Id);
                    }
                }
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }
        
        
        
        try{
            grupos = (List<Grupo__c>)Database.query('SELECT OfertaEducativa__r.Name, AulaAsignada__r.Name, Docente__r.Name , Materia__r.Name, '+String.join(new List<String>(SObjectType.Grupo__c.Fields.getMap().keySet()), ', ')+' FROM Grupo__c WHERE OfertaEducativa__c IN:idOfertasEducativas LIMIT 100');
            
            pagos = [SELECT Id, Name, Activo__c, Cantidad__c, ConceptoPago__c, ConceptoFijo__c, Monto__c, OfertaEducativa__c FROM OfertaConceptoPagos__c WHERE OfertaEducativa__c IN :idOfertasEducativas ORDER BY ConceptoPago__c LIMIT 100];
        }catch(Exception e){
            //PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Error '+e.getMessage()+' '+e.getLineNumber() ));
            System.debug(e.getMessage()+' '+e.getLineNumber());
        }
        // Los pagos y los grupos se relacionan con una oferta educativa. 
        // La información de la oferta educativa no es relevante en la tabla (se asignan  valores de oferta sólo cuando se elige al grupo). 
        // Se puede agregar un sólo concepto por cada pago 
        Map<Id,Double> pagosGrupos = new Map<Id,Double>();
        
        for(Grupo__c grupo: grupos){
            pagosGrupos = new Map<Id,Double>();
            for(OfertaConceptoPagos__c pago: pagos){
                if(pago.OfertaEducativa__c==grupo.OfertaEducativa__c){
                    if(!pagosGrupos.containsKey(pago.ConceptoPago__c)){
                        pagosGrupos.put(pago.ConceptoPago__c,pago.Monto__c);
                    }
                }
            }
            for(Catalogo__c concepto: conceptosPagos){
                if(!pagosGrupos.containsKey(concepto.Id)){
                    pagosGrupos.put(concepto.Id,0);
                }
            }
            listaGrupos.add( new grupoWrapped(grupo,pagosGrupos) );
        }
        
        if(oportunidad.OfertaEducativa__c!=null){
            modificaRadio();
        }
        
    }
    
    
    public void setOffertByPayment(){
        fichaMovil= (FichaPago__c )Database.query('SELECT '+String.join(new List<String>(SObjectType.FichaPago__c.Fields.getMap().keySet()), ', ')+' FROM FichaPago__c  WHERE Id =: candidato.FichaMovil__c');
        oportunidad.Nivel__c = fichaMovil.Nivel__c;
        oportunidad.Periodo__c = fichaMovil.Periodo__c;
        oportunidad.Plantel__c = fichaMovil.Plantel__c;
        
        modalidades = new List<SelectOption>();
        modalidades.add(new SelectOption('','-- Seleccione una Modalidad --'));
        try{ //Limitar la consulta de acuerdo a la selección
            for(Catalogo__c cat: [SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c ='Modalidad' LIMIT 100]){
                modalidades.add(new SelectOption(cat.Id,cat.Name));
            }
        }catch(Exception e){}
        //Falta programa
        
    }
    
    public void isFichaMovil(){
        
        fichaMovil = [SELECT id, Lead__c, Periodo__c, Plantel__c, Nivel__c, Importe__c, Descuento__c, RecordType.Name FROM FichaPago__c WHERE Id =: oportunidad.FichaMovil__c];
        if(fichaMovil.RecordType.Name == 'Ficha Móvil' && fichaMovil.Lead__c == null){
            oportunidad.Plantel__c = fichaMovil.Plantel__c;
            oportunidad.Periodo__c = fichaMovil.Periodo__c;
            oportunidad.Nivel__c = fichaMovil.Nivel__c;
            
            getProgramasMovil();
        }else{
            oportunidad.FichaMovil__c = null;
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La ficha seleccionada no es de tipo Ficha Móvil o ya se encuentra en uso'));
        }
    }
    
    public void getProgramasMovil(){
        programas = UtilsOferta.getProgramasMoviles(oportunidad.FichaMovil__c);
        modalidades = new List<SelectOption>();
        modalidades.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        
        Boolean encuentraPrograma = false;
        for(SelectOption prog: programas){
            if(prog.getValue()!=''){
                if(prog.getValue()==oportunidad.Programa__c && oportunidad.Programa__c!=null){
                    encuentraPrograma=true;
                    getModalidadesMovil();
                }
            }
        }
        if(!encuentraPrograma){
            System.debug('No Encontró programa');
            oportunidad.Programa__c=null;
            oportunidad.Modalidad__c=null;
            oportunidad.OfertaEducativa__c = null;
            oportunidad.Grupo__c = null;
        }
    }
    
    public void getModalidadesMovil(){
        ofertasEducativas = UtilsOferta.getModalidadesMoviles(oportunidad.Plantel__c, oportunidad.Periodo__c, oportunidad.Nivel__c, oportunidad.Programa__c);
        modalidades = new List<SelectOption>();
        Map<String,OfertaEducativa__c> mapaModalidad = new Map<String,OfertaEducativa__c>();
        modalidades.add(new SelectOption('','-- Seleccione una modalidad --'));
        listaGrupos = new List<grupoWrapped>();
        idOfertasEducativas= new List<Id>();
        
        Boolean encuentraModalidad = false;
        try{
            for(OfertaEducativa__c cat: ofertasEducativas){
                if(!mapaModalidad.containsKey(cat.Modalidad__c)){
                    mapaModalidad.put(cat.Modalidad__c, cat);
                    modalidades.add(new SelectOption(cat.Modalidad__c,cat.Modalidad__r.Name));
                    idOfertasEducativas.add(cat.Id);
                }
                if(cat.Modalidad__c ==oportunidad.Modalidad__c && oportunidad.Modalidad__c!=null){
                    encuentraModalidad=true;
                    getGrupos();
                }
            }
        }catch(Exception e){
        }
        if(!encuentraModalidad){
            System.debug('No Encontró modalidad');
            oportunidad.Modalidad__c=null;
            oportunidad.OfertaEducativa__c = null;
            oportunidad.Grupo__c = null;
        }
    }

    
    public void modificaRadio(){ // Para la selección de un grupo, también determina la oferta relacionada (y sus pagos, consecuentemente)
        Grupo__c grupoSeleccionado = new Grupo__c();
        Map<Id,Double> pagosSeleccionados = new Map<Id,Double>();
        for(Grupo__c grupo: grupos){
            if(grupo.Id==IdGrupoSeleccionado){
                IdCortoGrupo = IdGrupoSeleccionado.substring(0,15);
                grupoSeleccionado = grupo;
                
                for(OfertaConceptoPagos__c pago: pagos){
                    if(pago.OfertaEducativa__c==grupo.OfertaEducativa__c){
                        pagosSeleccionados.put(pago.ConceptoPago__c,pago.Monto__c);
                    }
                }
                break;
            }
        }
        
        oportunidad.Inscripcion__c = 0.0;
        oportunidad.ExamenAdmision__c = 0.0;
        oportunidad.Colegiatura__c = 0.0;
        oportunidad.Antologia__c = 0.0;
        oportunidad.Propedeutico__c = 0.0;
        oportunidad.Uniforme__c = 0.0;
        
        for(Catalogo__c cat: conceptosPagos){// Después se ejecuta un Trigger que sobreescribe esta información
            if(pagosSeleccionados.containsKey(cat.Id)){
                if(pagosSeleccionados.get(cat.Id)>0){
                    if( cat.Name=='Inscripción' ) 		{oportunidad.Inscripcion__c = pagosSeleccionados.get(cat.Id);}
                    if( cat.Name=='Examen de admisión' ){ oportunidad.ExamenAdmision__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Colegiatura' )		{ oportunidad.Colegiatura__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Antología' )			{ oportunidad.Antologia__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Propedeutico' )		{ oportunidad.Propedeutico__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Uniforme' )			{ oportunidad.Uniforme__c = pagosSeleccionados.get(cat.Id); }
                }
            }
        }
        
        if( oportunidad.FichaMovil__c != null){
            oportunidad.Colegiatura__c = fichaMovil.Importe__c;
            oportunidad.PorcentajeBeca__c = fichaMovil.Descuento__c;
            oportunidad.LetraBeca__c = null;
            oportunidad.ExamenAdmision__c = 0;
            oportunidad.Inscripcion__c = 0;
            oportunidad.Antologia__c = 0;
            oportunidad.Propedeutico__c = 0;
            oportunidad.Uniforme__c = 0;
        }
        
        oportunidad.OfertaEducativa__c = grupoSeleccionado.OfertaEducativa__c;
        oportunidad.Grupo__c = IdGrupoSeleccionado;
        grupoSeleccionadoName = grupoSeleccionado.Name;        
        try{
            ofertaSeleccionada = [SELECT Id, Name, Modalidad__c, Nivel__c, Periodo__c, Beca__c FROM OfertaEducativa__c WHERE Id=:oportunidad.OfertaEducativa__c LIMIT 1 ];
        }catch(Exception e){}
        
        inicializaBeca();
        incializaSolicitudPromocion();
        inicializaDescuento();
        
        actualizaImporteTotal();
        setBecaAplicada();
    }/* TERMINA DE OBTENER CONDICIONES DE OFERTA ACADEMICA PARA SELECCION DE GRUPO */
    
    
    /*
    public void inicializaBeca(){
        if(oportunidad==null){oportunidad = new Opportunity();}
        listaBecasConvenio = new List<SelectOption>();
        porcentajeBeca = new List<SelectOption>();
        becaOferta = new Beca__c();
        becasConvenio = new List<BecaConvenioAsignacion__c>();
        becaRango = new List<SelectOption>();
        
        try{
            aplicaPromocionCero = [SELECT Id, Name 
                                   FROM Descuento__c 
                                   WHERE TipoDescuento__c='Promoción 0' 
                                   AND (
                                       //una opción general
                                       (Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=null AND Periodo__c=null) 
                                       OR (Nivel__c=null AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=null) 
                                       OR (Nivel__c=null AND Modalidad__c=null AND Periodo__c=:oportunidad.Periodo__c)
                                       
                                       //dos opciones
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=null) 
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=null AND Periodo__c=:oportunidad.Periodo__c) 
                                       OR(Nivel__c=null AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c) 
                                       
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c)
                                   )
                                   LIMIT 1];
            if(aplicaPromocionCero!=null){
                oportunidad.DisponiblePromocionCero__c = true;
            }
        }catch(Exception e){
            
        }
        
        
        if(oportunidad.TipoBeca__c!= null){
            if(oportunidad.TipoBeca__c!= ''){
                //seleccionaBeca();
            }
        }
    }
    */
    
    public void inicializaBeca(){
        if(oportunidad==null){oportunidad = new Opportunity();}
        listaBecasConvenio = new List<SelectOption>();
        listaBecasConvenioAsignacion = new List<SelectOption>();
        porcentajeBeca = new List<SelectOption>();
        becaOferta = new Beca__c();
        becasConvenio = new List<BecaConvenioAsignacion__c>();
        MapaBecasConvenioAsignacion = new Map<Id,BecaConvenioAsignacion__c>();
        MapaBecasConvenio = new Map<Id,BecaConvenioAsignacion__c>();
        becasConvenioSolicitadas= new Map<id,SolicitudBeca__c>();
        solicitudBeca = new SolicitudBeca__c();
        //becaRango = new List<SelectOption>();
        
        try{
            aplicaPromocionCero = [SELECT Id, Name, RecordType.Name, Periodo__c, Nivel__c, Modalidad__c, NivelTodos__c, ModalidadTodas__c, Descuento__r.Vigente__c,Descuento__r.Name,
                                   Descuento__r.FechaInicioVigencia__c, Descuento__r.FechaFinVigencia__c, Descuento__r.PorcentajeDescuento__c, Descuento__r.Estatus__c 
                                   FROM BecaConvenioAsignacion__c 
                                   WHERE RecordType.Name='Descuento' AND Descuento__r.TipoDescuento__c='Promoción 0' AND Descuento__r.Vigente__c=true AND Descuento__r.Estatus__c='Activo'
                                   
                                   AND (//Todas las opciones devueltas deben corresponder a un sólo padre Descuento__c, por tanto tienen el mismo porcentajeDescuento
                                       (NivelTodos__c=true AND ModalidadTodas__c=true AND PeriodosTodos__c=true)
                                       
                                       OR (Nivel__c=:oportunidad.Nivel__c AND ModalidadTodas__c=true AND PeriodosTodos__c=true) 
                                       OR (NivelTodos__c=true AND Modalidad__c=:oportunidad.Modalidad__c AND PeriodosTodos__c=true) 
                                       OR (NivelTodos__c=true AND ModalidadTodas__c=true AND Periodo__c=:oportunidad.Periodo__c)
                                       
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND PeriodosTodos__c=true) 
                                       OR(Nivel__c=:oportunidad.Nivel__c AND ModalidadTodas__c=true AND Periodo__c=:oportunidad.Periodo__c) 
                                       OR(NivelTodos__c=true AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c) 
                                       
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c)
                                   )
                                   AND Descuento__r.PorcentajeDescuento__c!=null
                                   ORDER BY Descuento__r.PorcentajeDescuento__c DESC
                                   LIMIT 1];
            if(aplicaPromocionCero!=null){
                oportunidad.DisponiblePromocionCero__c = true;
            }
        }catch(Exception e){
            
            //oportunidad.DisponiblePromocionCero__c = false;
        }
        
        
        if(oportunidad.TipoBeca__c!= null){
            if(oportunidad.TipoBeca__c!= ''){
                seleccionaBeca();
            }
        }
    }
    public void incializaSolicitudPromocion(){
        solicitudPromocionRegistrada=false;
        if(oportunidad.Beca__c!=null){
            obtenerRequisitosBeca();
        }
        solicitudPromocion = new Descuento__c(TipoDescuento__c='Promoción Solicitada',Estatus__c='Inactivo');
        oportunidad.SolicitudPromocion__c=false;
        leyendaSolicitudPromocion='';
        try{
            if(oportunidad.Id!=null){
                solicitudPromocion = [SELECT Id, Name, TipoDescuento__c,PorcentajeDescuento__c,FechaInicioVigencia__c,FechaFinVigencia__c,Comentarios__c, Estatus__c 
                                      FROM Descuento__c 
                                      WHERE Oportunidad__c =: oportunidad.Id 
                                      AND TipoDescuento__c='Promoción Solicitada'
                                      AND (Estatus__c='Inactivo' OR Estatus__c='Activo')
                                      LIMIT 1];
                importeSolicitud=Integer.valueOf(solicitudPromocion.PorcentajeDescuento__c);
                solicitudPromocionRegistrada=true;
                oportunidad.SolicitudPromocion__c=true;
                if(solicitudPromocion.Estatus__c=='Inactivo'){
                    leyendaSolicitudPromocion ='Solicitud pendiente de aprobación';
                }else{
                    leyendaSolicitudPromocion ='Solicitud aprobada';
                }
            }
        }catch(Exception e){}
    }
    
    /* SELECCION DE BECAS */
    public void seleccionaBeca(){
        solicitudBeca = new SolicitudBeca__c();
        obtenerRequisitosBeca();
        if(oportunidad.TipoBeca__c =='Comercial'){
            
            if(oportunidad.OfertaEducativa__c==null){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Para poder generar una Beca, antes debe seleccionar un grupo' ));
                return;
            }else{
                List<Lead> medidorLead = [SELECT id, OwnerId, LetraBeca__c FROM Lead WHERE OwnerId =: UserInfo.getUserId() AND TipoBeca__c = 'Comercial' AND periodo__c =: oportunidad.Periodo__c];
                List<Opportunity> medidorOpp = [SELECT id, OwnerId, LetraBeca__c FROM Opportunity WHERE OwnerId =: UserInfo.getUserId() AND StageName = 'Aspirante' AND TipoBeca__c = 'Comercial' AND periodo__c =: oportunidad.Periodo__c];
                List<PuntajeBeca__c> puntajes = [SELECT Name, Valor__c FROM PuntajeBeca__c];
                Map<String, Decimal> mapPuntajes = new Map<String, Decimal>();
                for(PuntajeBeca__c value: puntajes){
                    mapPuntajes.put(value.Name, value.Valor__c);
                }
                
                promotorAverage = 0;
                for(Lead ldPromotor: medidorLead){
                    if( (ldPromotor.LetraBeca__c != null || ldPromotor.LetraBeca__c != '')  && mapPuntajes.containsKey(ldPromotor.LetraBeca__c) ){
                    	promotorAverage += mapPuntajes.get(ldPromotor.LetraBeca__c);
                    }
                }
                
                for(Opportunity oppPromotor: medidorOpp){
                    if( (oppPromotor.LetraBeca__c != null || oppPromotor.LetraBeca__c != '') && mapPuntajes.containsKey(oppPromotor.LetraBeca__c)){
                    	promotorAverage += mapPuntajes.get(oppPromotor.LetraBeca__c);
                    }
                }
                
                Boolean existeRegistro = false; // Este codigo sirve para determinar si existe un registro en SolicitudBeca__c
                
                solicitudBecaComercial = new SolicitudBeca__c();
                try{
                    solicitudBecaComercial = [SELECT Id, Estatus__c, Lead__c, Oportunidad__c, Name, Beca__c, Porcentaje__c, LetraBecaComercial__c, AsignacionBecaConvenio__c, NombreConvenio__c, TipoBeca__c 
                                              FROM SolicitudBeca__c 
                                              WHERE TipoBeca__c = 'Comercial' 
                                              AND Beca__c=:ofertaSeleccionada.Beca__c 
                                              AND Oportunidad__c =: oportunidad.Id 
                                              AND Oportunidad__c!=null 
                                              AND Estatus__c ='Inactivo' LIMIT 1 ];
                }catch(Exception e){
                    solicitudBecaComercial = new SolicitudBeca__c();
                }
                System.debug(solicitudBecaComercial);
                if(solicitudBecaComercial.Id!=null){
                    LetraBecaString = solicitudBecaComercial.LetraBecaComercial__c;                    
                }
                else{
                    //Verifica que la beca haya sido aprobada
                    SolicitudBeca__c solicitudBecaComercial2 = new SolicitudBeca__c();
                    solicitudBecaComercial2 = [SELECT Id, Estatus__c, Lead__c, Oportunidad__c, Name, Beca__c, Porcentaje__c, LetraBecaComercial__c, AsignacionBecaConvenio__c, NombreConvenio__c, TipoBeca__c 
                                              FROM SolicitudBeca__c 
                                              WHERE TipoBeca__c = 'Comercial' 
                                              AND Beca__c=:ofertaSeleccionada.Beca__c 
                                              AND Oportunidad__c =: oportunidad.Id 
                                              AND Oportunidad__c!=null 
                                              AND Estatus__c ='Activo' LIMIT 1 ];
                    if(solicitudBecaComercial2.Id!=null){
                    	LetraBecaString = solicitudBecaComercial2.LetraBecaComercial__c;   
                        solicitudBecaComercial = solicitudBecaComercial2;
                    }
                }
                String ofe = oportunidad.OfertaEducativa__c;
                becaOferta = new Beca__c();
                try{
                    becaOferta = (Beca__c)Database.query('SELECT  '+String.join(new List<String>(SObjectType.Beca__c.Fields.getMap().keySet()), ', ')+' FROM Beca__c WHERE OfertaEducativa__c =: ofe LIMIT 1');
                    oportunidad.Beca__c=becaOferta.Id;
                    porcentajeBeca = new List<SelectOption>();
                    porcentajeBeca.add(new SelectOption('','-Selecciona un porcentaje-'));
                    
                    
                    if((oportunidad.SubOrigenCandidato__c=='Calcula tu colegiatura' || oportunidad.SubOrigenCandidato__c=='Preinscripción')  && oportunidad.BecaInicial__c !=null ){
                        porcentajeBeca.add(new SelectOption( ' ' ,String.valueOf(Integer.valueOf(oportunidad.BecaInicial__c))+'*' ));
                    }                    
                    mapaLetrasBeca = new Map<String,Double>();
                    
                    List<String> LetrasComercial = new List<String>{'A','B','C','D','E','F','G','H'};
                        
                        if(oportunidad.BecaInicial__c!=null){
                            mapaLetrasBeca.put('Landing', oportunidad.BecaInicial__c);
                        }
                    
                    mapaLetrasBeca.put('A', becaOferta.A__c);
                    mapaLetrasBeca.put('B', becaOferta.B__c);
                    mapaLetrasBeca.put('C', becaOferta.C__c);
                    mapaLetrasBeca.put('D', becaOferta.D__c);
                    mapaLetrasBeca.put('E', becaOferta.E__c);
                    mapaLetrasBeca.put('F', becaOferta.F__c);
                    mapaLetrasBeca.put('G', becaOferta.G__c);
                    mapaLetrasBeca.put('H', becaOferta.H__c);
                    
                    //se limitan las opciones si ya hay una solicitud generada
                    if(solicitudBecaComercial.Id!=null){
                        porcentajeBeca.add( new SelectOption( solicitudBecaComercial.LetraBecaComercial__c ,String.valueOf(Integer.valueOf(solicitudBecaComercial.Porcentaje__c))) ); 
                    }else{
                        for(String letra: LetrasComercial){
                            if(mapaLetrasBeca.get(letra) != null){
                                if(mapaLetrasBeca.get(letra)>0){
                                    if(oportunidad.PorcentajeBeca__c == mapaLetrasBeca.get(letra)){
                                        LetraBecaString = letra;
                                    }
                                    if(mapaLetrasBeca.get(letra)!=oportunidad.BecaInicial__c){
                                        porcentajeBeca.add( new SelectOption( letra ,String.valueOf(Integer.valueOf(mapaLetrasBeca.get(letra)))) ); 
                                    }
                                }
                            }
                        }
                    }
                    if(porcentajeBeca.size()<=1){
                        PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La beca asociada no tiene importes válidos' ));
                        return;
                    }  
                }catch(Exception e){
                    //PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La oferta asignada no contiene ninguna Beca ' ));
                    return;
                }
                
                if(oportunidad.Id != null){
                    if(solicitudBecaComercial.Id == null && promotorAverage < 0){
                        solicitudBeca.Id = null;
                        //solicitudBeca.Estatus__c = 'Inactivo';
                        solicitudBeca.TipoBeca__c = 'Comercial';
                    }else{
                        solicitudBeca = solicitudBecaComercial;
                    }
                }else if(promotorAverage < 0){
                    solicitudBeca.Id = null;
                    //solicitudBeca.Estatus__c = 'Inactivo';
                    solicitudBeca.TipoBeca__c = 'Comercial';
                }
                
                /*
                if(oportunidad.PorcentajeBeca__c!=null){
                    if(oportunidad.PorcentajeBeca__c>0){
                        PorcentajeBecaString = String.valueOf( Integer.valueOf(oportunidad.PorcentajeBeca__c));
                    }else if(solicitudBecaComercial.Id!=null && solicitudBecaComercial.Estatus__c=='Inactivo'){
                        PorcentajeBecaString= String.valueOf(solicitudBecaComercial.Porcentaje__c);
                    }
                }
                */
                
                //Se selecciona un valor de beca por defaul si ya existe el registro o una solicitud
                if(oportunidad.PorcentajeBeca__c!=null){
                    if(oportunidad.PorcentajeBeca__c>0){
                        if(oportunidad.LetraBeca__c==null||oportunidad.LetraBeca__c==' '||oportunidad.LetraBeca__c==''){
                            LetraBecaString=' ';
                        }else{
                            LetraBecaString = oportunidad.LetraBeca__c;
                        }
                        //PorcentajeBecaString = String.valueOf( Integer.valueOf(candidato.PorcentajeBeca__c));
                    }else if(solicitudBecaComercial.Id!=null && solicitudBecaComercial.Estatus__c=='Inactivo'){
                        LetraBecaString = solicitudBecaComercial.LetraBecaComercial__c;
                        //PorcentajeBecaString= String.valueOf(solicitudBecaComercial.Porcentaje__c);
                    }
                }
                
            }
            
        }else if(oportunidad.TipoBeca__c =='Convenio'){
            
            List<Id> idBecasConvenio = new List<Id>();
            
            if(oportunidad.Plantel__c!=null && oportunidad.Nivel__c!=null && oportunidad.Programa__c!=null){
                try{
                    becasConvenio = [SELECT Id, Name, Baja__c, Nivel__c, Plantel__c, Periodo__c, Programa__c, PlantelTodos__c, ProgramaTodos__c, NivelTodos__c,
                                     Tipo_de_porcentaje__c, Inicial__c, Final__c, Incrementos__c, PorcentajeBeca__c,
                                     BecaConvenio__c, BecaConvenio__r.Name, BecaConvenio__r.PorcentajeBeca__c, BecaConvenio__r.Inicial__c, BecaConvenio__r.Final__c, 
                                     BecaConvenio__r.Incrementos__c, BecaConvenio__r.TipoPorcentaje__c,BecaConvenio__r.TipoBeca__c , BecaConvenio__r.NombreConvenio__c, 
                                     BecaConvenio__r.RequiereAutorizacion__c 
                                     
                                     FROM BecaConvenioAsignacion__c 
                                     WHERE BecaConvenio__r.TipoBeca__c='Convenio' AND BecaConvenio__r.EstatusBeca__c ='Activo'
                                     AND (
                                         (NivelTodos__c=true AND PlantelTodos__c=true AND ProgramaTodos__c=true) 
                                         
                                         //una opción general
                                         OR (Nivel__c=:oportunidad.Nivel__c AND PlantelTodos__c=true AND ProgramaTodos__c=true) 
                                         OR (NivelTodos__c=true AND Plantel__c=:oportunidad.Plantel__c AND ProgramaTodos__c=true) 
                                         OR (NivelTodos__c=true AND PlantelTodos__c=true AND Programa__c=:oportunidad.Programa__c)
                                         
                                         //dos opciones
                                         OR(Nivel__c=:oportunidad.Nivel__c AND Plantel__c=:oportunidad.Plantel__c AND ProgramaTodos__c=true) 
                                         OR(Nivel__c=:oportunidad.Nivel__c AND PlantelTodos__c=true AND Programa__c=:oportunidad.Programa__c) 
                                         OR(NivelTodos__c=true AND Plantel__c=:oportunidad.Plantel__c AND Programa__c=:oportunidad.Programa__c) 
                                         
                                         OR(Nivel__c=:oportunidad.Nivel__c AND Plantel__c=:oportunidad.Plantel__c AND Programa__c=:oportunidad.Programa__c)
                                     )
                                     LIMIT 100];
                    
                    
                    //Map<String,BecaConvenioAsignacion__c> mapaBecasConvenio = new Map<String,BecaConvenioAsignacion__c>();
                    
                    MapaBecasConvenioAsignacion = new Map<Id,BecaConvenioAsignacion__c>();
                    MapaBecasConvenio = new Map<Id,BecaConvenioAsignacion__c>();
                    /* La lista 'listaBecasConvenio' muestra los nombres de convenio asignados (del objeto Beca__c), la lista listaBecasConvenioAsignacion almacena los Id del objeto BecaConvenioAsignacion__c */
                    listaBecasConvenio = new List<SelectOption>();
                    listaBecasConvenio.add(new SelectOption('','-Selecciona un nombre de convenio-'));
                    
                    for(BecaConvenioAsignacion__c beca: becasConvenio){
                        idBecasConvenio.add(beca.Id);
                        
                        if(!MapaBecasConvenioAsignacion.containsKey(beca.Id)){
                            MapaBecasConvenioAsignacion.put(beca.Id,beca);
                        }
                        
                        if(beca.BecaConvenio__c!=null && beca.BecaConvenio__r.NombreConvenio__c!=null){
                            if(!mapaBecasConvenio.containsKey(beca.BecaConvenio__c)){
                                mapaBecasConvenio.put(beca.BecaConvenio__c,beca);
                                listaBecasConvenio.add(new SelectOption(beca.BecaConvenio__c,beca.BecaConvenio__r.NombreConvenio__c));
                            }
                        }
                    }
                    
                    if(oportunidad.Beca__c!=null){
                        setBecaAplicada();
                    }else{
                        if(listaBecasConvenio.size()<=1){
                            oportunidad.BecaConvenioAsignacion__c = null;
                            listaBecasConvenioAsignacion = new List<SelectOption>();
                            PorcentajeBecaRango = null;
                            becaRango = new List<SelectOption>();
                            listaBecasConvenioAsignacion = new List<SelectOption>();
                            oportunidad.BecaConvenioAsignacion__c = null;
                            oportunidad.Beca__c=null;
                        }
                    }
                }catch(Exception e){
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, e.getMessage()+ e.getLineNumber()+becasConvenio ));
                }
                try{
                    
                    for(SolicitudBeca__c becaSol: [SELECT Id, Name, AsignacionBecaConvenio__c, Beca__c, Estatus__c, LetraBecaComercial__c, NombreConvenio__c, Porcentaje__c, TipoBeca__c, Oportunidad__c 
                                                   FROM SolicitudBeca__c 
                                                   WHERE Oportunidad__c=:oportunidad.Id AND Oportunidad__c!=null AND  (Estatus__c='Activo' OR Estatus__c='Inactivo') ]){
                        if(!becasConvenioSolicitadas.containsKey(becaSol.Id)){
                            becasConvenioSolicitadas.put(becaSol.AsignacionBecaConvenio__c ,becaSol);
                        }
                    }
                }catch(Exception e){}
                
                
            }else{
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Se debe seleccionar un grupo para poder asignar descuentos' ));
            }
        }
        actualizaImporteTotal();
        
        
    }
    public void setBecaAplicada(){
        oportunidad.NombreConvenio__c =null;
        obtenerRequisitosBeca();
        if(oportunidad.TipoBeca__c =='Comercial'){ // Si es comercial, la lista incluye porcentajes en cadena
			            
            if(LetraBecaString == null){
                oportunidad.PorcentajeBeca__c = 0;
                oportunidad.LetraBeca__c = null;
                solicitudBeca = new SolicitudBeca__c();
                oportunidad.Beca__c = null;
                return;
            }
            
			
            if(mapaLetrasBeca.containsKey(LetraBecaString)){
                porcentajeSolicitadoBeca = mapaLetrasBeca.get(LetraBecaString);
            }
            
            solicitudBecaComercial = new SolicitudBeca__c();
            try{
                solicitudBecaComercial = [SELECT Id, Estatus__c, Oportunidad__c, Name, Beca__c, Porcentaje__c, LetraBecaComercial__c, AsignacionBecaConvenio__c, NombreConvenio__c, TipoBeca__c 
                                          FROM SolicitudBeca__c 
                                          WHERE TipoBeca__c = 'Comercial' 
                                          AND Beca__c=:ofertaSeleccionada.Beca__c 
                                          AND Oportunidad__c =: oportunidad.Id 
                                          AND Oportunidad__c !=null 
                                          AND (Estatus__c ='Activo' OR Estatus__c ='Inactivo')
                                          AND LetraBecaComercial__c =: LetraBecaString LIMIT 1 ];
            }catch(Exception e){
                solicitudBecaComercial = new SolicitudBeca__c();
            }
            if(solicitudBecaComercial.Id!=null){
                solicitudBeca= solicitudBecaComercial;
            }else{
                solicitudBeca = new SolicitudBeca__c();
                solicitudBeca.Beca__c = ofertaSeleccionada.Beca__c;
                solicitudBeca.Name = 'Solicitud '+oportunidad.Name;
                solicitudBeca.Estatus__c = 'Inactivo';
                solicitudBeca.Oportunidad__c = oportunidad.Id==null ? null : oportunidad.Id;
                solicitudBeca.TipoBeca__c = 'Comercial';
                if(mapaLetrasBeca.containsKey(LetraBecaString)){
                    solicitudBeca.Porcentaje__c = mapaLetrasBeca.get(LetraBecaString);
                }
                solicitudBeca.LetraBecaComercial__c = LetraBecaString;
            }
            
            // Si se selecciona comercial entra en una validación
            // 1.- La beca viene de Landing 		? se asigna % sin letra : 2 ;
            // 2.- La beca requiere de aprobación 	? 3 : se coloca valor;
            // 3.- Esta aprobada 					? se asigna : se queda en cero/vacío;
            
            if((oportunidad.SubOrigenCandidato__c=='Calcula tu colegiatura' || oportunidad.SubOrigenCandidato__c=='Preinscripción') && LetraBecaString==' ' && oportunidad.BecaInicial__c!=null ){//condición 1
                oportunidad.PorcentajeBeca__c = oportunidad.BecaInicial__c;
                oportunidad.LetraBeca__c = null;
                solicitudBeca = new SolicitudBeca__c();
                oportunidad.Beca__c = null;
            }else{
                oportunidad.Beca__c = ofertaSeleccionada.Beca__c;
                
                if( LetraBecaString == solicitudBeca.LetraBecaComercial__c && solicitudBeca.Estatus__c!=null ){//condición 2
                    
                    if(solicitudBeca.Estatus__c=='Inactivo'){//condición 3
                        oportunidad.PorcentajeBeca__c = 0;
                        oportunidad.LetraBeca__c = null;
                    }else{
                        oportunidad.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                        oportunidad.LetraBeca__c = solicitudBeca.LetraBecaComercial__c;
                    }
                }else{
                    oportunidad.LetraBeca__c = LetraBecaString;
                    oportunidad.PorcentajeBeca__c = mapaLetrasBeca.get(LetraBecaString);
                }
                
            }
            
            tipoBecaConvenio = null;
            oportunidad.BecaConvenioAsignacion__c = null;
            oportunidad.NombreConvenio__c = null;
            
        }else if(oportunidad.TipoBeca__c =='Convenio'){// La lista incluye id de objeto Beca__c
            
            List<BecaConvenioAsignacion__c> becasConveniosAsignacion = new  List<BecaConvenioAsignacion__c>();
            
            listaBecasConvenioAsignacion = new List<SelectOption>();
            listaBecasConvenioAsignacion.add(new SelectOption('','-Selecciona un nombre de convenio-'));
            
            BecaConvenioAsignacion__c becaAux = new BecaConvenioAsignacion__c();
            
            //BecaConvenioAsignacion__c beca = MapaBecasConvenioAsignacion.get(oportunidad.Beca__c)
            
            if(mapaBecasConvenio.containsKey(oportunidad.Beca__c)){
                BecaConvenioAsignacion__c beca = mapaBecasConvenio.get(oportunidad.Beca__c);
                becaAux=beca;
                listaBecasConvenioAsignacion.add(new SelectOption(beca.Id,beca.Name));
                
                if(listaBecasConvenioAsignacion.size()==2){
                    oportunidad.BecaConvenioAsignacion__c=becaAux.Id;
                    seleccionBecaConvenioAsignacion();
                }
            }
            oportunidad.LetraBeca__c=null;
            /*
            for(BecaConvenioAsignacion__c beca: becasConvenio){
                if(beca.BecaConvenio__c==oportunidad.Beca__c){
                    if(beca.BecaConvenio__r.TipoPorcentaje__c=='Fijo'){
                        tipoBecaConvenio = 'Fijo';
                        oportunidad.PorcentajeBeca__c = beca.BecaConvenio__r.PorcentajeBeca__c;
                        for(SelectOption becaConvenioActual: listaBecasConvenio){
                            if(becaConvenioActual.getValue()!=''){
                                if(oportunidad.Beca__c==becaConvenioActual.getValue()){
                                    oportunidad.NombreConvenio__c = becaConvenioActual.getLabel();
                                    break;
                                }
                            }
                        }
                    }else if(beca.BecaConvenio__r.TipoPorcentaje__c=='Rango'){
                        tipoBecaConvenio = beca.BecaConvenio__r.TipoPorcentaje__c;
                        becaRango = new List<SelectOption>();
                        becaRango.add(new SelectOption('','-Selecciona un porcentaje-'));
                        
                        for(Integer i=Integer.valueOf(beca.BecaConvenio__r.Inicial__c); i<=Integer.valueOf(beca.BecaConvenio__r.Final__c); i+=Integer.valueOf(beca.BecaConvenio__r.Incrementos__c)){
                            becaRango.add(new SelectOption(String.valueOf(i),String.valueOf(i)));                            
                        }
                        
                        if(oportunidad.PorcentajeBeca__c!=null && oportunidad.TipoBeca__c =='Convenio' && oportunidad.Beca__c!=null){
                            PorcentajeBecaRango = String.valueOf(oportunidad.PorcentajeBeca__c);
                            setBecaConvenioRango();
                        }
                    }else{
                        tipoBecaConvenio = null;
                    }
                    break;
                }
            } 
            */
        }
    }
    public void setBecaConvenioRango(){
        BecaConvenioAsignacion__c beca = MapaBecasConvenioAsignacion.get(oportunidad.BecaConvenioAsignacion__c);
        obtenerRequisitosBeca();
        if(PorcentajeBecaRango!=null){
            //porcentajeSolicitadoBeca = Integer.valueOf(PorcentajeBecaRango);
            
            if(!beca.BecaConvenio__r.RequiereAutorizacion__c){//=>no requiere autorización
                oportunidad.PorcentajeBeca__c = Integer.valueOf(PorcentajeBecaRango);
            }else{//sí requiere autorización
                if(solicitudBeca.Id!=null || solicitudBeca.Estatus__c!='Activo'){
                    oportunidad.PorcentajeBeca__c = 0;
                }
                if(solicitudBeca.Estatus__c=='Activo' && solicitudBeca.Id!=null){
                    oportunidad.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                }
                /*if(solicitudBeca.Id!=null && solicitudBeca.Estatus__c=='Activo'){
                    oportunidad.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                    PorcentajeBecaRango = String.valueOf(solicitudBeca.Porcentaje__c);
                }
                else{
                    oportunidad.PorcentajeBeca__c = 0;
                }*/
            }
            actualizaImporteTotal();
            
            if(MapaBecasConvenio.containsKey(oportunidad.Beca__c)){
                BecaConvenioAsignacion__c BecaAsig = MapaBecasConvenio.get(oportunidad.Beca__c);
                oportunidad.NombreConvenio__c = BecaAsig.BecaConvenio__r.NombreConvenio__c;
            }
        }
        /*
        oportunidad.PorcentajeBeca__c = Integer.valueOf(PorcentajeBecaRango);
        
        for(SelectOption becaConvenioActual: listaBecasConvenio){
            if(becaConvenioActual.getValue()!=''){
                if(oportunidad.Beca__c==becaConvenioActual.getValue()){
                    oportunidad.NombreConvenio__c = becaConvenioActual.getLabel();
                    break;
                }
            }
        }
        actualizaImporteTotal(); */
    }
    
    /*Cambios 06/07/2016 */
    
    public void guardaSolicitudBeca(){
        try{
            if(oportunidad.Id!=null){
                if(oportunidad.TipoBeca__c =='Convenio'){
                    if( tipoBecaConvenio=='Rango' ){
                        if(PorcentajeBecaRango!=null && PorcentajeBecaRango!='0'){
                            solicitudBeca.Porcentaje__c = Integer.valueOf(PorcentajeBecaRango);
                            upsert solicitudBeca;
                        }else{
                            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'ERROR: Se debe seleccionar un porcentaje para poder crear la solicitud de Beca' ));
                            return;
                        }
                    }else{
                        upsert solicitudBeca;
                    }
                }else if(oportunidad.TipoBeca__c =='Comercial'){//Es comercial
                    //solicitudBeca.Porcentaje__c = Integer.valueOf(candidato.PorcentajeBeca__c);
                    //solicitudBeca.LetraBecaComercial__c = candidato.LetraBeca__c;
                    //solicitudBeca.Name = candidato.FirstName + ' ' + candidato.LastName;
                    //solicitudBeca.Lead__c = candidato.Id;
                    upsert solicitudBeca;
                    seleccionaBeca();
                }
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'Se ha registrado la solicitud de Beca exitosamente' ));
            }else{
                if(oportunidad.TipoBeca__c =='Convenio'){
                    if( tipoBecaConvenio=='Rango' ){
                        if(PorcentajeBecaRango!=null && PorcentajeBecaRango!='0'){
                            solicitudBeca.Porcentaje__c = Integer.valueOf(PorcentajeBecaRango);
                        }else{
                            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'ERROR: Se debe seleccionar un porcentaje para poder crear la solicitud de Beca' ));
                            return;
                        }
                    }
                }else if(oportunidad.TipoBeca__c =='Comercial'){// Es comercial
                    //solicitudBeca.Porcentaje__c = Integer.valueOf(oportunidad.PorcentajeBeca__c);
                    //solicitudBeca.LetraBecaComercial__c = oportunidad.LetraBeca__c;
                    
                }
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'La solicitud se ha almacenado con la información proporcionada y será guardada junto al registro del candidato' ));
            }
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'fallo creación de registro '+e.getMessage()+e.getLineNumber()  ));
        }
    }
    
    public void seleccionBecaConvenioAsignacion(){
        if(MapaBecasConvenioAsignacion.containsKey(oportunidad.BecaConvenioAsignacion__c)){
            
            BecaConvenioAsignacion__c beca = MapaBecasConvenioAsignacion.get(oportunidad.BecaConvenioAsignacion__c);
            solicitudBeca = new SolicitudBeca__c();
            
            if(beca.Tipo_de_porcentaje__c=='Fijo'){
                
                tipoBecaConvenio = 'Fijo';
                porcentajeSolicitadoBeca = beca.PorcentajeBeca__c;
                if(!beca.BecaConvenio__r.RequiereAutorizacion__c ){
                    oportunidad.PorcentajeBeca__c = beca.PorcentajeBeca__c;
                    solicitudBeca = new SolicitudBeca__c();
                }else{
                    if(becasConvenioSolicitadas.containsKey(beca.id)){
                        solicitudBeca = becasConvenioSolicitadas.get(beca.id);
                    }else{
                        solicitudBeca = new SolicitudBeca__c(Name='Solicitud '+oportunidad.Name , AsignacionBecaConvenio__c=beca.Id, Beca__c=oportunidad.Beca__c, Estatus__c='Inactivo', Oportunidad__c=oportunidad.Id, TipoBeca__c='Convenio', Porcentaje__c=beca.PorcentajeBeca__c );
                    }
                    oportunidad.PorcentajeBeca__c = 0;
                }
                actualizaImporteTotal();
                
                if(MapaBecasConvenio.containsKey(oportunidad.Beca__c)){
                    BecaConvenioAsignacion__c BecaAsig = MapaBecasConvenio.get(oportunidad.Beca__c);
                    oportunidad.NombreConvenio__c = BecaAsig.BecaConvenio__r.NombreConvenio__c;
                }
                
                
                
                obtenerRequisitosBeca();
            }else if(beca.Tipo_de_porcentaje__c=='Rango'){
                tipoBecaConvenio = beca.Tipo_de_porcentaje__c;
                becaRango = new List<SelectOption>();
                
                if(!beca.BecaConvenio__r.RequiereAutorizacion__c){
                    solicitudBeca = new SolicitudBeca__c();
                }else{
                    if(becasConvenioSolicitadas.containsKey(beca.id)){
                        solicitudBeca = becasConvenioSolicitadas.get(beca.id);
                    }else{
                        solicitudBeca = new SolicitudBeca__c(Name='Solicitud '+oportunidad.Name, AsignacionBecaConvenio__c=beca.Id, Beca__c=oportunidad.Beca__c, Estatus__c='Inactivo', Oportunidad__c=oportunidad.Id, TipoBeca__c='Convenio' );
                        solicitudBeca.Porcentaje__c =null;
                    }
                    
                }
                
                if(solicitudBeca.Id!=null){//Se muestra sólo el porcentaje solicitado
                    if(solicitudBeca.Id!=null && solicitudBeca.Estatus__c=='Activo'){
                        oportunidad.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                    }
                    becaRango.add(new SelectOption(String.valueOf(solicitudBeca.Porcentaje__c),String.valueOf(solicitudBeca.Porcentaje__c)));
                    PorcentajeBecaRango = String.valueOf(solicitudBeca.Porcentaje__c);
                }else{//Se muestra selección de todos los porcentajes posibles
                    becaRango.add(new SelectOption('','-Selecciona un porcentaje-'));
                    for(Integer i=Integer.valueOf(beca.Inicial__c); i<=Integer.valueOf(beca.Final__c); i+=Integer.valueOf(beca.Incrementos__c)){
                        becaRango.add(new SelectOption(String.valueOf(i),String.valueOf(i)));                            
                    }
                }
                
                
                if(oportunidad.PorcentajeBeca__c!=null && oportunidad.TipoBeca__c =='Convenio' && oportunidad.Beca__c!=null){
                    PorcentajeBecaRango = String.valueOf(oportunidad.PorcentajeBeca__c);
                    setBecaConvenioRango();
                }
                
            }else{
                tipoBecaConvenio = null;
            }
        }
    }
    
    public void obtenerRequisitosBeca(){
        requisitosBecas = new List<RequisitoBeca__c>();
        map<String,RequisitoBeca__c> mapaRequisitosBeca = new map<String,RequisitoBeca__c>();
        tieneRequisitos = false;
        if(oportunidad.TipoBeca__c=='Convenio'){
        
            
            try{
                if(oportunidad.Beca__c!=null){
                    
                    //la validación de que no se repitan conceptos de pago debería hacerse desde el llenado de BDD, pero es algo que se tiene pendiente por el momento
                    for(RequisitoBeca__c requisito: [SELECT Id, Name, Beca__c, NombreConvenio__c, Requisito__c FROM RequisitoBeca__c WHERE Beca__c=:oportunidad.Beca__c ]){
                        if(!mapaRequisitosBeca.containsKey(requisito.Name)){
                            mapaRequisitosBeca.put(requisito.Name,requisito);
                            requisitosBecas.add(requisito);
                        }
                    }
                    
                    if(requisitosBecas.size()>0){
                        tieneRequisitos = true;
                    }
                }
            }catch(Exception e){}
            actualizaImporteTotal();
        }
    }
    /*********************/
    
    /*
    public void inicializaDescuento(){
        if(oportunidad.OfertaEducativa__c!=null){
            try{
                descuentoVigente = [SELECT Id, Name, TipoDescuento__c, FechaInicioVigencia__c, FechaFinVigencia__c, Modalidad__c, Nivel__c, Periodo__c, PorcentajeDescuento__c 
                                    FROM Descuento__c 
                                    WHERE Vigente__c=TRUE 
                                    AND TipoDescuento__c='Descuento individual vigente'
                                    AND (
                                       //una opción general
                                       (Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=null AND Periodo__c=null) 
                                       OR (Nivel__c=null AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=null) 
                                       OR (Nivel__c=null AND Modalidad__c=null AND Periodo__c=:oportunidad.Periodo__c)
                                       
                                       //dos opciones
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=null) 
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=null AND Periodo__c=:oportunidad.Periodo__c) 
                                       OR(Nivel__c=null AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c) 
                                       
                                       OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c)
                                   )
                                    LIMIT 1];
            }catch(Exception e){
                System.debug(e.getMessage()+'  '+e.getLineNumber());
            }
        }
    }
    */
    public void inicializaDescuento(){
        //mayorDescuentoGeneral=0;
        //Si el candidato u oportunidad vienen de Landing Page, se tiene que validar el porcentaje que se ha generado desde ahí vs el %descuentoVigente, se aplicará el mayor Descuento
       /* if( oportunidad.SubOrigenCandidato__c=='Preinscripción' || oportunidad.SubOrigenCandidato__c=='Calculadora' ){
            mayorDescuentoGeneral = oportunidad.PorcentajeDescuento__c;
        }*/
		descuentoIndividualVigente=0;
        
        if(oportunidad.OfertaEducativa__c!=null){
            descuentoVigente = new BecaConvenioAsignacion__c();
            //descuentoIndividualVigente=0;
            try{
                descuentoVigente = [SELECT Id, Name, RecordType.Name, Periodo__c, Nivel__c, Modalidad__c, NivelTodos__c, ModalidadTodas__c, Descuento__r.Vigente__c,Descuento__r.Name,
                                      Descuento__r.FechaInicioVigencia__c, Descuento__r.FechaFinVigencia__c, Descuento__r.PorcentajeDescuento__c, Descuento__r.Estatus__c 
                                      FROM BecaConvenioAsignacion__c 
                                      WHERE RecordType.Name='Descuento' AND Descuento__r.TipoDescuento__c='Descuento Individual Vigente' AND Descuento__r.Vigente__c=true AND Descuento__r.Estatus__c='Activo'
                                      AND (//Todas las opciones devueltas deben corresponder a un sólo padre Descuento__c, por tanto tienen el mismo porcentajeDescuento
                                          (NivelTodos__c=true AND ModalidadTodas__c=true AND PeriodosTodos__c=true)
                                          
                                          OR (Nivel__c=:oportunidad.Nivel__c AND ModalidadTodas__c=true AND PeriodosTodos__c=true) 
                                          OR (NivelTodos__c=true AND Modalidad__c=:oportunidad.Modalidad__c AND PeriodosTodos__c=true) 
                                          OR (NivelTodos__c=true AND ModalidadTodas__c=true AND Periodo__c=:oportunidad.Periodo__c)
                                          
                                          OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND PeriodosTodos__c=true) 
                                          OR(Nivel__c=:oportunidad.Nivel__c AND ModalidadTodas__c=true AND Periodo__c=:oportunidad.Periodo__c) 
                                          OR(NivelTodos__c=true AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c) 
                                          
                                          OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c)
                                      )
                                      LIMIT 1];
                
                if(descuentoVigente.Descuento__r.PorcentajeDescuento__c!=null){
                    descuentoIndividualVigente=descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                }
                //descuentoIndividualVigente = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                /*if(mayorDescuentoGeneral < descuentoVigente.Descuento__r.PorcentajeDescuento__c ){
                    mayorDescuentoGeneral = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                }*/
            }catch(Exception e){
            }
        }
    }
    
    public void guardaSolicitudPromocion(){
        try{
            if(oportunidad.Id==null){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Debe guardar el registro de la oportunidad antes de poder registrar una promoción'));
            }else{
                solicitudPromocion.PorcentajeDescuento__c=Double.valueOf(importeSolicitud);
                
                if(solicitudPromocion.PorcentajeDescuento__c==null ||
                   solicitudPromocion.FechaInicioVigencia__c==null ||
                   solicitudPromocion.FechaFinVigencia__c==null || 
                   solicitudPromocion.Comentarios__c==null
                  ){
                      PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Debe llenar todos los campos obligatorios' ));
                      return;
                  }                
                
                if(solicitudPromocion.PorcentajeDescuento__c < 0 || solicitudPromocion.PorcentajeDescuento__c>100){
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'El porcentaje de descuento debe estar entre 0 y 100' ));
                    return;
                }
                
                solicitudPromocion.recordTypeId = [SELECT Id, Name FROM RecordType WHERE Name='Promoción Solicitada' LIMIT 1].Id;
                solicitudPromocion.Name='Solicitud '+oportunidad.Name;
                solicitudPromocion.Oportunidad__c = oportunidad.Id;
                upsert solicitudPromocion;
                oportunidad.SolicitudPromocion__c = true;
                oportunidad.VigenciaDescuento__c = solicitudPromocion.FechaFinVigencia__c;
                leyendaSolicitudPromocion ='Solicitud pendiente de aprobación';
                solicitudPromocionRegistrada=true;
                upsert oportunidad;
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'Se ha registrado la promoción exitosamente' ));
            }
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, e.getMessage()+ e.getLineNumber() ));
        }
    }
    /* TERMINA MODULO DE BECA / DESCUENTOS */
    
    
    
    public void guardar(){
        try{
            //Los campos de selección asociados a ofertas académicas son requeridos por el motor de prospectos
            String camposFaltantes='';
            if(oportunidad.AccountId    ==null ){camposFaltantes=camposFaltantes+' | Cuenta asociada |'; }
            if(oportunidad.CloseDate    ==null ){camposFaltantes=camposFaltantes+' | Fecha de Cierre |'; }
            if(oportunidad.Modalidad__c ==null ){camposFaltantes=camposFaltantes+' | Modalidad |'; }
            if(oportunidad.Plantel__c   ==null ){camposFaltantes=camposFaltantes+' | Plantel |'; }
            if(oportunidad.Nivel__c     ==null ){camposFaltantes=camposFaltantes+' | Nivel |'; }
            if(oportunidad.Programa__c  ==null ){camposFaltantes=camposFaltantes+' | Programa |'; }
            if(oportunidad.Periodo__c   ==null ){camposFaltantes=camposFaltantes+' | Periodo |'; }
            if(oportunidad.StageName    ==null ){camposFaltantes=camposFaltantes+' | Etapa |'; }
            
            if(camposFaltantes!=''){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Se deben llenar todos los campos obligatorios:  '+camposFaltantes) );
                return;
            }else{
                if(oportunidad.id==null){
                    cuentaAsociada = [SELECT Id, Name FROM Account WHERE Id =: oportunidad.AccountId];
                    // El grupo debe ser consistente con los datos de la oferta seleccionados
                    //System.debug('AccountName: '+ opp.Account.Name);
                    oportunidad.Name = cuentaAsociada.Name;
                    //System.debug('Nombre despues de encontrar accountName: '+ oportunidad.Name);
                }
                Boolean coincide = false;
                for(grupoWrapped grupoW: listaGrupos){
                    if(grupoW.grupo.Id==oportunidad.Grupo__c){
                        coincide = true;
                        break;
                    }
                }
                if(coincide){
                    if(oportunidad.Id==null){
                        oportunidad.ModificadoERP__c=true;
                    }
                    if(solicitudBeca.Id != null){
                           SolicitudBeca__c solicitudBecaActualizada = [SELECT Estatus__c, LetraBecaComercial__c, Porcentaje__c FROM SolicitudBeca__c WHERE Id=: solicitudBeca.Id];
                           if(oportunidad.TipoBeca__c=='Comercial' && solicitudBecaActualizada.Estatus__c!=null){
                               if(solicitudBecaActualizada.Estatus__c=='Activo'){
                                   oportunidad.PorcentajeBeca__c = solicitudBecaActualizada.Porcentaje__c;
                                   oportunidad.LetraBeca__c = solicitudBecaActualizada.LetraBecaComercial__c;
                               }else{
                                   oportunidad.PorcentajeBeca__c = 0;
                               }
                           }
                       }else{
                           oportunidad.PorcentajeBeca__c = 0;
                       }
                       upsert oportunidad;
                    
                    if(oportunidad.FichaMovil__c != null){
                        fichaMovil.Oportunidad__c = oportunidad.Id;
                        update fichaMovil;
                    }
                    
                    
                    if(solicitudBeca.Id==null && solicitudBeca.Oportunidad__c==null && solicitudBeca.Estatus__c!=null){
                        solicitudBeca.Oportunidad__c = oportunidad.Id;
                        
                        if(cuentaAsociada==null && oportunidad.AccountId!=null){
                            cuentaAsociada = [SELECT Id, Name FROM Account WHERE Id =: oportunidad.AccountId];
                            solicitudBeca.Name = cuentaAsociada.Name;
                        }else{
                            solicitudBeca.Name = 'Solicitud '+ oportunidad.Name;
                        }
                        
                        //solicitudBeca.Name = 'Solicitud '+oportunidad.FirstName +' '+ oportunidad.LastName;
                        upsert solicitudBeca;
                    }
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'La información se guardo correctamente' ));
                    guardoOk=true;
                }else{
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'El grupo que se ha seleccionado no coincide con los campos de la oferta académica') );
                }
                
            }
          System.debug('Opp: '+ oportunidad);  
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'LEAD:   '+oportunidad+'   '+ e.getMessage() + e.getLineNumber()));
        }
    }
    
}