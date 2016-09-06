public class controlDocumentador {
    /*Variables Globales*/
    public List<ApexClass> clases;
    public List<ApexTrigger> triggers;
    public List<StaticResource> recEstatico;
    public List<ApexComponent> components;
    public List<ApexPage> vfp;    
    List<Documentador__c> tempDoc;    
    public Documentador__c documentador {get;set;}
    public String idD {get;set;}

    /*
     * Getters and Setters 
     */
    public void setDocumentador(Documentador__c documentador){
        this.documentador = documentador;
    }
    
    public Documentador__c getDocumentador(){
        return this.documentador;
    }
    
    /*
     * Constructor
	*/
    public controlDocumentador(){
        documentador = new Documentador__c();  
        idD = ApexPages.currentPage().getParameters().get('Id');
        if(!String.isEmpty(idD)){ 
            
            tempDoc = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c,
                           Observacion__c 
                       FROM Documentador__c 
                       WHERE IdComponente__c =:idD];
        
            System.debug('Obtuvo de documentador');
            documentador.Name = tempDoc.get(0).Name;
            documentador.Tipo__c = tempDoc.get(0).Tipo__c;
            documentador.FechaInicio__c = tempDoc.get(0).FechaInicio__c;
            documentador.FechaModif__c = tempDoc.get(0).FechaModif__c;
            documentador.Observacion__c = tempDoc.get(0).Observacion__c;
        }
     
    }
    

    /*
     * Guarda los cambios realizados de un elemento sobre el campo Descripcion
     * @return pageReference URL de MatrizDesarrollo.vfp 
     */
    public pageReference guardar(){
        //System.debug('Id del componete a insertar o actualizar: ' + tempDoc.get(0).Id);
        if(!String.isEmpty(idD)){
        	if(tempDoc.get(0).Id!=null){            
            	tempDoc.get(0).Observacion__c = documentador.Observacion__c;
            	update tempDoc;            
        	}
        }
        /*
        else{
            tempDoc.get(0).Observacion__c = documentador.Observacion__c;
        	insert tempDoc;
        } */
        PageReference pageRef = new PageReference('https://c.na30.visual.force.com/apex/MatrizDesarrolloView?sfdc.tabName=01r36000000jVDm');
        return pageRef;
    }

}