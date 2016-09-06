@IsTest  public class TriggerBecaHandlerTest {
    @IsTest   public static void  TriggerBecaHandler(){
        
        Test.startTest();
        
        Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10
                                 );
        insert bec;
      
        ConfiguracionObjetoCambio__c ob = new ConfiguracionObjetoCambio__c(
            Name='Beca__c',
            Campo__c='Beca__c'
        );
        
        insert ob;
        
        TriggerBecaHandler obj = new TriggerBecaHandler();
        obj.afterUpdate();
        Test.stopTest();
        
    }
}