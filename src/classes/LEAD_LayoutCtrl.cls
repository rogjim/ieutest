public with sharing class LEAD_LayoutCtrl {
    
    /*  Validaciones y reglas de negocio en el documento *ValidacionesCapturaManual*  */
    public Lead candidato {get;set;}
    public String idLead {get;set;}
    public Decimal promotorAverage {get; set;}
    public Boolean isOverBecas {get; set;}
    public Boolean tieneFichaMovil {get; set;}
    
    
    public date fechaActual{get;set;}
    public Boolean guardoOk{get;set;}
    
    public List<SelectOption> profesiones {get;set;}
    
    //listas de selección, cargan de Ubicacion__c de forma dependiente.
    //Se llenan de forma diferenciada listas y objetos, debido a las necesidades de búsqueda del objeto.
    public List<Ubicacion__c> listaPaises {get{return UtilsOferta.getPaises();}set;}
    public List<SelectOption> paises {get;set;}
    public List<Ubicacion__c> listaEstados {get;set;}
    public List<SelectOption> estados {get;set;}
    public List<SelectOption> municipios {get;set;}
    
    
    //listas de selección para oferta acádemica, cargan de Catalogo__c, Plantel__c y Periodo__c de forma dependiente
    public List<SelectOption> modalidades {get;set;}
    public List<SelectOption> planteles {get;set;}
    public List<SelectOption> niveles {get;set;}
    public List<SelectOption> programas {get;set;}
    public List<SelectOption> periodos {get;set;}
    public List<OfertaEducativa__c> ofertasEducativas {get;set;}
    public List<Id> idOfertasEducativas {get;set;}
    public List<OfertaConceptoPagos__c> pagos {get;set;}
    
    //Variable para controlar fichas moviles
    public FichaPago__c fichaMovil {get;set;}
    
    //la clase envolvente incluye al objeto de Pagos y de Grupos, coincidentes con los filtros de oferta elegible
    public List<grupoWrapped> listaGrupos {get;set;}
    public List<Grupo__c> grupos {get;set;}
    public List<Catalogo__c> conceptosPagos {get{
        return [SELECT Id, Name, ConceptoFijo__c, MontoCostoFijo__c FROM Catalogo__c WHERE TipoCatalogo__c='Concepto Pagos' ORDER BY Name LIMIT 100];
    }set;}
    public String IdGrupoSeleccionado {get;set;}
    public String IdCortoGrupo {get;set;}
    public String grupoSeleccionadoName {get;set;}
    
    
    //Beca
    public Beca__c becaOferta {get;set;}
    public OfertaEducativa__c ofertaSeleccionada {get;set;}
    
    public Boolean requiereAutorizacion {get; set;}
    
    //Beca comercial
    public List<SelectOption> porcentajeBeca {get;set;}
    public String PorcentajeBecaString {get;set;}
    public Map<String,Double> mapaLetrasBeca {get;set;}
    public String LetraBecaStringA {get;set;}
    
    public SolicitudBeca__c solicitudBecaComercial {get;set;}
    //Beca convenio
    public List<BecaConvenioAsignacion__c> becasConvenio {get;set;}
    public Map<Id,BecaConvenioAsignacion__c> MapaBecasConvenioAsignacion {get;set;}
    public Map<Id,BecaConvenioAsignacion__c> MapaBecasConvenio {get;set;}
    
    public Boolean tieneRequisitos {get;set;}
    public List<SelectOption> listaBecasConvenio {get;set;}
    public List<SelectOption> listaBecasConvenioAsignacion {get;set;}
    public String PorcentajeBecaRango {get;set;}
    public List<SelectOption> becaRango {get;set;}
    public String tipoBecaConvenio {get;set;}
    
    public Map<id,SolicitudBeca__c> becasConvenioSolicitadas {get;set;}
    public SolicitudBeca__c solicitudBeca {get;set;}
    public Double porcentajeSolicitadoBeca {get;set;}
    
    public Double importeTotal {get;set;}
    public Double inscripcionConDescuento {get;set;}
    public Double colegiaturaConDescuento {get;set;}
    //Descuento
    public BecaConvenioAsignacion__c descuentoVigente {get;set;}
    public Double mayorDescuentoGeneral {get;set;}
    public Double descuentoIndividualVigente {get;set;}
    public BecaConvenioAsignacion__c aplicaPromocionCero {get;set;}
    public Descuento__c solicitudPromocion {get;set;}
    public String leyendaSolicitudPromocion {get;set;}
    public Boolean solicitudPromocionRegistrada {get;set;}
    public Integer importeSolicitud {get;set;}
    
    public List<RequisitoBeca__c> requisitosBecas {get;set;}
    
    public LEAD_LayoutCtrl(ApexPages.StandardController stdController){
        idLead = System.currentPagereference().getParameters().get('Id');
        if(idLead!=null){
            candidato = (Lead)Database.query('SELECT GrupoAsignado__r.Name, Plantel__r.Name, Nivel__r.Name, Periodo__r.Name,'+String.join(new List<String>(SObjectType.Lead.Fields.getMap().keySet()), ', ')+' FROM Lead WHERE Id =: idLead');
        }else{
            candidato = new Lead();
        }
        tieneFichaMovil = true;
        if(candidato.FichaMovil__c == null){
            tieneFichaMovil = false;
        }
        isOverBecas = false;
        inicializaObjetos();
        
        sObjectType target = Schema.getGlobalDescribe().get('Account');
        
        List<String> lis = Utils.getListCampos(target);
        requiereAutorizacion = false;
    }
    
    private void inicializaObjetos(){
        modalidades= UtilsOferta.getModalidades();
        fechaActual  = date.today();
        guardoOk=false;
        
        mayorDescuentoGeneral=0;
        if( (candidato.SubOrigenCandidato__c=='Preinscripción' || candidato.SubOrigenCandidato__c=='Calcula tu colegiatura') && candidato.DescuentoInicial__c!=null){
            mayorDescuentoGeneral = candidato.DescuentoInicial__c;
        }
        
        profesiones= new List<SelectOption>();
        profesiones.add(new SelectOption('','-- Seleccione una profesión --'));
        for(Catalogo__c prof: [SELECT Id, Name, TipoCatalogo__c, IdProfesion__c, Descripcion__c, NombreCampoCandidato__c, Orden__c FROM Catalogo__c WHERE IdProfesion__c!=null ORDER BY Name] ){
            profesiones.add(new SelectOption(prof.Id,prof.Name));
        }
        
        requisitosBecas = new List<RequisitoBeca__c>();
        
        IdGrupoSeleccionado = candidato.GrupoAsignado__c;
        grupoSeleccionadoName = candidato.GrupoAsignado__r.Name;
        IdCortoGrupo = IdGrupoSeleccionado==null?'': IdGrupoSeleccionado.substring(0,15);
        
        idOfertasEducativas = new List<Id>();
        grupos = new List<Grupo__c>(); 
        listaGrupos = new List<grupoWrapped>();
        
        // CONDICIONES INICIALES PARA UBICACIÓN
        paises = new List<SelectOption>();
        paises.add(new SelectOption('','- Seleccione un país -'));
        
        for(Ubicacion__c country: listaPaises){
            paises.add(new SelectOption(country.Id,country.Name));
            if(country.Name=='MEXICO' && candidato.Pais__c==null){
                candidato.Pais__c=country.Id;
            }
        }
        if(candidato.Pais__c!=null){ getEstados(); }
        else{
            candidato.Estado__c=candidato.Municipio__c=null;
            estados = new List<SelectOption>();
            estados.add(new SelectOption('','- Debe seleccionar un país -'));
            listaEstados = new List<Ubicacion__c>();
            municipios = new List<SelectOption>();
            municipios.add(new SelectOption('','- Debe seleccionar un estado -'));
        }
        if(candidato.Estado__c!=null){ getMunicipios(); }
        else{
            candidato.Municipio__c=null;
            municipios = new List<SelectOption>();
            municipios.add(new SelectOption('','- Debe seleccionar un estado -'));
        }
        
        
        // CONDICIONES INICIALES PARA SELECCIÓN DE GRUPO / OFERTA ACADEMICA
        if(candidato.Id==null){candidato.Modalidad__c=null;}
        
        if(candidato.FichaMovil__c!=null){
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
            if(candidato.Modalidad__c!=null){ getPlanteles(); }
            else{
                candidato.Plantel__c=candidato.Nivel__c=candidato.Programa__c=candidato.Periodo__c=null;
                planteles = new List<SelectOption>();
                planteles.add(new SelectOption('','- Debe seleccionar una modalidad -'));
                niveles = new List<SelectOption>();
                niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
            if(candidato.Plantel__c==null){
                candidato.Nivel__c=candidato.Programa__c=candidato.Periodo__c=null;
                niveles = new List<SelectOption>();
                niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
            if(candidato.Nivel__c==null){
                candidato.Programa__c=candidato.Periodo__c=null;
                programas = new List<SelectOption>();
                programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
            if(candidato.Programa__c==null){
                candidato.Periodo__c=null;
                periodos = new List<SelectOption>();
                periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
            }
        }
        
        inicializaBeca();
        incializaSolicitudPromocion();
        inicializaDescuento();
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
        
        if(candidato.AplicaPromocionCero__c && aplicaPromocionCero!=null){
            candidato.PorcentajeDescuento__c=100;
            candidato.VigenciaDescuento__c = aplicaPromocionCero.Descuento__r.FechaFinVigencia__c;
        }else{
            if(solicitudPromocion!=null){
                if( solicitudPromocion.Estatus__c=='Activo' ){
                    candidato.PorcentajeDescuento__c=solicitudPromocion.PorcentajeDescuento__c;
                    candidato.VigenciaDescuento__c = solicitudPromocion.FechaFinVigencia__c;
                }else if(descuentoVigente!=null){
                    if(descuentoVigente.Id!=null && (mayorDescuentoGeneral<=descuentoVigente.Descuento__r.PorcentajeDescuento__c) ){
                        candidato.PorcentajeDescuento__c = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                        candidato.VigenciaDescuento__c = descuentoVigente.Descuento__r.FechaFinVigencia__c;
                    }else{
                        candidato.PorcentajeDescuento__c=mayorDescuentoGeneral;
                    }
                }
            }else {
                if(descuentoVigente!=null){
                    if(descuentoVigente.Id!=null && (mayorDescuentoGeneral<=descuentoVigente.Descuento__r.PorcentajeDescuento__c) ){
                        candidato.PorcentajeDescuento__c = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                        candidato.VigenciaDescuento__c = descuentoVigente.Descuento__r.FechaFinVigencia__c;
                    }else{
                        candidato.PorcentajeDescuento__c=mayorDescuentoGeneral;
                    }
                }else{
                    candidato.PorcentajeDescuento__c=mayorDescuentoGeneral;
                }
            }
        }
        if(candidato.Antologia__c!=null){
            importeTotal+=candidato.Antologia__c;
        }
        if(candidato.Colegiatura__c!=null){
            if(candidato.PorcentajeBeca__c!=null){
                colegiaturaConDescuento=candidato.Colegiatura__c-(candidato.Colegiatura__c*(candidato.PorcentajeBeca__c/100));
            }else{
                colegiaturaConDescuento=candidato.Colegiatura__c;
            }
            importeTotal=importeTotal+colegiaturaConDescuento;
        }
        if(candidato.Inscripcion__c!=null){
            if(candidato.AplicaPromocionCero__c==true){
                inscripcionConDescuento=0;
            }else if(candidato.AplicaPromocionCero__c==false){
                if(candidato.PorcentajeDescuento__c!=null){
                    inscripcionConDescuento=candidato.Inscripcion__c -(candidato.Inscripcion__c * (candidato.PorcentajeDescuento__c/100));
                }else{
                    inscripcionConDescuento=(candidato.Inscripcion__c);
                }
            }
            importeTotal=importeTotal+inscripcionConDescuento;
        }
        if(candidato.ExamenAdmision__c!=null){
            importeTotal=importeTotal+candidato.ExamenAdmision__c;
        }
        if(candidato.Propedeutico__c!=null){
            importeTotal=importeTotal+candidato.Propedeutico__c;
        }
        if(candidato.Uniforme__c!=null){
            importeTotal=importeTotal+candidato.Uniforme__c;
        }
    }
    
    /* MODULO DE UBICACIONES */
    public void getEstados(){
        Ubicacion__c paisActual = new Ubicacion__c();
        for(Ubicacion__c place: listaPaises){
            if(candidato.Pais__c==place.Id){
               paisActual=place;
               break;
            }
        }
        listaEstados = UtilsOferta.getEstados(paisActual.IdUbicacion__c);
        estados = new List<SelectOption>();
        estados.add( new SelectOption('','- Seleccione un estado -') );
        for(Ubicacion__c state: listaEstados){
            estados.add(new SelectOption(state.Id,state.Name));
        }
        municipios = new List<SelectOption>();
        municipios.add(new SelectOption('','- Debe seleccionar un estado -'));
        if(estados.size()>1){
            candidato.EstadoOtro__c=null;
            if(candidato.Estado__c!=null){
                getMunicipios();
            }
        }else{
            candidato.Estado__c=null;
            municipios = new List<SelectOption>();
            municipios.add(new SelectOption('','No disponible'));
        }
    }
    public void getMunicipios(){// Sólo aplica para México
        Ubicacion__c state = new Ubicacion__c();
        for(Ubicacion__c place: listaEstados){
            if(candidato.Estado__c==place.Id){
               state=place;
               break;
            }
        }
        municipios = UtilsOferta.getMunicipios(state.IdUbicacion__c);
    }/* TERMINA DE OBTENER UBICACIONES */
    
    
    
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
        planteles = UtilsOferta.getPlanteles(candidato.Modalidad__c);
        niveles = new List<SelectOption>();
        niveles.add(new SelectOption('','- Debe seleccionar un plantel -'));
        programas = new List<SelectOption>();
        programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
        periodos = new List<SelectOption>();
        periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        for(SelectOption plan: planteles){
            if(plan.getValue()!=''){
                if(plan.getValue()==candidato.Plantel__c){
                    getNiveles();
                    break;
                }
            }
        }
    }
    public void getNiveles(){
        niveles = UtilsOferta.getNiveles(candidato.Plantel__c, candidato.Modalidad__c);
        programas = new List<SelectOption>();
        programas.add(new SelectOption('','- Debe seleccionar un nivel -'));
        periodos = new List<SelectOption>();
        periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        for(SelectOption niv: niveles){
            if(niv.getValue()!=''){
                if(niv.getValue()==candidato.Nivel__c && candidato.FichaMovil__c == null){
                    getProgramas();
                    break;
                }
                if(niv.getValue()==candidato.Nivel__c && candidato.FichaMovil__c != null){
                    getProgramasMovil();
                    break;
                }
            }
        }
    }
    public void getProgramas(){
        programas = UtilsOferta.getProgramas(candidato.Plantel__c, candidato.Modalidad__c , candidato.Nivel__c);
        periodos = new List<SelectOption>();
        periodos.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        for(SelectOption prog: programas){
            if(prog.getValue()!=''){
                if(prog.getValue()==candidato.Programa__c){
                    getPeriodos();
                }
            }
        }
    }
    public void isFichaMovil(){
        fichaMovil = [SELECT id, Lead__c, Periodo__c, Plantel__c, Nivel__c, Importe__c, Descuento__c, RecordType.Name FROM FichaPago__c WHERE Id =: candidato.FichaMovil__c AND RecordType.Name = 'Ficha Móvil'];
        if(fichaMovil.RecordType.Name == 'Ficha Móvil' && (fichaMovil.Lead__c == null||fichaMovil.Lead__c == candidato.Id) ){
            candidato.Plantel__c = fichaMovil.Plantel__c;
            candidato.Periodo__c = fichaMovil.Periodo__c;
            candidato.Nivel__c = fichaMovil.Nivel__c;
            getProgramasMovil();
        }else{
            candidato.FichaMovil__c = null;
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La ficha seleccionada no es de tipo Ficha Móvil o ya se encuentra en uso'));
        }
    }
    public void getProgramasMovil(){
        programas = UtilsOferta.getProgramasMoviles(candidato.FichaMovil__c);
        modalidades = new List<SelectOption>();
        modalidades.add(new SelectOption('','- Debe seleccionar un programa -'));
        listaGrupos = new List<grupoWrapped>();
        Boolean encuentraPrograma = false;
        for(SelectOption prog: programas){
            if(prog.getValue()!=''){
                if(prog.getValue()==candidato.Programa__c && candidato.Programa__c!=null){
                    encuentraPrograma=true;
                    getModalidadesMovil();
                }
            }
        }
        if(!encuentraPrograma){
            System.debug('No Encontró programa');
            candidato.Programa__c=null;
            candidato.Modalidad__c=null;
            candidato.OfertaEducativa__c = null;
            candidato.GrupoAsignado__c = null;
        }
    }
    public void getModalidadesMovil(){
        ofertasEducativas = UtilsOferta.getModalidadesMoviles(candidato.Plantel__c, candidato.Periodo__c, candidato.Nivel__c, candidato.Programa__c);
        modalidades = new List<SelectOption>();
        Map<String,OfertaEducativa__c> mapaModalidad = new Map<String,OfertaEducativa__c>();
        modalidades.add(new SelectOption('','-- Seleccione una modalidad --'));
        idOfertasEducativas= new List<Id>();
        Boolean encuentraModalidad = false;
        try{
            for(OfertaEducativa__c cat: ofertasEducativas){
                if(!mapaModalidad.containsKey(cat.Modalidad__c)){
                    mapaModalidad.put(cat.Modalidad__c, cat);
                    modalidades.add(new SelectOption(cat.Modalidad__c,cat.Modalidad__r.Name));
                    idOfertasEducativas.add(cat.Id);
                }
                if(cat.Modalidad__c ==candidato.Modalidad__c && candidato.Modalidad__c!=null){
                    encuentraModalidad=true;
                    getGrupos();
                } 
            }
        }catch(Exception e){}
        if(!encuentraModalidad){
            System.debug('No Encontró modalidad');
            candidato.Modalidad__c=null;
            candidato.OfertaEducativa__c = null;
            candidato.GrupoAsignado__c = null;
        }
        //getGrupos();
    }
    public void getPeriodos(){
        listaGrupos = new List<grupoWrapped>();
        ofertasEducativas = UtilsOferta.getPeriodos(candidato.Plantel__c, candidato.Modalidad__c, candidato.Nivel__c, candidato.Programa__c);
        periodos = new List<SelectOption>();
        Map<String,OfertaEducativa__c> mapaPeriodos = new Map<String,OfertaEducativa__c>();
        periodos.add(new SelectOption('','-- Seleccione un Periodo --'));
        try{
            for(OfertaEducativa__c cat: ofertasEducativas){
                if(!mapaPeriodos.containsKey(cat.Periodo__c)){
                    mapaPeriodos.put(cat.Periodo__c, cat);
                    periodos.add(new SelectOption(cat.Periodo__c,cat.Periodo__r.Name));
                }
                if(cat.Periodo__c==candidato.Periodo__c){
                   getGrupos();
                }
            }
        }catch(Exception e){}
    }
    /*public void setOffertByPayment(){ Se realiza este proceso en isFichaMovil()
        fichaMovil= (FichaPago__c )Database.query('SELECT '+String.join(new List<String>(SObjectType.FichaPago__c.Fields.getMap().keySet()), ', ')+' FROM FichaPago__c  WHERE Id =: candidato.FichaMovil__c');
        candidato.Nivel__c = fichaMovil.Nivel__c;
        candidato.Periodo__c = fichaMovil.Periodo__c;
        candidato.Plantel__c = fichaMovil.Plantel__c;
        modalidades = new List<SelectOption>();
        modalidades.add(new SelectOption('','-- Seleccione una Modalidad --'));
        try{ //Limitar la consulta de acuerdo a la selección
            for(Catalogo__c cat: [SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c ='Modalidad' LIMIT 100]){
                modalidades.add(new SelectOption(cat.Id,cat.Name));
            }
        }catch(Exception e){}
    }*/
    public void getGrupos(){
        listaGrupos = new List<grupoWrapped>();
        pagos = new List<OfertaConceptoPagos__c>();
        idOfertasEducativas= new List<Id>();
        if(candidato.FichaMovil__c==null){
            try{
                for(OfertaEducativa__c cat: ofertasEducativas){
                    if(cat.Periodo__c==candidato.Periodo__c){
                        idOfertasEducativas.add(cat.Id);
                    }
                }
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }else{
            try{
                for(OfertaEducativa__c cat: ofertasEducativas){
                    if(cat.Modalidad__c==candidato.Modalidad__c){
                        idOfertasEducativas.add(cat.Id);
                    }
                }
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }
        try{
            grupos = (List<Grupo__c>)Database.query('SELECT OfertaEducativa__r.Name, AulaAsignada__r.Name, Docente__r.Name , Materia__r.Name, '+String.join(new List<String>(SObjectType.Grupo__c.Fields.getMap().keySet()), ', ')+' FROM Grupo__c WHERE OfertaEducativa__c IN:idOfertasEducativas LIMIT 100');
            // grupos = (List<Grupo__c>)Database.query('SELECT OfertaEducativa__r.Name, AulaAsignada__r.Name, Docente__r.Name , Materia__r.Name FROM Grupo__c WHERE OfertaEducativa__c IN:idOfertasEducativas LIMIT 100');
            pagos = [SELECT Id, Name, Activo__c, Cantidad__c, ConceptoPago__c, ConceptoFijo__c, Monto__c, OfertaEducativa__c FROM OfertaConceptoPagos__c WHERE OfertaEducativa__c IN :idOfertasEducativas ORDER BY ConceptoPago__c LIMIT 100];
        }catch(Exception e){
            //PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Error '+e.getMessage()+' '+e.getLineNumber() ));
        }
        // Los pagos y los grupos se relacionan con una oferta educativa. 
        // La información de la oferta educativa no es relevante en la tabla (se asignan  valores de oferta sólo cuando se elige al grupo). 
        // Se puede agregar un sólo concepto por cada pago, por ello se usa el mapa pagosGrupos
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
        if(candidato.OfertaEducativa__c!=null){
            modificaRadio();
        }
    }
    public void modificaRadio(){
        // Para la selección de un grupo, también determina la oferta relacionada (y sus pagos, consecuentemente)
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
        candidato.Inscripcion__c = 0.0;
        candidato.ExamenAdmision__c = 0.0;
        candidato.Colegiatura__c = 0.0;
        candidato.Antologia__c = 0.0;
        candidato.Propedeutico__c = 0.0;
        candidato.Uniforme__c = 0.0;
        for(Catalogo__c cat: conceptosPagos){
            // Después se ejecuta un Trigger que sobreescribe esta información, es redundante, pero sirve para proporcionar en este punto información al usuario
            if(pagosSeleccionados.containsKey(cat.Id)){
                if(pagosSeleccionados.get(cat.Id)>0){
                    if( cat.Name=='Inscripción' )       { candidato.Inscripcion__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Examen de admisión' ){ candidato.ExamenAdmision__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Colegiatura' )		{ candidato.Colegiatura__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Antología' )			{ candidato.Antologia__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Propedeutico' )		{ candidato.Propedeutico__c = pagosSeleccionados.get(cat.Id); }
                    if( cat.Name=='Uniforme' )			{ candidato.Uniforme__c = pagosSeleccionados.get(cat.Id); }
                }
            }
        }
        if(candidato.FichaMovil__c != null){
            candidato.Colegiatura__c = fichaMovil.Importe__c;
            candidato.PorcentajeBeca__c = fichaMovil.Descuento__c;
            candidato.LetraBeca__c = null;
            candidato.ExamenAdmision__c = 0;
            candidato.Inscripcion__c = 0;
            candidato.Antologia__c = 0;
            candidato.Propedeutico__c = 0;
            candidato.Uniforme__c = 0;
        }
        candidato.OfertaEducativa__c = grupoSeleccionado.OfertaEducativa__c;
        candidato.GrupoAsignado__c = IdGrupoSeleccionado;
        grupoSeleccionadoName = grupoSeleccionado.Name;        
        try{
            ofertaSeleccionada = [SELECT Id, Name, Modalidad__c, Nivel__c, Periodo__c, Beca__c FROM OfertaEducativa__c WHERE Id=:candidato.OfertaEducativa__c LIMIT 1 ];
        }catch(Exception e){}
        
        inicializaBeca();
        incializaSolicitudPromocion();
        inicializaDescuento();
        
        actualizaImporteTotal();
        setBecaAplicada();
    }/* TERMINA DE OBTENER CONDICIONES DE OFERTA ACADEMICA PARA SELECCION DE GRUPO */
    
    
    public void inicializaBeca(){
        if(candidato==null){candidato = new Lead();}
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
                                       
                                       OR (Nivel__c=:candidato.Nivel__c AND ModalidadTodas__c=true AND PeriodosTodos__c=true) 
                                       OR (NivelTodos__c=true AND Modalidad__c=:candidato.Modalidad__c AND PeriodosTodos__c=true) 
                                       OR (NivelTodos__c=true AND ModalidadTodas__c=true AND Periodo__c=:candidato.Periodo__c)
                                       
                                       OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND PeriodosTodos__c=true) 
                                       OR(Nivel__c=:candidato.Nivel__c AND ModalidadTodas__c=true AND Periodo__c=:candidato.Periodo__c) 
                                       OR(NivelTodos__c=true AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c) 
                                       
                                       OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c)
                                   )
                                   AND Descuento__r.PorcentajeDescuento__c!=null
                                   ORDER BY Descuento__r.PorcentajeDescuento__c DESC
                                   LIMIT 1];
            if(aplicaPromocionCero!=null){
                candidato.DisponiblePromocionCero__c = true;
            }
        }catch(Exception e){
            candidato.DisponiblePromocionCero__c = false;
        }
        if(candidato.TipoBeca__c!= null){
            if(candidato.TipoBeca__c!= ''){
                seleccionaBeca();
            }
        }
    }
    
    public void incializaSolicitudPromocion(){
        solicitudPromocionRegistrada=false;
        if(candidato.Beca__c!=null){
            obtenerRequisitosBeca();
        }
        solicitudPromocion = new Descuento__c(TipoDescuento__c='Promoción Solicitada',Estatus__c='Inactivo');
        candidato.SolicitudPromocion__c=false;
        leyendaSolicitudPromocion='';
        try{
            if(candidato.Id!=null){
                solicitudPromocion = [SELECT Id, Name, TipoDescuento__c,PorcentajeDescuento__c,FechaInicioVigencia__c,FechaFinVigencia__c,Comentarios__c, Estatus__c 
                                      FROM Descuento__c 
                                      WHERE Lead__c =: candidato.Id 
                                      AND TipoDescuento__c='Promoción Solicitada'
                                      AND Estatus__c='Inactivo'
                                      LIMIT 1];
                importeSolicitud=Integer.valueOf(solicitudPromocion.PorcentajeDescuento__c);
                solicitudPromocionRegistrada=true;
                candidato.SolicitudPromocion__c=true;
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
        // "solicitudBecaComercial" define una solicitud existente de beca comercial (pueden existir varias)
        // La información del objeto "solicitudBeca" se llena de forma dinámica a través de la selección de una beca o 
        // 		descuento particular (en base a las reglas de negocio). De esta manera, se guarda el registro (si el 
        // 		candidato ya se insertó) hasta el método guardaSolicitudBeca(). Si el candidato no se ha insertado, la 
        // 		inserción de la solicitud se realiza hasta el método guardar(), justo después de insertar el Lead.
        solicitudBeca = new SolicitudBeca__c();
        obtenerRequisitosBeca();
        if(candidato.TipoBeca__c =='Comercial'){
            if(candidato.OfertaEducativa__c==null){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Para poder generar una Beca, antes debe seleccionar un grupo' ));
                return;
            }else{
                List<Lead> medidorLead = [SELECT id, OwnerId, LetraBeca__c FROM Lead WHERE isConverted = false AND OwnerId =: UserInfo.getUserId() AND TipoBeca__c = 'Comercial' AND periodo__c =: candidato.Periodo__c];
                List<Opportunity> medidorOpp = [SELECT id, OwnerId, LetraBeca__c FROM Opportunity WHERE OwnerId =: UserInfo.getUserId() AND StageName = 'Aspirante' AND TipoBeca__c = 'Comercial' AND periodo__c =: candidato.Periodo__c];
                List<PuntajeBeca__c> puntajes = [SELECT Name, Valor__c FROM PuntajeBeca__c];
                Map<String, Decimal> mapPuntajes = new Map<String, Decimal>();
                for(PuntajeBeca__c value: puntajes){
                    mapPuntajes.put(value.Name, value.Valor__c);
                }
                promotorAverage = 0; // Si promotorAverage<0 => la beca requiere aprobación
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
                    solicitudBecaComercial = [SELECT Id, Estatus__c, Lead__c, Name, Beca__c, Porcentaje__c, LetraBecaComercial__c, AsignacionBecaConvenio__c, NombreConvenio__c, TipoBeca__c 
                                              FROM SolicitudBeca__c 
                                              WHERE TipoBeca__c = 'Comercial' 
                                              AND Beca__c=:ofertaSeleccionada.Beca__c 
                                              AND Lead__c =: candidato.Id AND Lead__c !=null AND Estatus__c ='Inactivo' LIMIT 1 ];
                }catch(Exception e){
                    solicitudBecaComercial = new SolicitudBeca__c();
                }
                System.debug(solicitudBecaComercial);
                String ofe = candidato.OfertaEducativa__c;
                becaOferta = new Beca__c();
                try{
                    becaOferta = (Beca__c)Database.query('SELECT  '+String.join(new List<String>(SObjectType.Beca__c.Fields.getMap().keySet()), ', ')+' FROM Beca__c WHERE OfertaEducativa__c =: ofe LIMIT 1');
                    candidato.Beca__c=becaOferta.Id;
                    porcentajeBeca = new List<SelectOption>();
                    porcentajeBeca.add(new SelectOption('','-Selecciona un porcentaje-'));
                    //Si hay una beca de Landing page asignada por default, se agrega al listado de becas comercial y no requiere de aprobación
                    if((candidato.SubOrigenCandidato__c=='Calcula tu colegiatura' || candidato.SubOrigenCandidato__c=='Preinscripción')  && candidato.BecaInicial__c !=null ){
                        porcentajeBeca.add(new SelectOption( ' ' ,String.valueOf(Integer.valueOf(candidato.BecaInicial__c))+'*' ));
                    }
                    mapaLetrasBeca = new Map<String,Double>();
                    //List<Double> becasComercial = new List<Double>{becaOferta.A__c,becaOferta.B__c,becaOferta.C__c,becaOferta.D__c,becaOferta.E__c,becaOferta.F__c,becaOferta.G__c,becaOferta.H__c};
                    List<String> LetrasComercial = new List<String>{'A','B','C','D','E','F','G','H'};
                        if(candidato.BecaInicial__c!=null){
                            mapaLetrasBeca.put('Landing', candidato.BecaInicial__c);
                        }
                    mapaLetrasBeca.put('A', becaOferta.A__c);
                    mapaLetrasBeca.put('B', becaOferta.B__c);
                    mapaLetrasBeca.put('C', becaOferta.C__c);
                    mapaLetrasBeca.put('D', becaOferta.D__c);
                    mapaLetrasBeca.put('E', becaOferta.E__c);
                    mapaLetrasBeca.put('F', becaOferta.F__c);
                    mapaLetrasBeca.put('G', becaOferta.G__c);
                    mapaLetrasBeca.put('H', becaOferta.H__c);
                    for(String letra: LetrasComercial){
                        if(mapaLetrasBeca.get(letra) != null){
                            if(mapaLetrasBeca.get(letra)>0){
                                if(candidato.PorcentajeBeca__c == mapaLetrasBeca.get(letra)){
                                    LetraBecaStringA = letra;
                                }
                                if(mapaLetrasBeca.get(letra)!=candidato.BecaInicial__c){
                                    porcentajeBeca.add( new SelectOption( letra ,String.valueOf(Integer.valueOf(mapaLetrasBeca.get(letra)))) ); 
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
                if(candidato.Id != null){
                    if(solicitudBecaComercial.Id == null && promotorAverage < 0){
                        solicitudBeca.Id = null;
                        solicitudBeca.TipoBeca__c = 'Comercial';
                    }else{
                        solicitudBeca = solicitudBecaComercial;
                        requiereAutorizacion = false;
                    }
                }else if(promotorAverage < 0){
                    solicitudBeca.Id = null;
                    solicitudBeca.TipoBeca__c = 'Comercial';
                }
                //Se selecciona un valor de beca por default si ya existe el registro o una solicitud
                if(candidato.PorcentajeBeca__c!=null){
                    if(candidato.PorcentajeBeca__c>0){
                        if(candidato.LetraBeca__c==null||candidato.LetraBeca__c==' '||candidato.LetraBeca__c==''){
                            LetraBecaStringA=' ';
                        }else{
                            LetraBecaStringA = candidato.LetraBeca__c;
                        }
                        //PorcentajeBecaString = String.valueOf( Integer.valueOf(candidato.PorcentajeBeca__c));
                    }else if(solicitudBecaComercial.Id!=null && solicitudBecaComercial.Estatus__c=='Inactivo'){
                        LetraBecaStringA = solicitudBecaComercial.LetraBecaComercial__c;
                        //PorcentajeBecaString= String.valueOf(solicitudBecaComercial.Porcentaje__c);
                    }
                }
            }
        }else if(candidato.TipoBeca__c =='Convenio'){
            /* 
				La lista 'listaBecasConvenio' muestra los nombres de convenio asignados (del objeto Beca__c), 
				la lista listaBecasConvenioAsignacion almacena los Id del objeto BecaConvenioAsignacion__c 
			*/
            List<Id> idBecasConvenio = new List<Id>();
            if(candidato.Plantel__c!=null && candidato.Nivel__c!=null && candidato.Programa__c!=null){
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
                                         
                                         OR (Nivel__c=:candidato.Nivel__c AND PlantelTodos__c=true AND ProgramaTodos__c=true) 
                                         OR (NivelTodos__c=true AND Plantel__c=:candidato.Plantel__c AND ProgramaTodos__c=true) 
                                         OR (NivelTodos__c=true AND PlantelTodos__c=true AND Programa__c=:candidato.Programa__c)
                                         
                                         OR(Nivel__c=:candidato.Nivel__c AND Plantel__c=:candidato.Plantel__c AND ProgramaTodos__c=true) 
                                         OR(Nivel__c=:candidato.Nivel__c AND PlantelTodos__c=true AND Programa__c=:candidato.Programa__c) 
                                         OR(NivelTodos__c=true AND Plantel__c=:candidato.Plantel__c AND Programa__c=:candidato.Programa__c) 
                                         
                                         OR(Nivel__c=:candidato.Nivel__c AND Plantel__c=:candidato.Plantel__c AND Programa__c=:candidato.Programa__c)
                                     )
                                     LIMIT 100];
                    //Map<String,BecaConvenioAsignacion__c> mapaBecasConvenio = new Map<String,BecaConvenioAsignacion__c>();
                    MapaBecasConvenioAsignacion = new Map<Id,BecaConvenioAsignacion__c>();
                    MapaBecasConvenio = new Map<Id,BecaConvenioAsignacion__c>();
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
                    if(candidato.Beca__c!=null){
                        setBecaAplicada();
                    }else{
                        if(listaBecasConvenio.size()<=1){
                            candidato.BecaConvenioAsignacion__c = null;
                            listaBecasConvenioAsignacion = new List<SelectOption>();
                            PorcentajeBecaRango = null;
                            becaRango = new List<SelectOption>();
                            listaBecasConvenioAsignacion = new List<SelectOption>();
                            candidato.BecaConvenioAsignacion__c = null;
                            candidato.Beca__c=null;
                        }
                    }
                }catch(Exception e){
                    PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, e.getMessage()+ e.getLineNumber()+becasConvenio ));
                }
                try{
                    for(SolicitudBeca__c becaSol: [SELECT Id, Name, AsignacionBecaConvenio__c, Beca__c, Estatus__c, LetraBecaComercial__c, NombreConvenio__c, Porcentaje__c, TipoBeca__c, Lead__c 
                                                   FROM SolicitudBeca__c 
                                                   WHERE Lead__c=:candidato.Id AND Lead__c!=null AND (Estatus__c='Activo' OR Estatus__c='Inactivo') ]){
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
        candidato.NombreConvenio__c =null;
        obtenerRequisitosBeca();
        if(candidato.TipoBeca__c =='Comercial'){ // Si es comercial, la lista incluye porcentajes en cadena
            if(LetraBecaStringA == null){
                candidato.PorcentajeBeca__c = 0;
                candidato.LetraBeca__c = null;
                solicitudBeca = new SolicitudBeca__c();
                candidato.Beca__c = null;
                return;
            }
            if(mapaLetrasBeca.containsKey(LetraBecaStringA)){
                porcentajeSolicitadoBeca = mapaLetrasBeca.get(LetraBecaStringA);
            }
            solicitudBecaComercial = new SolicitudBeca__c();
            try{
                solicitudBecaComercial = [SELECT Id, Estatus__c, Lead__c, Name, Beca__c, Porcentaje__c, LetraBecaComercial__c, AsignacionBecaConvenio__c, NombreConvenio__c, TipoBeca__c 
                                          FROM SolicitudBeca__c 
                                          WHERE TipoBeca__c = 'Comercial' 
                                          AND Beca__c=:ofertaSeleccionada.Beca__c 
                                          AND Lead__c =: candidato.Id 
                                          AND Lead__c !=null 
                                          AND (Estatus__c ='Activo' OR Estatus__c ='Inactivo')
                                          AND LetraBecaComercial__c =: LetraBecaStringA LIMIT 1 ];
            }catch(Exception e){
                solicitudBecaComercial = new SolicitudBeca__c();
            }
            if(solicitudBecaComercial.Id!=null){
                solicitudBeca= solicitudBecaComercial;
            }else{
                solicitudBeca = new SolicitudBeca__c();
                solicitudBeca.Beca__c = ofertaSeleccionada.Beca__c;
                solicitudBeca.Name = 'Solicitud '+candidato.Name;
                solicitudBeca.Estatus__c = 'Inactivo';
                solicitudBeca.Lead__c = candidato.Id==null ? null : candidato.Id;
                solicitudBeca.TipoBeca__c = 'Comercial';
                if(mapaLetrasBeca.containsKey(LetraBecaStringA)){
                    solicitudBeca.Porcentaje__c = mapaLetrasBeca.get(LetraBecaStringA);
                }
                solicitudBeca.LetraBecaComercial__c = LetraBecaStringA;
            }
            // Si se selecciona comercial entra en una validación
            // 1.- La beca viene de Landing 		? se asigna % sin letra : 2 ;
            // 2.- La beca requiere de aprobación 	? 3 : se coloca valor;
            // 3.- Esta aprobada 					? se asigna : se queda en cero/vacío;
            if((candidato.SubOrigenCandidato__c=='Calcula tu colegiatura' || candidato.SubOrigenCandidato__c=='Preinscripción') && LetraBecaStringA==' ' && candidato.BecaInicial__c!=null ){//condición 1
                candidato.PorcentajeBeca__c = candidato.BecaInicial__c;
                candidato.LetraBeca__c = null;
                solicitudBeca = new SolicitudBeca__c();
                candidato.Beca__c = null;
            }else{
                candidato.Beca__c = ofertaSeleccionada.Beca__c;
                if( LetraBecaStringA == solicitudBeca.LetraBecaComercial__c && solicitudBeca.Estatus__c!=null ){//condición 2
                    if(solicitudBeca.Estatus__c=='Inactivo'){//condición 3
                        candidato.PorcentajeBeca__c = 0;
                        candidato.LetraBeca__c = null;
                    }else{
                        candidato.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                        candidato.LetraBeca__c = solicitudBeca.LetraBecaComercial__c;
                    }
                }else{
                    candidato.LetraBeca__c = LetraBecaStringA;
                    candidato.PorcentajeBeca__c = mapaLetrasBeca.get(LetraBecaStringA);
                }
            }
            tipoBecaConvenio = null;
            candidato.BecaConvenioAsignacion__c = null;
            candidato.NombreConvenio__c = null;
        }else if(candidato.TipoBeca__c =='Convenio'){// La lista incluye id de objeto Beca__c
            List<BecaConvenioAsignacion__c> becasConveniosAsignacion = new  List<BecaConvenioAsignacion__c>();
            listaBecasConvenioAsignacion = new List<SelectOption>();
            listaBecasConvenioAsignacion.add(new SelectOption('','-Selecciona un nombre de convenio-'));
            BecaConvenioAsignacion__c becaAux = new BecaConvenioAsignacion__c();
            //BecaConvenioAsignacion__c beca = MapaBecasConvenioAsignacion.get(candidato.Beca__c)
            if(mapaBecasConvenio.containsKey(candidato.Beca__c)){
                BecaConvenioAsignacion__c beca = mapaBecasConvenio.get(candidato.Beca__c);
                becaAux=beca;
                listaBecasConvenioAsignacion.add(new SelectOption(beca.Id,beca.Name));
                if(listaBecasConvenioAsignacion.size()==2){
                    candidato.BecaConvenioAsignacion__c=becaAux.Id;
                    seleccionBecaConvenioAsignacion();
                }
            }
            candidato.LetraBeca__c=null;
        }
    }
    public void obtenerRequisitosBeca(){ 
        // Aplica sólo cuando la beca es de tipo covenio
        requisitosBecas = new List<RequisitoBeca__c>();
        map<String,RequisitoBeca__c> mapaRequisitosBeca = new map<String,RequisitoBeca__c>();
        tieneRequisitos = false;
        if(candidato.TipoBeca__c=='Convenio'){
            try{
                if(candidato.Beca__c!=null){
                    //La validación de que no se repitan conceptos de pago debería hacerse desde el llenado de BDD, pero es algo que se tiene pendiente por el momento
                    for(RequisitoBeca__c requisito: [SELECT Id, Name, Beca__c, NombreConvenio__c, Requisito__c FROM RequisitoBeca__c WHERE Beca__c=:candidato.Beca__c ]){
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
    public void seleccionBecaConvenioAsignacion(){
        if(MapaBecasConvenioAsignacion.containsKey(candidato.BecaConvenioAsignacion__c)){
            BecaConvenioAsignacion__c beca = MapaBecasConvenioAsignacion.get(candidato.BecaConvenioAsignacion__c);
            solicitudBeca = new SolicitudBeca__c();
            if(beca.Tipo_de_porcentaje__c=='Fijo'){
                tipoBecaConvenio = 'Fijo';
                porcentajeSolicitadoBeca = beca.PorcentajeBeca__c;
                if(!beca.BecaConvenio__r.RequiereAutorizacion__c ){
                    candidato.PorcentajeBeca__c = beca.PorcentajeBeca__c;
                    solicitudBeca = new SolicitudBeca__c();
                }else{
                    if(becasConvenioSolicitadas.containsKey(beca.id)){
                        solicitudBeca = becasConvenioSolicitadas.get(beca.id);
                    }else{
                        solicitudBeca = new SolicitudBeca__c(Name='Solicitud '+candidato.Name , AsignacionBecaConvenio__c=beca.Id, Beca__c=candidato.Beca__c, Estatus__c='Inactivo', Lead__c=candidato.Id, TipoBeca__c='Convenio', Porcentaje__c=beca.PorcentajeBeca__c );
                    }
                    candidato.PorcentajeBeca__c = 0;
                }
                actualizaImporteTotal();
                if(MapaBecasConvenio.containsKey(candidato.Beca__c)){
                    BecaConvenioAsignacion__c BecaAsig = MapaBecasConvenio.get(candidato.Beca__c);
                    candidato.NombreConvenio__c = BecaAsig.BecaConvenio__r.NombreConvenio__c;
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
                        solicitudBeca = new SolicitudBeca__c(Name='Solicitud '+candidato.Name, AsignacionBecaConvenio__c=beca.Id, Beca__c=candidato.Beca__c, Estatus__c='Inactivo', Lead__c=candidato.Id, TipoBeca__c='Convenio' );
                        solicitudBeca.Porcentaje__c =null;
                    }
                }
                if(solicitudBeca.Id!=null){//Se muestra sólo el porcentaje solicitado
                    if(solicitudBeca.Id!=null && solicitudBeca.Estatus__c=='Activo'){
                        candidato.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                    }
                    becaRango.add(new SelectOption(String.valueOf(solicitudBeca.Porcentaje__c),String.valueOf(solicitudBeca.Porcentaje__c)));
                    PorcentajeBecaRango = String.valueOf(solicitudBeca.Porcentaje__c);
                }else{//Se muestra selección de todos los porcentajes posibles
                    becaRango.add(new SelectOption('','-Selecciona un porcentaje-'));
                    for(Integer i=Integer.valueOf(beca.Inicial__c); i<=Integer.valueOf(beca.Final__c); i+=Integer.valueOf(beca.Incrementos__c)){
                        becaRango.add(new SelectOption(String.valueOf(i),String.valueOf(i)));                            
                    }
                }
                if(candidato.PorcentajeBeca__c!=null && candidato.TipoBeca__c =='Convenio' && candidato.Beca__c!=null){
                    PorcentajeBecaRango = String.valueOf(candidato.PorcentajeBeca__c);
                    setBecaConvenioRango();
                }
            }else{
                tipoBecaConvenio = null;
            }
        }
    }
    public void setBecaConvenioRango(){
        BecaConvenioAsignacion__c beca = MapaBecasConvenioAsignacion.get(candidato.BecaConvenioAsignacion__c);
        obtenerRequisitosBeca();
        if(PorcentajeBecaRango!=null){
            //porcentajeSolicitadoBeca = Integer.valueOf(PorcentajeBecaRango);
            if(!beca.BecaConvenio__r.RequiereAutorizacion__c){//=>no requiere autorización
                candidato.PorcentajeBeca__c = Integer.valueOf(PorcentajeBecaRango);
            }else{//sí requiere autorización
                if(solicitudBeca.Id!=null || solicitudBeca.Estatus__c!='Activo'){
                    candidato.PorcentajeBeca__c = 0;
                }
                if(solicitudBeca.Estatus__c=='Activo' && solicitudBeca.Id!=null){
                    candidato.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                }
                /*if(solicitudBeca.Id!=null && solicitudBeca.Estatus__c=='Activo'){
                    candidato.PorcentajeBeca__c = solicitudBeca.Porcentaje__c;
                    PorcentajeBecaRango = String.valueOf(solicitudBeca.Porcentaje__c);
                }
                else{
                    candidato.PorcentajeBeca__c = 0;
                }*/
            }
            actualizaImporteTotal();
            if(MapaBecasConvenio.containsKey(candidato.Beca__c)){
                BecaConvenioAsignacion__c BecaAsig = MapaBecasConvenio.get(candidato.Beca__c);
                candidato.NombreConvenio__c = BecaAsig.BecaConvenio__r.NombreConvenio__c;
            }
        }
    }
    public void guardaSolicitudBeca(){
        try{
            if(candidato.Id!=null){
                if(candidato.TipoBeca__c =='Convenio'){
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
                }else if(candidato.TipoBeca__c =='Comercial'){
                    upsert solicitudBeca;
                    //seleccionaBeca();
                }
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'Se ha registrado la solicitud de Beca exitosamente' ));
            }else{
                if(candidato.TipoBeca__c =='Convenio'){
                    if( tipoBecaConvenio=='Rango' ){
                        if(PorcentajeBecaRango!=null && PorcentajeBecaRango!='0'){
                            solicitudBeca.Porcentaje__c = Integer.valueOf(PorcentajeBecaRango);
                        }else{
                            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'ERROR: Se debe seleccionar un porcentaje para poder crear la solicitud de Beca' ));
                            return;
                        }
                    }
                }
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'La solicitud se ha almacenado con la información proporcionada y será guardada junto al registro del candidato' ));
            }
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'fallo creación de registro '+e.getMessage()+e.getLineNumber()  ));
        }
    }
    public void inicializaDescuento(){
        //Si el candidato viene de Landing Page, se tiene que validar el porcentaje que se ha generado desde ahí %mayorDescuentoGeneral vs el %descuentoVigente, se aplicará el mayor Descuento
        descuentoIndividualVigente=0;
        if(candidato.OfertaEducativa__c!=null){
            descuentoVigente = new BecaConvenioAsignacion__c();
            try{
                descuentoVigente = [SELECT Id, Name, RecordType.Name, Periodo__c, Nivel__c, Modalidad__c, NivelTodos__c, ModalidadTodas__c, Descuento__r.Vigente__c,Descuento__r.Name,
                                      Descuento__r.FechaInicioVigencia__c, Descuento__r.FechaFinVigencia__c, Descuento__r.PorcentajeDescuento__c, Descuento__r.Estatus__c 
                                      FROM BecaConvenioAsignacion__C 
                                      WHERE RecordType.Name='Descuento' AND Descuento__r.TipoDescuento__c='Descuento Individual Vigente' AND Descuento__r.Vigente__c=true AND Descuento__r.Estatus__c='Activo'
                                      AND (//Todas las opciones devueltas deben corresponder a un sólo padre Descuento__c, por tanto tienen el mismo porcentajeDescuento
                                          (NivelTodos__c=true AND ModalidadTodas__c=true AND PeriodosTodos__c=true)
                                          
                                          OR (Nivel__c=:candidato.Nivel__c AND ModalidadTodas__c=true AND PeriodosTodos__c=true) 
                                          OR (NivelTodos__c=true AND Modalidad__c=:candidato.Modalidad__c AND PeriodosTodos__c=true) 
                                          OR (NivelTodos__c=true AND ModalidadTodas__c=true AND Periodo__c=:candidato.Periodo__c)
                                          
                                          OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND PeriodosTodos__c=true) 
                                          OR(Nivel__c=:candidato.Nivel__c AND ModalidadTodas__c=true AND Periodo__c=:candidato.Periodo__c) 
                                          OR(NivelTodos__c=true AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c) 
                                          
                                          OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c)
                                      )
                                      LIMIT 1];
                if(descuentoVigente.Descuento__r.PorcentajeDescuento__c!=null){
                    descuentoIndividualVigente=descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                }
                //if(mayorDescuentoGeneral < descuentoVigente.Descuento__r.PorcentajeDescuento__c ){
                    //mayorDescuentoGeneral = descuentoVigente.Descuento__r.PorcentajeDescuento__c;
                //}
            }catch(Exception e){
            }
        }
    }
    public void guardaSolicitudPromocion(){
        try{
            if(candidato.Id==null){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Debe guardar el registro del candidato antes de poder registrar una promoción'));
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
                solicitudPromocion.Name='Solicitud '+candidato.Name;
                solicitudPromocion.Lead__c = candidato.Id;
                upsert solicitudPromocion;
                candidato.SolicitudPromocion__c=true;
                candidato.VigenciaDescuento__c=solicitudPromocion.FechaFinVigencia__c;
                leyendaSolicitudPromocion ='Solicitud pendiente de aprobación';
                solicitudPromocionRegistrada=true;
                upsert candidato;
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
            if(candidato.Modalidad__c	==null ){camposFaltantes=camposFaltantes+' | Modalidad |'; }
            if(candidato.Email			==null ){camposFaltantes=camposFaltantes+' | Mail |'; }
            if(candidato.Plantel__c		==null ){camposFaltantes=camposFaltantes+' | Plantel |'; }
            if(candidato.Nivel__c		==null ){camposFaltantes=camposFaltantes+' | Nivel |'; }
            if(candidato.Programa__c	==null ){camposFaltantes=camposFaltantes+' | Programa |'; }
            if(candidato.Periodo__c		==null ){camposFaltantes=camposFaltantes+' | Periodo |'; }
            if(candidato.LastName		==null ){camposFaltantes=camposFaltantes+' | Apellido |'; }
            if(candidato.Status			==null ){camposFaltantes=camposFaltantes+' | Estado |'; }
            if(candidato.FirstName		==null ){camposFaltantes=camposFaltantes+' | Nombre |'; }
            if(candidato.Status=='No interesado'&& candidato.MotivoNoInteresado__c==null ){camposFaltantes=camposFaltantes+' | Motivo no interesado |'; }
            if(candidato.Status=='No contactado'&& candidato.MotivoNoContactado__c==null ){camposFaltantes=camposFaltantes+' | Motivo no contactado |'; }
            if(camposFaltantes!=''){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Se deben llenar todos los campos obligatorios:  '+camposFaltantes) );
                return;
            }else{
                   // El grupo debe ser consistente con los datos de la oferta seleccionados
                   Boolean coincide = false;
                   for(grupoWrapped grupoW: listaGrupos){
                       if(grupoW.grupo.Id==candidato.GrupoAsignado__c){
                           coincide = true;
                           break;
                       }
                   }
                   if(coincide){
                       if(candidato.Id==null){
                           candidato.ModificadoERP__c=true;
                       }
                       if(solicitudBeca.Id != null){
                           SolicitudBeca__c solicitudBecaActualizada = [SELECT Estatus__c, LetraBecaComercial__c, Porcentaje__c FROM SolicitudBeca__c WHERE Id=: solicitudBeca.Id];
                           if(candidato.TipoBeca__c=='Comercial' && solicitudBecaActualizada.Estatus__c!=null){
                               if(solicitudBecaActualizada.Estatus__c=='Activo'){
                                   candidato.PorcentajeBeca__c = solicitudBecaActualizada.Porcentaje__c;
                                   candidato.LetraBeca__c = solicitudBecaActualizada.LetraBecaComercial__c;
                               }else{
                                   candidato.PorcentajeBeca__c = 0;
                               }
                           }
                           System.debug(candidato.PorcentajeBeca__c);
                       }else{
                           candidato.PorcentajeBeca__c = 0;
                       }
                       upsert candidato;
                       if(candidato.FichaMovil__c != null){
                           fichaMovil.Lead__c = candidato.Id;
                           update fichaMovil;
                       }
                       if(solicitudBeca.Id==null && solicitudBeca.Lead__c==null && solicitudBeca.Estatus__c!=null){
                           solicitudBeca.Lead__c = candidato.Id;
                           solicitudBeca.Name = 'Solicitud '+candidato.FirstName +' '+ candidato.LastName;
                           upsert solicitudBeca;
                       }
                       PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'La información se guardo correctamente' ));
                       guardoOk=true;
                   }else{
                       PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'El grupo que se ha seleccionado no coincide con los campos de la oferta académica') );
                   }
               }
            System.debug('Lead: ' + candidato);
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'LEAD:   '+candidato+'   '+ e.getMessage() + e.getLineNumber()));
        }
    }
}