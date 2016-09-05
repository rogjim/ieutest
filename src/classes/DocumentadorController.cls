public class DocumentadorController {
    /*Variables Globales*/
    public List<Documentador__c> documentador;
    public List<Documentador__c> documentadorAux;
    public List<Documentador__c> docAll{get;set;}
    public List<Documentador__c> docAllAux{get;set;}
    public List<Documentador__c> docApexClass{get;set;}
    public List<Documentador__c> docApexTrigger{get;set;}
    public List<Documentador__c> docApexStaticResource{get;set;}
    public List<Documentador__c> docApexPage{get;set;}
    
    public List<Documentador__c> docApexComponent{get;set;}
    public List<Documentador__c> docApexConfPersonalizada{get;set;}
    
    
    public List<ApexClass> clases{get;set;}
    public List<ApexTrigger> triggers{get;set;}
    public List<StaticResource> staticresource{get;set;}
    public List<ApexPage> pages{get;set;}
    public List<ApexComponent> components{get;set;}
    //   public List<CustomSetting> confPers{get;set;}
    public String filtroTipo;
    List<Documentador__c> docus;  
    List<Documentador__c> AuxInsertaNuevo  ;  
    List<Documentador__c> AuxActualizar  ;  
    Documentador__c      docu;
    Documentador__c      documentosActualizar;
    
    //default page size
    private  final Integer PAGE_SIZE = 20;
    private    Integer PAGE_SIZEAUX = 0;
    //pagination information
    private integer counter=0;  //keeps track of the offset
    //  private integer list_size=10; //sets the page size or number
    public integer total_size; //used to show user the total size
    public integer inicioidx=0;
    public integer finidx=0;
    List<Id> ids;
    public  Integer contDocus=0;
    Boolean existe=false;
    Integer contclasses=0;
    Integer conttriggers=0;
     Integer contvp=0;
    Integer contsr=0;
    Integer contcomponent=0;
    /*
*Constructor   
*/
    public DocumentadorController(){
        documentador = new List<Documentador__c>();
        documentadorAux = new List<Documentador__c>();
        docAll = new List<Documentador__c>();
        docApexClass = new List<Documentador__c>();
        docApexTrigger = new List<Documentador__c>();
        docApexStaticResource =  new List<Documentador__c>();
        docApexPage =  new List<Documentador__c>();
        docApexComponent =  new List<Documentador__c>();
        clases = [SELECT Id, Name, CreatedDate, LastModifiedDate FROM ApexClass]; 
        triggers = [SELECT Id, Name, CreatedDate, LastModifiedDate FROM ApexTrigger];
        staticresource = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM StaticResource];
        pages = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM ApexPage];
        components = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM ApexComponent];
        //   confPers = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM CustomSetting];
        
    }
    
    /*********Getters and Setters**********/
    public List<Documentador__c> getDocumentador(){
        return this.documentador;
    }
    public List<Documentador__c> getDocumentadorAux(){
        return this.documentadorAux;
    }
    
    /*  public void setDocumentador(Documentador__c documentadors){
this.documentador = documentadors;
} */
    
    public String getFiltroTipo(){
        return this.filtroTipo;
    }
    
    public void setFiltroTipo(String filtroTipo){
        this.filtroTipo = filtroTipo;
    }        
    
    /*
* Actualiza los objetos de Documentador, inserta si hay un nuevo elemento o actualiza si hay cambios
*@return Pagereference nul
*AuxInsertaNuevo--> lista auxiliar donde se guarda todos datos nuevos
*docus= lista que trae todas las clases apex guardadas  en Documentador__c
*docu=objeto de tipo Documentador__c donde se guardan los datos de un nuevo registro para insertarlos a AuxInsertaNuevo
*
*/
    
    public PageReference actualizarDocumentador(){
        
        //Actualización de contenido en Documentador sobre Clases 
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();      
        
        ids = new List<Id>();
        for (ApexClass cla: clases) {
            ids.add(cla.Id);
        } 
        docus = new List<Documentador__c>();
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids) AND Documentador__c.Tipo__c = 'Clase Apex'];        
        contclasses=0;
        
        
        docu = new Documentador__c();
        Documentador__c demo = new Documentador__c();
        existe=false;
        for (ApexClass clas: clases) {  
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) { 
                    if(clases.get(contclasses).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{ 
                        existe=false; 
                    }
                    contDocus++;
                }                  
                if(existe){
                    System.debug('entra a actualizar trigger '+clases.get(contclasses).Name);
                    docus.get(contDocus).Name = clases.get(contclasses).Name;
                    docus.get(contDocus).FechaModif__c=clases.get(contclasses).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Clase Apex';
                    docus.get(contDocus).FechaInicio__c = clases.get(contclasses).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = clases.get(contclasses).Id; 
                    AuxActualizar.add(docus.get(contDocus));
                    docApexClass.add(docus.get(contDocus)); 
                }else{ 
                    System.debug('entra a insertar trigger '+ clases.get(contclasses).Name);
                    //no existe clase debe insertar
                    docu.Id = null;
                    docu.Name = clases.get(contclasses).Name;
                    docu.Tipo__c = 'Clase Apex';                    
                    docu.FechaInicio__c = clases.get(contclasses).CreatedDate.date();
                    docu.FechaModif__c = clases.get(contclasses).LastModifiedDate.date();
                    docu.IdComponente__c = clases.get(contclasses).Id;
                    AuxInsertaNuevo.add(docu);  
                    docApexClass.add(docu);
                    docu = new Documentador__c(); 
                } 
            }else{
                System.debug('inserta todos los clases');
                docu.Id = null;
                docu.Name = clases.get(contclasses).Name;
                docu.Tipo__c = 'Clase Apex';                    
                docu.FechaInicio__c = clases.get(contclasses).CreatedDate.date();
                docu.FechaModif__c = clases.get(contclasses).LastModifiedDate.date();
                docu.IdComponente__c = clases.get(contclasses).Id; 
                AuxInsertaNuevo.add(docu); 
                docApexClass.add(docu);
                docu = new Documentador__c(); 
            }
            contclasses++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        System.debug('tamaño lista clases '); 
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        docAll.clear(); 
        docAll.addAll(  docApexClass); 
        
        //Actualización de contenido en Documentador sobre Trigger       
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();        
        for (ApexTrigger tri: triggers) {
            ids.add(tri.Id);
        } 
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Trigger'];                    
        conttriggers=0;
        contDocus=0;
        
        documentosActualizar = new Documentador__c();
        docu = new Documentador__c();
        
        for (ApexTrigger c: triggers) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(triggers.get(conttriggers).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                    System.debug('entra a actualizar trigger '+triggers.get(conttriggers).Name);
                    docus.get(contDocus).Name = triggers.get(conttriggers).Name;
                    docus.get(contDocus).FechaModif__c=triggers.get(conttriggers).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Trigger';
                    docus.get(contDocus).FechaInicio__c = triggers.get(conttriggers).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = triggers.get(conttriggers).Id;
                    AuxActualizar.add(docus.get(contDocus));
                    docApexTrigger.add(docus.get(contDocus)); 
                }else{ 
                    System.debug('entra a insertar trigger '+ triggers.get(conttriggers).Name);
                    //no existe clase debe insertar
                    docu.Id = null;
                    docu.Name = triggers.get(conttriggers).Name;
                    docu.Tipo__c = 'Trigger';                    
                    docu.FechaInicio__c = triggers.get(conttriggers).CreatedDate.date();
                    docu.FechaModif__c = triggers.get(conttriggers).LastModifiedDate.date();
                    docu.IdComponente__c = triggers.get(conttriggers).Id;
                    AuxInsertaNuevo.add(docu); 
                    docApexTrigger.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                System.debug('inserta todos los triggers');
                docu.Id = null;
                docu.Name = triggers.get(conttriggers).Name;
                docu.Tipo__c = 'Trigger';                    
                docu.FechaInicio__c = triggers.get(conttriggers).CreatedDate.date();
                docu.FechaModif__c = triggers.get(conttriggers).LastModifiedDate.date();
                docu.IdComponente__c = triggers.get(conttriggers).Id; 
                AuxInsertaNuevo.add(docu); 
                docApexTrigger.add(docu);
                docu = new Documentador__c(); 
            }
            conttriggers++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        System.debug('tamaño lista trigger '); 
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        System.debug('fin ciclo  trigger');
        
        docAll.addAll(  docApexTrigger);
        
    
        
        
        
        
        
        
        
        //Actualización de contenido en Documentador sobre Visualforce Page       
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();   
        for (ApexPage pag: pages) {
            ids.add(pag.Id);
        }  
        
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Visualforce Page'];                    
        contvp=0; 
        contDocus=0; 
        docu = new Documentador__c();
        
        for (ApexPage pa: pages) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(pages.get(contvp).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                    System.debug('entra a actualizar trigger '+pages.get(contvp).Name);
                    docus.get(contDocus).Name = pages.get(contvp).Name;
                    docus.get(contDocus).FechaModif__c=pages.get(contvp).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Visualforce Page';
                    docus.get(contDocus).FechaInicio__c = pages.get(contvp).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = pages.get(contvp).Id;
                    AuxActualizar.add(docus.get(contDocus));
                    docApexPage.add(docus.get(contDocus)); 
                }else{ 
                    System.debug('entra a insertar trigger '+ pages.get(contvp).Name);
                    //no existe clase debe insertar
                    docu.Id = null;
                    docu.Name = pages.get(contvp).Name;
                    docu.Tipo__c = 'Visualforce Page';                    
                    docu.FechaInicio__c = pages.get(contvp).CreatedDate.date();
                    docu.FechaModif__c = pages.get(contvp).LastModifiedDate.date();
                    docu.IdComponente__c = pages.get(contvp).Id;
                    AuxInsertaNuevo.add(docu); 
                    docApexPage.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                System.debug('inserta todos los pages');
                docu.Id = null;
                docu.Name = pages.get(contvp).Name;
                docu.Tipo__c = 'Visualforce Page';                    
                docu.FechaInicio__c = pages.get(contvp).CreatedDate.date();
                docu.FechaModif__c = pages.get(contvp).LastModifiedDate.date();
                docu.IdComponente__c = pages.get(contvp).Id; 
                AuxInsertaNuevo.add(docu); 
                docApexPage.add(docu);
                docu = new Documentador__c(); 
            }
            contvp++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
       
        docAll.addAll(  docApexPage);
        
        
        
        
        
        
        
        
         //Actualización de contenido en Documentador sobre Recurso Estaticos   
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();   
        for (StaticResource sta: staticresource) {
            ids.add(sta.Id);
        }  
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Recurso Estático'];                    
        contsr=0; 
        contDocus=0; 
        docu = new Documentador__c();
        
        for (StaticResource st: staticresource) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(pages.get(contsr).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                    System.debug('entra a actualizar trigger '+pages.get(contsr).Name);
                    docus.get(contDocus).Name = pages.get(contsr).Name;
                    docus.get(contDocus).FechaModif__c=pages.get(contsr).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Recurso Estático';
                    docus.get(contDocus).FechaInicio__c = pages.get(contsr).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = pages.get(contsr).Id;
                    AuxActualizar.add(docus.get(contDocus)); 
                    docApexStaticResource.add(docus.get(contDocus)); 
                }else{ 
                    System.debug('entra a insertar trigger '+ pages.get(contsr).Name);
                    //no existe clase debe insertar
                    docu.Id = null;
                    docu.Name = pages.get(contsr).Name;
                    docu.Tipo__c = 'Recurso Estático';                    
                    docu.FechaInicio__c = pages.get(contsr).CreatedDate.date();
                    docu.FechaModif__c = pages.get(contsr).LastModifiedDate.date();
                    docu.IdComponente__c = pages.get(contsr).Id;
                    AuxInsertaNuevo.add(docu); 
                    docApexStaticResource.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                System.debug('inserta todos los pages');
                docu.Id = null;
                docu.Name = pages.get(contsr).Name;
                docu.Tipo__c = 'Recurso Estático';                    
                docu.FechaInicio__c = pages.get(contsr).CreatedDate.date();
                docu.FechaModif__c = pages.get(contsr).LastModifiedDate.date();
                docu.IdComponente__c = pages.get(contsr).Id; 
                AuxInsertaNuevo.add(docu); 
                docApexStaticResource.add(docu);
                docu = new Documentador__c(); 
            }
            contsr++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
       
        docAll.addAll(  docApexStaticResource);
        
        
        
        
              //Actualización de contenido en Documentador sobre Componentes
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();   
        for (ApexComponent com: components) {
            ids.add(com.Id);
        } 
         
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Componente'];                    
        contcomponent=0; 
        contDocus=0; 
        docu = new Documentador__c();
        
        for (ApexComponent co: components) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(components.get(contcomponent).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                    System.debug('entra a actualizar trigger '+components.get(contcomponent).Name);
                    docus.get(contDocus).Name = components.get(contcomponent).Name;
                    docus.get(contDocus).FechaModif__c=components.get(contcomponent).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Componente';
                    docus.get(contDocus).FechaInicio__c = components.get(contcomponent).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = components.get(contcomponent).Id;
                    AuxActualizar.add(docus.get(contDocus)); 
                    docApexComponent.add(docus.get(contDocus)); 
                }else{ 
                    System.debug('entra a insertar trigger '+ components.get(contcomponent).Name);
                    //no existe clase debe insertar
                    docu.Id = null;
                    docu.Name = components.get(contcomponent).Name;
                    docu.Tipo__c = 'Componente';                    
                    docu.FechaInicio__c = components.get(contcomponent).CreatedDate.date();
                    docu.FechaModif__c = components.get(contcomponent).LastModifiedDate.date();
                    docu.IdComponente__c = components.get(contcomponent).Id;
                    AuxInsertaNuevo.add(docu); 
                    docApexComponent.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                System.debug('inserta todos los components');
                docu.Id = null;
                docu.Name = components.get(contcomponent).Name;
                docu.Tipo__c = 'Componente';                    
                docu.FechaInicio__c = components.get(contcomponent).CreatedDate.date();
                docu.FechaModif__c = components.get(contcomponent).LastModifiedDate.date();
                docu.IdComponente__c = components.get(contcomponent).Id; 
                AuxInsertaNuevo.add(docu); 
                docApexComponent.add(docu);
                docu = new Documentador__c(); 
            }
            contcomponent++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
       
        docAll.addAll(  docApexComponent);
        
        //----------------------------------------
        //
        //
        
        
       
        docAll.sort(); 
        documentador = docAll; 
        setTotal_size( documentador.size()); 
        total_size =  getTotal_size(); 
        documentadorAux=filtralista(documentador);
        return null;
    }
    
    public List <Documentador__c> filtralista(List<Documentador__c> documentador){
        //calculate range of records for capture
        
        inicioidx=(getPageNumber()-1)*PAGE_SIZE;
        finidx=getPageNumber()*PAGE_SIZE;
        documentadorAux = new List<Documentador__c>();
        if(finidx>documentador.size()){
            finidx=documentador.size();
        }
        for (Integer indice=inicioidx;indice<=documentador.size() ; indice++) {
            PAGE_SIZEAUX=finidx+PAGE_SIZE;
            if( finidx<=PAGE_SIZEAUX)
            {
                if(indice>=inicioidx && inicioidx<finidx  ){   
                    documentadorAux.add(documentador.get(indice));      
                    inicioidx++;
                }     
            }else{
                break;
            }
        } 
        return   documentadorAux;
    }
    
    /*
* Filtro por tipo de componente, se realiza un render sobre el Visualforce Page
*@return Pagereference null
*/
    public PageReference filterType(){
        if(filtroTipo.equals('Clase Apex')){
            docApexClass.sort();
            documentador = docApexClass;
            setTotal_size( documentador.size());
            total_size =   getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador); 
            
        }
        else if(filtroTipo.equals('Trigger')){
            docApexTrigger.sort();
            documentador = docApexTrigger;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }
        else if(filtroTipo.equals('Recurso Estático')){
            docApexStaticResource.sort();
            documentador = docApexStaticResource;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        } else if(filtroTipo.equals('Visualforce Page')){
            docApexPage.sort(); 
            documentador = docApexPage;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }else if(filtroTipo.equals('Componente')){
            docApexComponent.sort(); 
            documentador = docApexComponent;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }else if(filtroTipo.equals('Configuración Personalizada')){
            docApexConfPersonalizada.sort(); 
            documentador = docApexConfPersonalizada;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }
        else{
            docAll.sort();
            documentador = docAll;
            setTotal_size( documentador.size());
            total_size =        getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador); 
            
        }                
        return null;
    }
    
    public PageReference Beginning() { //user clicked beginning
        counter = 0;
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador);
        return null;
    }
    public PageReference Previous() { //user clicked previous button
        counter -= PAGE_SIZE; 
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador); 
        return null;
    }
    
    public PageReference Next() { //user clicked next button
        counter += PAGE_SIZE;
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador); 
        return null;
    }
    
    public PageReference End() { //user clicked end
        counter = total_size - math.mod(total_size, PAGE_SIZE);
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador); 
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + PAGE_SIZE < total_size) return false; else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public void setTotal_size(Integer total_size){
        this.total_size = total_size;
    }  
    
    public Integer getPageNumber() {
        return counter/PAGE_SIZE + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, PAGE_SIZE) > 0) {
            return total_size/PAGE_SIZE + 1;
        } else {
            return (total_size/PAGE_SIZE);
        }
    }
    
    
    /*
* Crea un objeto lista tipo SelectOption para formar un campo select dentro del Visualforce Page
*@return List<SelectOption> options
*/
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(' ','Seleccion...'));
        options.add(new SelectOption('Clase Apex','Clase Apex'));
        options.add(new SelectOption('Visualforce Page','Visualforce Page'));
        options.add(new SelectOption('Trigger','Trigger'));
        options.add(new SelectOption('Recurso Estático','Recurso Estático'));
        options.add(new SelectOption('Componente','Componente'));
        options.add(new SelectOption('Configuración Personalizada','Configuración Personalizada'));
        return options;
    }
}