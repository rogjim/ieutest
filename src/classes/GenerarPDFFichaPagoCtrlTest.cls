@isTest  public class GenerarPDFFichaPagoCtrlTest {
    
    @isTest     public static void sendMail(){
        RecordType rt =[select id,Name from RecordType where sObjectType='Account'  limit 1];
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        
        Catalogo__c cat = new Catalogo__c(Name='Cursos y Diplomados',
                                          TipoCatalogo__c='Nivel'
                                         );
        
        insert cat;
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio),
                              Nivel__c=cat.id
                             );
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today(),
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                           Lead__c=lead.Id,
                                           RecibimosDe__c='de'
                                          );
        insert fp;
        ApexPages.StandardController controller = new ApexPages.StandardController(fp);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', fp.Id);
        GenerarPDFFichaPagoCtrl obj = new GenerarPDFFichaPagoCtrl(controller);
        //CTA_LayoutCtrl obj = new CTA_LayoutCtrl(controller);
        obj.sendMail();
        
    }
    
}