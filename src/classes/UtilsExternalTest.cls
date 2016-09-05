@IsTest public class UtilsExternalTest {
    
    @IsTest   public static void  UtilsExternalTest(){
        
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
        
        Catalogo__c catn = new Catalogo__c(Name='Licenciatura',
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
        
        UtilsExternal.ComboWrapper cw = new  UtilsExternal.ComboWrapper();
        
        cw=UtilsExternal.getExternalOfertaAcademica();
        
        Map<String, List<SObject>> ubicacion = new Map<String, List<SObject>>();
        ubicacion=UtilsExternal.getExternalUbicacion();
        
    }
}