public with sharing class FichaPagoEspecialCtrl {
	
    public FichaPago__c ficha {get; set;}
    Public RecordType recordType;
    public FichaPagoEspecialCtrl(ApexPages.StandardController controller){
        Lead infoLead = (Lead)controller.getRecord();
        Lead fromSale = [Select Id, FirstName, LastName, ApeMaterno__c, plantel__c from Lead where Id = : infoLead.Id];
        ficha = new FichaPago__c();
        ficha.RecibimosDe__c = (fromSale.FirstName != null ? fromSale.FirstName : '') + ' ' + fromSale.LastName + ' ' + (fromSale.ApeMaterno__c != null ? fromSale.ApeMaterno__c : '');
        ficha.Lead__c = fromSale.Id;
        ficha.Plantel__c = fromSale.plantel__c;
        recordType = [SELECT Id,Name FROM RecordType WHERE SobjectType='FichaPago__c' AND Name='Ficha Especial'];
    }
    
    public PageReference saveToken(){
        ficha.TotaPagar__c = ficha.Importe__c - (ficha.Importe__c * (ficha.Descuento__c / 100));
        System.debug('TotaPagar__c '+  ficha.TotaPagar__c );
        ficha.TipoFicha__c = 'Ficha Especial';
          System.debug('TotaPagar__c '+  ficha.TotaPagar__c );
        ficha.RecordTypeId = recordType.Id;
          System.debug(' ficha.RecordTypeId  '+   ficha.RecordTypeId );
        insert ficha;
        System.debug(ficha);
        return new PageReference('/' + ficha.Id);
    }
    
    public PageReference exit(){
        return new PageReference('/' + ficha.Lead__c);
    }
}