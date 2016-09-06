@isTest  public class FichaPagoCtrlTest {
    
    @IsTest   public static void test(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date fin = date.today();
        
        Catalogo__c catn = new Catalogo__c(Name='Licenciatura',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Instituto__c inst= new Instituto__c(Encabezado__c='INSTITUTO_0'
                                           );
        insert inst;
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.id
                                         );
        insert  plan;
        
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio),
                              VigenciaDescuento__c=fin,
                              FirstName='demo',
                              nivel__c=catn.id,
                              plantel__c =plan.id
                             );
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        FichaPagoCtrl obj = new FichaPagoCtrl(controller);
        
        obj.createPayToken();
    }
}