@isTest  public class LEAD_LayoutCtrlTest {
    @isTest     public static void LEAD_LayoutCtrl(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        
        Periodo__c per = new Periodo__c(Name='agosto 2020',
                                        FechaInicio__c=inicio,
                                        FechaInicioReal__c=inicio,
                                        FechaFin__c =fin,
                                        FechaFinReal__c =fin,
                                        Activo__c='Activo'
                                       );
        insert per;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO',
                                           IdUbicacion__c='157',
                                           TipoUbicacion__c='País'
                                          );
        insert ub;
        
        Ubicacion__c ubi = new Ubicacion__c(Name='D. F.',
                                            Abreviatura__c='DF',
                                            IdUbicacion__c='9',
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Estado'
                                           ); 
        insert ubi;
        
        Ubicacion__c mun = new Ubicacion__c(Name='San José de Gracia',
                                            Cabecera__c='San José de Gracia',
                                            Capital__c='0',
                                            IdUbicacion__c=ubi.IdUbicacion__c,
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Municipio'
                                           ); 
        insert mun;
        
        
        
        BecaConvenioAsignacion__c beca = new BecaConvenioAsignacion__c(Name='demo' );
        insert beca;
        
        Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10
        );
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id,
                                                      Periodo__c=per.Id
                                                     );
        insert oe;
        
        Aula__c aula = new Aula__c(Name='demo',
                                  Plantel__c=plan.id,
                                   Cupo__c=20
        );
        insert aula;
        
        Docente__c docente = new Docente__c(Name='demo'
        
        );
        
        insert docente;
        
        Materia__c materia = new Materia__c(Name='demo',
                                           Programa__c=pr.id
                                            
                                           );
        insert materia;
        Grupo__c grupo = new Grupo__c( Name='demo',
                                      AulaAsignada__c=aula.Id,
                                     Docente__c=docente.Id,
                                      Materia__c=materia.Id
        
        );
          insert grupo;
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                          // ,ProgramasRelacionados__c= 'a04R0000003k4RBIAY,a04R0000003k4RSIAY,a04R0000003k4TrIAI' );
                                             ,ProgramasRelacionados__c=pr.Id );
        insert fp;
        
        Lead lead = new  Lead(LastName='demo',
                              FichaMovil__c=fp.Id,
                              Folio__c = String.valueOf(nextFolio),
                              Plantel__c=plan.id,
                              Periodo__c=per.Id,
                              Nivel__c=catn.Id,
                              BecaConvenioAsignacion__c=beca.Id  ,
                              AplicaPromocionCero__c=true,
                              Pais__c=null,
                              Estado__c=ubi.Id,
                              Municipio__c=mun.Id,
                              Inscripcion__c=333,
                              Antologia__c=0,
                              Colegiatura__c=5000,
                              PorcentajeBeca__c=20,
                              ExamenAdmision__c=300,
                              Propedeutico__c=200,
                              Uniforme__c=300,
                              Modalidad__c= cat.Id,
                              TipoBeca__c=   'Comercial', 
                              OfertaEducativa__c=oe.id,
                             Programa__c=pr.id
                             );
        insert lead;
        
        Descuento__c des = new Descuento__c(Name='demo',
                                            Estatus__c='Activo',
                                            PorcentajeDescuento__c=10,
                                            FechaFinVigencia__c=fin,
                                            Lead__c=lead.Id
                                           );
        insert des;
        
        
        Test.startTest();
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        LEAD_LayoutCtrl obj = new LEAD_LayoutCtrl(controller);
                    obj.isFichaMovil();
        obj.guardaSolicitudPromocion();
         obj.guardar();
        Test.stopTest();
    }
    
        @isTest     public static void LEAD_LayoutCtrl2(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        
        Periodo__c per = new Periodo__c(Name='agosto 2020',
                                        FechaInicio__c=inicio,
                                        FechaInicioReal__c=inicio,
                                        FechaFin__c =fin,
                                        FechaFinReal__c =fin,
                                         Activo__c='Activo'
                                       );
        insert per;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO',
                                           IdUbicacion__c='157',
                                           TipoUbicacion__c='País'
                                          );
        insert ub;
        
        Ubicacion__c ubi = new Ubicacion__c(Name='D. F.',
                                            Abreviatura__c='DF',
                                            IdUbicacion__c='9',
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Estado'
                                           ); 
        insert ubi;
        
        Ubicacion__c mun = new Ubicacion__c(Name='San José de Gracia',
                                            Cabecera__c='San José de Gracia',
                                            Capital__c='0',
                                            IdUbicacion__c=ubi.IdUbicacion__c,
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Municipio'
                                           ); 
        insert mun;
        
        
        
        BecaConvenioAsignacion__c beca = new BecaConvenioAsignacion__c(Name='demo' );
        insert beca;
        
        Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10
        );
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id,
                                                    Periodo__c=per.Id
                                                     );
        insert oe;
            System.debug('id oferta '+ oe.Id);
               Aula__c aula = new Aula__c(Name='demo',
                                  Plantel__c=plan.id,
                                   Cupo__c=20
        );
        insert aula;
        
        Docente__c docente = new Docente__c(Name='demo'
        
        );
        
        insert docente;
        
        Materia__c materia = new Materia__c(Name='demo',
                                              Programa__c=pr.id
                                           );
        insert materia;
        Grupo__c grupo = new Grupo__c( Name='demo',
                                      AulaAsignada__c=aula.Id,
                                     Docente__c=docente.Id,
                                      Materia__c=materia.Id
        
        );
          insert grupo;
        
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                          // ,ProgramasRelacionados__c= 'a04R0000003k4RBIAY,a04R0000003k4RSIAY,a04R0000003k4TrIAI' );
                                             ,ProgramasRelacionados__c=pr.Id );
        
        insert fp;
            
        
        Lead lead = new  Lead(LastName='demo',
                             // FichaMovil__c=fp.Id,
                              Folio__c = String.valueOf(nextFolio),
                              Plantel__c=plan.id,
                              Periodo__c=per.Id,
                              Nivel__c=catn.Id,
                              BecaConvenioAsignacion__c=beca.Id  ,
                              AplicaPromocionCero__c=false,
                              Pais__c=null,
                              Estado__c=ubi.Id,
                              Municipio__c=mun.Id,
                              Inscripcion__c=333,
                              Antologia__c=0,
                              Colegiatura__c=5000,
                              PorcentajeBeca__c=20,
                              ExamenAdmision__c=300,
                              Propedeutico__c=200,
                              Uniforme__c=300,
                              Modalidad__c= cat.Id,
                              TipoBeca__c=   'Comercial',
                              OfertaEducativa__c=oe.id,
                               Programa__c=pr.id
                             );
        insert lead;
        
        Descuento__c des = new Descuento__c(Name='demo',
                                            Estatus__c='Activo',
                                            PorcentajeDescuento__c=10,
                                            FechaFinVigencia__c=fin,
                                            Lead__c=lead.Id
                                           );
        insert des;
        
            
            
        Test.startTest();
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        LEAD_LayoutCtrl obj = new LEAD_LayoutCtrl(controller);
            
