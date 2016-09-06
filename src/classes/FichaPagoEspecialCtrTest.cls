@isTest 
public class FichaPagoEspecialCtrTest {
    @IsTest   public static void saveToken(){
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio)
                             );
        insert lead;
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today(),
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                            RecibimosDe__c ='demo'
                                          );
        //  upsert fp;
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        FichaPagoEspecialCtrl obj = new FichaPagoEspecialCtrl(controller);
        obj.ficha=fp;
        obj.saveToken();
    }
        @IsTest   public static void exit(){
             Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio)
                             );
        insert lead;
     
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        FichaPagoEspecialCtrl obj = new FichaPagoEspecialCtrl(controller);
       
        obj.exit();
    }
}