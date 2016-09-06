@isTest   public class FichaPagoOpportunityCtrlTest {
    @IsTest   public static void createPayToken(){
        
        RecordType rt =[select id,Name, sObjectType from RecordType where sObjectType='Lead' AND NAME ='Ventas'  limit 1];
       System.debug('id del query '+rt.Id); 
         System.debug('Name del query '+rt.Name); 
         System.debug('SobjectType del query '+rt.SobjectType); 
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        
        Catalogo__c cat = new Catalogo__c(Name='Doctorado',
                                          TipoCatalogo__c='Nivel'
                                         );
        
        insert cat;
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Opportunity opp=new Opportunity(Name='demodan',
                                        StageName ='dd',
                                        CloseDate= Date.today()
                                        ,Folio__c='9983434',
                                        Nivel__c=cat.Id,
                                        Plantel__c=plan.Id,
                                      RecordTypeId=rt.Id
                                       );
        insert opp;
        
        
      
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
                                           RecibimosDe__c='demo' 
                                          );
        
        insert fp;
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
       

        FichaPagoOpportunityCtrl obj = new FichaPagoOpportunityCtrl(controller);
        
        obj.createPayToken();
    }
}