obj.guardar();
        Test.stopTest();
    }
    
          @isTest     public static void LEAD_LayoutCtrl3(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        
        Periodo__c per = new Periodo__c(Name='agosto 2020',
                                        FechaInicio__c=inicio,
                                        FechaInicioReal__c=inicio,
                                        FechaFin__c =fin,
                                        FechaFinReal__c =fin,
                                         Activo__c='Activo'
                                       );
        insert per;
        
        Ubicacion__c ub = new Ubicacion__c(Name='Colombia',
                                           IdUbicacion__c='158',
                                           TipoUbicacion__c='País'
                                          );
        insert ub;
        
        Ubicacion__c ubi = new Ubicacion__c(Name='D. F.',
                                            Abreviatura__c='DF',
                                            IdUbicacion__c='9',
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Estado'
                                           ); 
        insert ubi;
        
        Ubicacion__c mun = new Ubicacion__c(Name='San José de Gracia',
                                            Cabecera__c='San José de Gracia',
                                            Capital__c='0',
                                            IdUbicacion__c=ubi.IdUbicacion__c,
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Municipio'
                                           ); 
        insert mun;
        
        
        
        BecaConvenioAsignacion__c beca = new BecaConvenioAsignacion__c(Name='demo' );
        insert beca;
        
        Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10
        );
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id,
                                                    Periodo__c=per.Id
                                                     );
        insert oe;
            System.debug('id oferta '+ oe.Id);
               Aula__c aula = new Aula__c(Name='demo',
                                  Plantel__c=plan.id,
                                   Cupo__c=20
        );
        insert aula;
        
        Docente__c docente = new Docente__c(Name='demo'
        
        );
        
        insert docente;
        
        Materia__c materia = new Materia__c(Name='demo',
                                              Programa__c=pr.id
                                           );
        insert materia;
        Grupo__c grupo = new Grupo__c( Name='demo',
                                      AulaAsignada__c=aula.Id,
                                     Docente__c=docente.Id,
                                      Materia__c=materia.Id
        
        );
     insert grupo;
     
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                          // ,ProgramasRelacionados__c= 'a04R0000003k4RBIAY,a04R0000003k4RSIAY,a04R0000003k4TrIAI' );
                                             ,ProgramasRelacionados__c=pr.Id
                                         
                                           
                                          );
        
        insert fp;
            
        
        Lead lead = new  Lead(LastName='demo',
                              FichaMovil__c=fp.Id,
                              Folio__c = String.valueOf(nextFolio),
                              Plantel__c=plan.id,
                              Periodo__c=per.Id,
                              Nivel__c=catn.Id,
                              BecaConvenioAsignacion__c=beca.Id  ,
                              AplicaPromocionCero__c=true,
                              Pais__c=null,
                              Estado__c=ubi.Id,
                              Municipio__c=mun.Id,
                              Inscripcion__c=333,
                              Antologia__c=0,
                              Colegiatura__c=5000,
                              PorcentajeBeca__c=20,
                              ExamenAdmision__c=300,
                              Propedeutico__c=200,
                              Uniforme__c=300,
                             // Modalidad__c= cat.Id,
                              TipoBeca__c=   'Comercial',
                              OfertaEducativa__c=oe.id,
                               Programa__c=pr.id
                             );
        insert lead;
        
        Descuento__c des = new Descuento__c(Name='demo',
                                            Estatus__c='Activo',
                                            PorcentajeDescuento__c=10,
                                            FechaFinVigencia__c=fin,
                                            Lead__c=lead.Id
                                           );
        insert des;
        
            
            
        Test.startTest();
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        LEAD_LayoutCtrl obj = new LEAD_LayoutCtrl(controller);
             
