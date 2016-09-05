@IsTest  public class UtilsTest {
    
    @IsTest   public static void getListCampos(){
        SObjectType targetObject = Schema.getGlobalDescribe().get('Account');
        List<String> listCampos = new List<String>();
        listCampos = Utils.getListCampos(targetObject);
    }
    @IsTest   public static void getStrCampos(){
        SObjectType targetObject = Schema.getGlobalDescribe().get('Account');
        String listaNombres ='' ;
        listaNombres=Utils.getStrCampos(targetObject);
    }
    @IsTest   public static void getPromotoresByPlantel(){
        Map<Id,list<Promotor__c>> Mapa = new Map<Id,list<Promotor__c>>();
        Mapa = Utils.getPromotoresByPlantel();
    }
    @IsTest   public static void  getAccademicOfertByPeriodo(){
        Periodo__c ObjPeriodo = new Periodo__c(Name = 'demo', 
                                               FechaInicio__c=Date.newInstance(2008, 1, 30),
                                               FechaInicioReal__c=Date.newInstance(2008, 1, 30),
                                               FechaFin__c=Date.newInstance(2008, 2, 30),
                                               FechaFinReal__c=Date.newInstance(2008, 2, 30));
        insert ObjPeriodo;
        OfertaEducativa__c obj = new OfertaEducativa__c(Periodo__c =  ObjPeriodo.Id);
        Map<Id,OfertaEducativa__c> Periodo = new Map<Id,OfertaEducativa__c>();
        Periodo = Utils.getAccademicOfertByPeriodo(ObjPeriodo);
    }
    @IsTest   public static void getProgramByRVOE(){
        RVOE__c obj = new RVOE__c(Activo__c='Activo');
        insert obj;
        Id idPrograma = null;
        String idModalidad='';
        String idNivel='';
        String idPlantel='';
        String programa='';
        idPrograma=Utils.getProgramByRVOE(idModalidad, idNivel, idPlantel, programa);
    }
    @IsTest   public static void getModalidad(){
        Lead lead = new Lead();
        Catalogo__c catalogModalidad = null;
        catalogModalidad= Utils.getModalidad(lead);
    }
    /*   @IsTest   public static void assignPictureProfileUrl(){
//set<Id> idUsers , list<Promotor__c> newList
set<Id> idUsers= new User  (FirstName ='demo' , LastName ='demo');
// User usuario = new User  (FirstName ='demo' , LastName ='demo');
insert idUsers;
list<Promotor__c> newList;
utils.assignPictureProfileUrl(idUsers, newList);
// Utils.assignPictureProfileUrl(usuario.Id, newList);
}*/
    @IsTest   public static void getMapLeadsByKey(){
        map<String,Integer> mapLeadByKey = new map<String,Integer>();
        mapLeadByKey=Utils.getMapLeadsByKey();
    }
    @IsTest   public static void nullToEmpty(){
        String Cadena='demo';
        Cadena=Utils.nullToEmpty(Cadena);
    }
    @IsTest   public static void getHSBCReference(){
        String referenceHSBC ='';
        String folio='1271';
        String fechaCond= '1305';
        String constante='2';
        String pago='3347.50';
        referenceHSBC=Utils.getHSBCReference( folio,  fechaCond,  constante,  pago);
    }
    @IsTest   public static void getOXXOReference(){
        String cadenaCodigo='783786876';
        String referenceHSBC ='';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
        cadenaCodigo='7837868.76';
        cadenaCodigo=Utils.getOXXOReference( cadenaCodigo);
    }
    @IsTest   public static void getCatalogoId(){
        String tipo='Nivel';
        String valor='Doctorado';
        String retorno = '';
        retorno=Utils.getCatalogoId(  tipo, valor);
        tipo='Plantel';
        retorno=Utils.getCatalogoId(  tipo, valor);
        tipo='Programa';
        retorno=Utils.getCatalogoId(  tipo, valor);
    }
    @IsTest   public static void createLog(){
        Utils.Estatus e =Utils.Estatus.CORRECTO;
        String metodo='metodo';
        String enviado='enviado';
        String respuesta='respuesta';
        Utils.createLog(  e, metodo, enviado, respuesta);
    }
    @IsTest   public static void createLogOK(){
        String metodo='metodo';
        String respuesta='respuesta';
        Utils.createLogOK( metodo,respuesta);
    }
    @IsTest   public static void createLogError(){
        String metodo='metodo';
        String respuesta='respuesta';
        String enviado='enviado';
        Utils.createLogError(  metodo, enviado,  respuesta);
    }
    @IsTest   public static void createLogOK2(){
        String metodo='metodo';
        String respuesta='respuesta';
        String jobId='jobId';
        Integer elements= 11;
        Utils.createLogOK(  metodo, respuesta,  jobId,  elements);
    }
    @IsTest   public static void createLogError2(){
        String metodo='metodo';
        String respuesta='respuesta';
        String jobId='jobId';
        String enviado='enviado';
        Integer elements= 11;
        Utils.createLogError(  metodo, enviado,  respuesta,  jobId,  elements);
    }   
    @IsTest   public static void encodeQueryParam(){
        String paramName='nombre';
        String paramVal='22';
        paramName=Utils.encodeQueryParam(  paramName, paramVal);
    }
}