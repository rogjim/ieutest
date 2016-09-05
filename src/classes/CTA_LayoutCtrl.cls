public class CTA_LayoutCtrl {
    
    public Account cuenta {get;set;}
    public Contact contacto {get;set;}
    public String idCuenta {get;set;}
    
    public Date fechaActual {get;set;}
    public List<SelectOption> profesiones {get;set;}
    
    //listas de selección, cargan de Ubicacion__c de forma dependiente. 
    //Se llenan de forma diferenciada listas y objetos, debido a las necesidades de búsqueda del objeto.
    public List<Ubicacion__c> listaPaises {get{return UtilsOferta.getPaises();}set;}
    public List<SelectOption> paises {get;set;}
    public List<Ubicacion__c> listaEstados {get;set;}
    public List<SelectOption> estados {get;set;}
    public List<SelectOption> municipios {get;set;}
    
    
    
    public CTA_LayoutCtrl(ApexPages.StandardController stdController){
        idCuenta = System.currentPagereference().getParameters().get('Id');
        System.debug('idCuenta NUEVO '+ idCuenta);
        
        if(idCuenta!=null){
            cuenta = (Account)Database.query('SELECT '+String.join(new List<String>(SObjectType.Account.Fields.getMap().keySet()), ', ')+' FROM Account WHERE Id =: idCuenta');
              System.debug('idCuenta NUEVO 2'+ cuenta.Id);
            contacto = [SELECT Id, FirstName, LastName FROM contact WHERE AccountId=:cuenta.Id LIMIT 1];
        }else{
            cuenta=new Account();
            contacto= new Contact();
        }
        inicializaObjetos();
    }
    
    private void inicializaObjetos(){
        fechaActual  = date.today();
        
        profesiones= new List<SelectOption>();
        profesiones.add(new SelectOption('','-- Seleccione una profesión --'));
        for(Catalogo__c prof: [SELECT Id, Name, TipoCatalogo__c, IdProfesion__c, Descripcion__c, NombreCampoCandidato__c, Orden__c FROM Catalogo__c WHERE IdProfesion__c!=null] ){
            profesiones.add(new SelectOption(prof.Id,prof.Name));
        }
        
        
        // CONDICIONES INICIALES PARA UBICACIÓN
        paises = new List<SelectOption>();
        paises.add(new SelectOption('','- Seleccione un país -'));
        
        for(Ubicacion__c country: listaPaises){
            paises.add(new SelectOption(country.Id,country.Name));
            if(country.Name=='MEXICO' && cuenta.Pais__c==null){
                cuenta.Pais__c=country.Id;
            }
        }
        System.debug(paises);
        System.debug(listaPaises);
        
        if(cuenta.Pais__c!=null){ getEstados(); }
        else{
            cuenta.Estado__c=cuenta.Municipio__c=null;
            estados = new List<SelectOption>();
            estados.add(new SelectOption('','- Debe seleccionar un país -'));
            listaEstados = new List<Ubicacion__c>();
            municipios = new List<SelectOption>();
            municipios.add(new SelectOption('','- Debe seleccionar un estado -'));
        }
        if(cuenta.Estado__c!=null){ getMunicipios(); }
        else{
            cuenta.Municipio__c=null;
            municipios = new List<SelectOption>();
            municipios.add(new SelectOption('','- Debe seleccionar un estado -'));
        }
    }
    
    
    /* MODULO DE UBICACIONES */
    public void getEstados(){
        Ubicacion__c paisActual = new Ubicacion__c();
        for(Ubicacion__c place: listaPaises){
            if(cuenta.Pais__c==place.Id){
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
            cuenta.EstadoOtro__c=null;
            if(cuenta.Estado__c!=null){
                getMunicipios();
            }
        }else{
            cuenta.Estado__c=null;
            municipios = new List<SelectOption>();
            municipios.add(new SelectOption('','No disponible'));
        }
    }
    public void getMunicipios(){
        Ubicacion__c state = new Ubicacion__c();
        for(Ubicacion__c place: listaEstados){
            if(cuenta.Estado__c==place.Id){
                state=place;
                break;
            }
        }
        municipios = UtilsOferta.getMunicipios(state.IdUbicacion__c);
        
        
    }/* TERMINA DE OBTENER UBICACIONES */
    
    
    public void save(){
        try{
            String camposFaltantes='';
            if(cuenta.PersonEmail == null ){camposFaltantes+=' | Correo electrónico |'; }
            if(contacto.LastName == null ){camposFaltantes=camposFaltantes+' | Apellido paterno |'; }
            if(contacto.FirstName == null ){camposFaltantes=camposFaltantes+' | Nombre |'; }
            cuenta.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId();
            if(idCuenta == null){
                cuenta.LastName = contacto.LastName;
            }
            if(camposFaltantes!=''){
                PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Se deben llenar todos los campos obligatorios:  '+camposFaltantes) );
                return;
            }else{
                upsert contacto;
                upsert cuenta;
            }
            
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'La información se guardo correctamente' ));
        }catch(Exception e){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'CTA:   '+cuenta+'   Causa: '+e.getCause()+' '+cuenta.LastName+' '+cuenta.ApeMaterno__c+' '+ e.getMessage() + e.getLineNumber()));
        }
    }

}