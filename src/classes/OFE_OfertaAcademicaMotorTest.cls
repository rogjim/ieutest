@isTest public class OFE_OfertaAcademicaMotorTest {
    @isTest   public static void obtainAcademicOffer(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        configuracionNegocio.MaximoGrupo__c=30;
        configuracionNegocio.MaximoGrupoOnline__c=50;
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
                                        Activo__c='Activo',
                                        ActivoPresencial__c=true
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
        
        Aula__c aula = new Aula__c(Name='demo',
                                   Plantel__c=plan.id,
                                   Cupo__c=20
                                  );
        insert aula;
        
        Docente__c docente = new Docente__c(Name='demo' );
        
        insert docente;
        
        Materia__c materia = new Materia__c(Name='demo',
                                            Programa__c=pr.id
                                           );
        insert materia;
        
        Grupo__c grupo = new Grupo__c( Name='demo',
                                      AulaAsignada__c=aula.Id,
                                      Docente__c=docente.Id,
                                      Materia__c=materia.Id,
                                      OfertaEducativa__c=oe.id,
                                      ProspectosAsignados__c=2
                                      ,Cupo__c=20 
                                     );
        insert grupo;
        
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                           ,ProgramasRelacionados__c=pr.Id );
        
        insert fp;
        
        Lead lead = new  Lead(LastName='demo',
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
                              ModalidadPresencial__c=true,
                              TipoBeca__c=   'Comercial',
                              OfertaEducativa__c=oe.id,
                              Programa__c=pr.id
                             );
        insert lead;
        
        OFE_OfertaAcademicaMotor ofe = new OFE_OfertaAcademicaMotor();
        ofe.obtainAcademicOffer(lead);
        ofe.getGroupByAcademicOffer(oe);
    }
    
    @isTest   public static void obtainAcademicOffer2(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        configuracionNegocio.MaximoGrupo__c=30;
        configuracionNegocio.MaximoGrupoOnline__c=50;
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
                                        Activo__c='Activo',
                                        ActivoPresencial__c=true
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
        
        Catalogo__c cat = new Catalogo__c(Name='Presencial',
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
        
        Aula__c aula = new Aula__c(Name='demo',
                                   Plantel__c=plan.id,
                                   Cupo__c=20
                                  );
        insert aula;
        
        Docente__c docente = new Docente__c(Name='demo' );
        
        insert docente;
        
        Materia__c materia = new Materia__c(Name='demo',
                                            Programa__c=pr.id
                                           );
        insert materia;
        
        Grupo__c grupo = new Grupo__c( Name='demo',
                                      AulaAsignada__c=aula.Id,
                                      Docente__c=docente.Id,
                                      Materia__c=materia.Id,
                                      OfertaEducativa__c=oe.id,
                                      ProspectosAsignados__c=2
                                      ,Cupo__c=20 
                                     );
        insert grupo;
        
        FichaPago__c fp = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                           ,Hasta__c = Date.today()
                                           // ,ProgramasRelacionados__c= 'a04R0000003k4RBIAY,a04R0000003k4RSIAY,a04R0000003k4TrIAI' );
                                           ,ProgramasRelacionados__c=pr.Id );
        insert fp;
        
        Lead lead = new  Lead(LastName='demo',
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
                              ModalidadPresencial__c=true,
                              TipoBeca__c=   'Comercial',
                              OfertaEducativa__c=oe.id,
                              Programa__c=pr.id
                             );
        insert lead;
        
        OFE_OfertaAcademicaMotor ofe = new OFE_OfertaAcademicaMotor();
        ofe.obtainAcademicOffer(lead);
        ofe.getGroupByAcademicOffer(oe);
    }
}