obj.guardar();
        Test.stopTest();
    }
    
    @isTest     public static void LEAD_LayoutCtrl4(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        
        Periodo__c per = new Periodo__c(Name='agosto 2020',
                                        FechaInicio__c=inicio,
                                        FechaInicioReal__c=inicio,
                                        FechaFin__c =fin,
                                        FechaFinReal__c =fin,
                                         Activo__c='Activo'
                                       );
        insert per;
        
         Ubicacion__c ub = new Ubicacion__c(Name='MEXICO',
                                           IdUbicacion__c='157',
                                           TipoUbicacion__c='País'
                                          );
        insert ub;
        
     
        
        Ubicacion__c ubi = new Ubicacion__c(Name='D. F.',
                                            Abreviatura__c='DF',
                                            IdUbicacion__c='9',
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Estado'
                                           ); 
        insert ubi;
        
      Ubicacion__c mun = new Ubicacion__c(Name='San José de Gracia',
                                            Cabecera__c='San José de Gracia',
                                            Capital__c='0',
                                            IdUbicacion__c=ubi.IdUbicacion__c,
                                            IdEstadoPais__c=ub.IdUbicacion__c,
                                            TipoUbicacion__c ='Municipio'
                                           ); 
        insert mun;
        
        
        
        BecaConvenioAsignacion__c beca = new BecaConvenioAsignacion__c(Name='demo'
                                                                       );
        insert beca;
        
        Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10
        );
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id,
                                                    Periodo__c=per.Id
                                                  
                                                     );
        insert oe;
            System.debug('id oferta '+ oe.Id);
               Aula__c aula = new Aula__c(Name='demo',
                                  Plantel__c=plan.id,
                                   Cupo__c=20
        );
        insert aula;
        
        Docente__c docente = new Docente__c(Name='demo'
        
        );
        
        insert docente;
        
        Materia__c materia = new Materia__c(Name='demo',
                                              Programa__c=pr.id
                                           );
        insert materia;
        Grupo__c grupo = new Grupo__c( Name='demo',
                                      AulaAsignada__c=aula.Id,
                                     Docente__c=docente.Id,
                                      Materia__c=materia.Id,
                                     OfertaEducativa__c=oe.Id
        );
   
     insert grupo;
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                          // ,ProgramasRelacionados__c= 'a04R0000003k4RBIAY,a04R0000003k4RSIAY,a04R0000003k4TrIAI' );
                                             ,ProgramasRelacionados__c=pr.Id
                                         
                                           
                                          );
        
        insert fp;
            
        
        Lead lead = new  Lead(LastName='demo',
                              FichaMovil__c=fp.Id,
                              Folio__c = String.valueOf(nextFolio),
                              Plantel__c=plan.id,
                              Periodo__c=per.Id,
                              Nivel__c=catn.Id,
                              BecaConvenioAsignacion__c=beca.Id  ,
                              AplicaPromocionCero__c=true,
                              Pais__c=ub.id,
                              Estado__c=ubi.Id,
                             Municipio__c=mun.Id,
                              Inscripcion__c=333,
                              Antologia__c=0,
                              Colegiatura__c=5000,
                              PorcentajeBeca__c=20,
                              ExamenAdmision__c=300,
                              Propedeutico__c=200,
                              Uniforme__c=300,
                            Modalidad__c= cat.Id,
                              TipoBeca__c=   'Comercial',
                              OfertaEducativa__c=oe.id,
                               Programa__c=pr.id
                             );
        insert lead;
        
        Descuento__c des = new Descuento__c(Name='demo',
                                            Estatus__c='Activo',
                                            PorcentajeDescuento__c=10,
                                            FechaFinVigencia__c=fin,
                                            Lead__c=lead.Id
                                           );
        insert des;
        
            
            
        Test.startTest();
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        LEAD_LayoutCtrl obj = new LEAD_LayoutCtrl(controller);
       //     obj.setOffertByPayment();
obj.guardar();
        Test.stopTest();
    }
}