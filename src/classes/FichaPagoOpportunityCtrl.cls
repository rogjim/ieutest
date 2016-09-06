public with sharing class FichaPagoOpportunityCtrl {

    public Opportunity infoOpp;
   	public Boolean existApproval {get;set;}
    /**
    * @author:      Gerardo Martínez
    * @date:        17/06/2016
    * @description: Constructor del controlador FichaPagoOpportunityCtrl
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      
    */
    public FichaPagoOpportunityCtrl(ApexPages.StandardController controller){
    	infoOpp = (Opportunity)controller.getRecord();
        existApproval = false;
    } 
    

    /**
    * @author:      Gerardo Martínez
    * @date:        17/06/2016
    * @description: Regresa el registro creado de la página
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      PageReference Visual Force Page
    */
    public PageReference createPayToken(){
        try{
        	SolicitudBeca__C solicitudes = [SELECT Id FROM SolicitudBeca__c WHERE Oportunidad__c =: infoOpp.id AND Estatus__c = 'Inactivo'];
            if(solicitudes != null){
                existApproval = true;
                return null;
            }
        }catch(Exception e){
        }
        Opportunity data = [SELECT Id, Name, VigenciaDescuento__c, Folio__c, ImporteTotal__c, ImportePagarConDescuento__c, Nivel__r.Name, Plantel__c FROM Opportunity WHERE Id =: infoOpp.Id];       
       
        FichaPago__c newToken = new FichaPago__c();
      
        newToken.FolioLead__c = Decimal.valueOf(data.Folio__c.replace('C-',''));
        newToken.RecibimosDe__c = (data.Name != null ? data.Name : '');
        newToken.TotaPagar__c = data.ImporteTotal__c; //Antes ImportePagarConDescuento__c
        newToken.Oportunidad__c = infoOpp.Id;
        newToken.Plantel__c = data.plantel__c;
        
        if(data.nivel__r.Name == 'Licenciatura' || data.nivel__r.Name == 'Maestría'){
            newToken.TipoFicha__c = 'Nivel';
        }else if(data.nivel__r.Name == 'Doctorado'){
            newToken.TipoFicha__c = 'Nivel Doctorado';
        }


        if(data.VigenciaDescuento__c != null){
                newToken.Hasta__c = data.VigenciaDescuento__c; 
        }else{
                Date today = Date.today();
                Date vigancia = today.addDays(10); 
                newToken.Hasta__c = vigancia; 
        }

        insert newToken;
        return new PageReference('/' + newToken.Id);

    }
    
    public PageReference exit(){
        return new PageReference('/' + infoOpp.id);
    }
}