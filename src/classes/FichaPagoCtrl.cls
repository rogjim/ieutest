public with sharing class FichaPagoCtrl {
    public Lead infoLead;
    public Boolean existApproval {get;set;}
    
    public FichaPagoCtrl(ApexPages.StandardController controller){
    	infoLead = (Lead)controller.getRecord();
        existApproval = false;
    } 
    
    public PageReference createPayToken(){
        SolicitudBeca__C solicitudes = [SELECT Id FROM SolicitudBeca__c WHERE lead__c =: infoLead.id AND Estatus__c = 'Inactivo'];
        if(solicitudes != null){
            existApproval = true;
            return null;
        }
        
        Lead leadData = [SELECT VigenciaDescuento__c, Folio__c, DisponiblePromocionCero__c, ImportePagarConDescuento__c, ImporteTotal__c, FirstName, LastName, ApeMaterno__c, nivel__r.Name, plantel__c FROM Lead WHERE Id =: infoLead.Id];
        FichaPago__c newToken = new FichaPago__c();
        newToken.FolioLead__c = Decimal.valueOf(leadData.Folio__c.replace('C-',''));
        newToken.RecibimosDe__c = (leadData.FirstName != null ? leadData.FirstName : '') + ' ' + leadData.LastName + ' ' + (leadData.ApeMaterno__c != null ? leadData.ApeMaterno__c : '');
        newToken.TotaPagar__c = leadData.ImporteTotal__c; //Antes ImportePagarConDescuento__c;
        if(leadData.nivel__r.Name == 'Licenciatura' || leadData.nivel__r.Name == 'Maestría'){
        	newToken.TipoFicha__c = 'Nivel';
        }else if(leadData.nivel__r.Name == 'Doctorado'){
            newToken.TipoFicha__c = 'Nivel Doctorado';
        }
        if(leadData.DisponiblePromocionCero__c){
        	newToken.TipoFicha__c = 'Promoción Cero';
            //newToken.RecordTypeId = Schema.SObjectType.FichaPago__c.getRecordTypeInfosByName().get('Promoción Cero').getRecordTypeId()
        }        
            
        newToken.Lead__c = infoLead.Id;
        if(leadData.VigenciaDescuento__c != null){
                newToken.Hasta__c = leadData.VigenciaDescuento__c; 
            }else{
                Date today = Date.today();
                Date vigancia = today.addDays(10); 
                newToken.Hasta__c = vigancia; 
            }
        newToken.Plantel__c = leadData.plantel__c;
        insert newToken;
        return new PageReference('/' + newToken.Id);
    }
}