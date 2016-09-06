@IsTest  public class DescuentosByOpportunityCtrlTest {

    @IsTest   public static void DescuentosByOpportunityCtrlTest(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio)
                             );
        insert lead;
        
         Opportunity opp=new Opportunity(Name='demo',
                                        StageName ='dd',
                                        CloseDate= Date.today()
                                       );
        insert opp;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        DescuentosByOpportunityCtrl obj = new DescuentosByOpportunityCtrl(controller);
        
        obj.getDescuentos();
        obj.getBecas();
    }
}