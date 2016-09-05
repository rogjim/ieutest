@IsTest public class TriggerCandidatoHandlerTest {
    @IsTest   public static void  TriggerCandidatoHandlerTest(){
        
          Test.startTest();
        
    /*    Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10
                                 );
        insert bec;
      
        ConfiguracionObjetoCambio__c ob = new ConfiguracionObjetoCambio__c(
            Name='Beca__c',
            Campo__c='Beca__c'
        );
        
        insert ob;*/
        Negocio__c negocio = new Negocio__c(
        );
        insert negocio;
        Lead lead = new Lead( LastName='demo',
                             AsignacionAutomatica__c=true
                             
        
        );
        
        insert lead;
        TriggerCandidatoHandler obj = new TriggerCandidatoHandler();
        obj.afterInsert();
        Test.stopTest();
        
        
    }

}