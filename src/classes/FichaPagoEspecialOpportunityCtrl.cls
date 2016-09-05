public with sharing class FichaPagoEspecialOpportunityCtrl {
   
    public FichaPago__c ficha {get; set;}
	public RecordType recordType;

    public FichaPagoEspecialOpportunityCtrl(ApexPages.StandardController controller){
    	
    	Opportunity opp = (Opportunity)controller.getRecord();
    	opp=[SELECT Id, Name, Plantel__c from Opportunity WHERE Id=:opp.Id];
    	
    	ficha = new FichaPago__c();
    	ficha.RecibimosDe__c = (opp.Name != null? opp.Name : '');
        ficha.Oportunidad__c = opp.Id;
        ficha.Plantel__c = opp.plantel__c;
        recordType = [SELECT Id,Name FROM RecordType WHERE SobjectType='FichaPago__c' AND Name='Ficha Especial'];
        ficha.TipoFicha__c = 'Ficha Especial';
        ficha.RecordTypeId = recordType.Id;
        
    }
    
    public PageReference saveToken(){
    	ficha.TotaPagar__c = ficha.Importe__c - (ficha.Importe__c * (ficha.Descuento__c / 100));
    	if (ficha != null){
    		insert ficha;
    	}
       
        return new PageReference('/' + ficha.Id);
    }
    
    public PageReference exit(){
        return new PageReference('/' + ficha.Oportunidad__c);
    }
    
    

}