@isTest  public class FichaPagoMovilCtrlTest {
    
    @IsTest   public static void getPrograms(){
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id);
        insert oe;
        
        
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        
        Lead lead = new Lead(LastName='demo',
                             OfertaEducativa__c=oe.Id,
                             Folio__c = String.valueOf(nextFolio)
                            );
        insert lead;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today(),
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                           Lead__c=lead.Id,
                                           RecibimosDe__c='de',
                                           
                                           Nivel__c=catn.Id
                                          );
        insert fp;
        
        FichaPagoMovilCtrl fpm =new FichaPagoMovilCtrl();
        fpm.ficha.Nivel__c=catn.Id;
        fpm.numeroFichas='1';
        fpm.ficha.Descuento__c=4;
        fpm.ficha.Importe__c=888;
        fpm.ficha.Hasta__c=Date.today();
      //  fpm.ficha.Periodo__c;
       // fpm.ficha.RecordTypeId;
        //fpm.ficha.ProgramasRelacionados__c;
       // fpm.ficha.TipoFicha__c;
        fpm.ficha.Plantel__c=plan.id;
       // fpm.ficha.Nivel__c;
       // fpm.ficha.TotaPagar__c;
        
        
        
        
        
        fpm.getPrograms();
    }
    
}