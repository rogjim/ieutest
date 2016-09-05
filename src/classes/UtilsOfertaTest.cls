@isTest
public class UtilsOfertaTest {
    @IsTest   public static void getModalidades(){
        List<SelectOption> options = new List<SelectOption>();
        options=UtilsOferta.getModalidades();
    }
    @IsTest   public static void getPlanteles(){
        List<SelectOption> planteles = new List<SelectOption>();
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c ='a03R00000059FVrIAM',
                                                        Nivel__c='a03R00000059FVDIA2',
                                                        Programa__c='a04R0000003k4QqIAI',
                                                        Plantel__c='a02R000000NukmYIAR');
        insert obj;
        planteles=UtilsOferta.getPlanteles(obj.Modalidad__c);
    }
    @IsTest   public static void getNiveles(){
        List<SelectOption> niveles = new List<SelectOption>();
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c ='a03R00000059FVrIAM',
                                                        Nivel__c='a03R00000059FVDIA2',
                                                        Programa__c='a04R0000003k4QqIAI',
                                                        Plantel__c='a02R000000NukmYIAR');
        insert obj;
        niveles=UtilsOferta.getNiveles(obj.Plantel__c, obj.Modalidad__c);
    }
    @IsTest   public static void getProgramas(){
        List<SelectOption> programas = new List<SelectOption>();
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c ='a03R00000059FVrIAM',
                                                        Nivel__c='a03R00000059FVDIA2',
                                                        Programa__c='a04R0000003k4QqIAI',
                                                        Plantel__c='a02R000000NukmYIAR');
        insert obj;
        programas=UtilsOferta.getProgramas(obj.Plantel__c, obj.Modalidad__c,obj.Nivel__c);
    }
    @IsTest   public static void getProgramasMoviles(){
        List<SelectOption> programas = new List<SelectOption>();
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        
        FichaPago__c obj = new FichaPago__c(FolioLead__c= nextFolio, TotaPagar__c =333
                                            ,Hasta__c = Date.today()
                                            ,ProgramasRelacionados__c= 'a04R0000003k4RBIAY,a04R0000003k4RSIAY,a04R0000003k4TrIAI' );
        insert obj;
        programas=UtilsOferta.getProgramasMoviles(obj.Id);
    }
    @IsTest   public static void getModalidadesMoviles(){
        List<OfertaEducativa__c> periodos = new List<OfertaEducativa__c>();
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c ='a03R00000059FVrIAM',
                                                        Nivel__c='a03R00000059FVDIA2',
                                                        Programa__c='a04R0000003k4QqIAI',
                                                        Plantel__c='a02R000000NukmYIAR');
        insert obj;
        periodos=UtilsOferta.getModalidadesMoviles(obj.Plantel__c,obj.Periodo__c, obj.Nivel__c, obj.Programa__c);
    }
    @IsTest   public static void getPeriodo(){
        List<SelectOption> periodos = new List<SelectOption>();
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c ='a03R00000059FVrIAM',
                                                        Nivel__c='a03R00000059FVDIA2',
                                                        Programa__c='a04R0000003k4QqIAI',
                                                        Plantel__c='a02R000000NukmYIAR');
        insert obj;
        periodos=UtilsOferta.getPeriodo(obj.Plantel__c,obj.Modalidad__c,  obj.Nivel__c, obj.Programa__c);
    }
    @IsTest   public static void getPeriodos(){
        List<OfertaEducativa__c> periodos = new List<OfertaEducativa__c>();
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c ='a03R00000059FVrIAM',
                                                        Nivel__c='a03R00000059FVDIA2',
                                                        Programa__c='a04R0000003k4QqIAI',
                                                        Plantel__c='a02R000000NukmYIAR');
        insert obj;
        periodos=UtilsOferta.getPeriodos(obj.Plantel__c,obj.Modalidad__c,  obj.Nivel__c, obj.Programa__c);
    }
    @IsTest   public static void getPaises(){
        List<Ubicacion__c> options = new List<Ubicacion__c>();
        options=UtilsOferta.getPaises();
    }
    @IsTest   public static void getEstados(){
        Ubicacion__c obj = new Ubicacion__c(Abreviatura__c ='Nuevo');
        insert obj;
        List<Ubicacion__c> options = new List<Ubicacion__c>();
        options=UtilsOferta.getEstados(obj.IdEstadoPais__c);
    }
    @IsTest   public static void getMunicipios(){
        
        Ubicacion__c obj = new Ubicacion__c(Abreviatura__c ='Nuevo',
                                            IdEstadoPais__c ='7');
        insert obj;
        List<SelectOption> options = new List<SelectOption>();
        options=UtilsOferta.getMunicipios(obj.IdEstadoPais__c);
    }
}