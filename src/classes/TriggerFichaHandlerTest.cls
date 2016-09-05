@IsTest  public class TriggerFichaHandlerTest {
    @IsTest   public static void  TriggerFichaHandlerTest(){
        
        Test.startTest();
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        configuracionNegocio.MaximoGrupo__c=30;
        configuracionNegocio.MaximoGrupoOnline__c=50;
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        String cadenaCodigo='783786876';
        String referenceHSBC ='';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        cadenaCodigo='7837868.76';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Lead lead = new Lead(LastName='demo',
                             Email='dsanchez@ctconsulting.com.mx',
                             Nivel__c=catn.Id
                            );
        insert lead;
        
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                           , Lead__c=lead.id
                                           , RecibimosDe__c='demo'
                                          );
        insert fp;
        
        Test.stopTest();
        
    }
    
    @IsTest   public static void  TriggerFichaHandlerTest2(){
        
        Test.startTest();
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        configuracionNegocio.MaximoGrupo__c=30;
        configuracionNegocio.MaximoGrupoOnline__c=50;
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        String cadenaCodigo='783786876';
        String referenceHSBC ='';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        cadenaCodigo='7837868.76';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                           //  , Lead__c=lead.id
                                           , RecibimosDe__c='demo'
                                          );
        insert fp;
        
        Test.stopTest();
        
    }
    
  /*  @IsTest   public static void  TriggerFichaHandlerTest3(){
        
        Test.startTest();
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        configuracionNegocio.MaximoGrupo__c=30;
        configuracionNegocio.MaximoGrupoOnline__c=50;
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        String cadenaCodigo='783786876';
        String referenceHSBC ='';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        cadenaCodigo='7837868.76';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        
        RecordType rt =[select id,Name, sObjectType from RecordType where sObjectType='Lead' AND NAME ='Ventas'  limit 1];
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;

        Instituto__c inst = new Instituto__c( Encabezado__c='INSTITUTO_1'
                                             
                                            );
        insert inst;
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.Id
                                         );
        insert  plan;
        
        Account acc = new Account( 
            
            PersonEmail= 'dsanchez@ctconsulting.com.mx'
        );
        //insert acc;
        Opportunity opp=new Opportunity(Name='demodan',
                                        StageName ='dd',
                                        CloseDate= Date.today()
                                        ,Folio__c='9983434',
                                        Nivel__c=catn.Id,
                                        Plantel__c=plan.Id
                                       );
        insert opp;
        
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                           , RecibimosDe__c='demo',
                                           Oportunidad__c=opp.id,
                                           Plantel__c=plan.id
                                          );
        insert fp;
        
        Test.stopTest();
        
    }*/
}