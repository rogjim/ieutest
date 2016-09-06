@IsTest public class DescuentosByLeadCtrlTest {
    @IsTest   public static void getDescuentos(){
        
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
        DescuentosByLeadCtrl obj = new DescuentosByLeadCtrl(controller);
        
        obj.getDescuentos();
        obj.getBecas();
    }
}