public class UtilsLog {
	public  enum Estatus {CORRECTO, ERROR}
    /**
    * @author:      Rogelio Jiménez
    * @date:        03/16/2016
    * @description: Regresa una lista con los nombres de los campos del objeto especificado
    * @param:       Schema.SObjectType targetObject
    * @return:      List<String>
    */
    public static List<String> getListCampos(Schema.SObjectType targetObject){
        List<String> listCampos = new List<String>();
        Set<String> setCamposParaExcluir = new Set<String>{'CreatedById', 'CreatedDate', 'SystemModstamp', 'LastModifiedDate', 'LastModifiedById', 'LastReferencedDate', 'LastViewedDate', 'IsDeleted'};


        List<Schema.sObjectField> lSobjectFields = targetObject.getDescribe().fields.getMap().values();
        for(Schema.sObjectField sob : lSobjectFields){
      
            Schema.DescribeFieldResult f = sob.getDescribe();
            //NO agregar campos que no se necesitan
            String nombreCampo = f.getName();
            if(!setCamposParaExcluir.contains(nombreCampo)) listCampos.add(nombreCampo);
        }
        return listCampos;
    }
    /**
    * @author:      Rogelio Jiménez
    * @date:        03/16/2016
    * @description: Regresa una cadena con los nombres de los campos de un objeto especificado separados por coma
    * @param:       Schema.SObjectType targetObject
    * @return:      String
    */
    public static String getStrCampos(Schema.SObjectType targetObject){
        return String.join(getListCampos(targetObject), ', ');
    }
    
     /**
    * @author:      Rogelio Jiménez
    * @date:        20/06/2016
    * @description: Utiletias para crear registros en el objeto LogIntegracion
    * @param:       
    * @return:      
    */
    public static void createLog(Estatus estatus,String metodo, String enviado, String respuesta){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = String.valueOf(estatus), Metodo__c = metodo,
    												 EnvioWS__c = enviado,RespuestaWS__c = respuesta);
    	insert log;
    }
    
    public static void createLogOK(String metodo,String respuesta){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'CORRECTO', Metodo__c = metodo,RespuestaWS__c = respuesta);
    	insert log;
    }
    
    public static void createLogError(String metodo,String enviado, String respuesta){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'ERROR', Metodo__c = metodo,EnvioWS__c = enviado,RespuestaWS__c = respuesta);
    	insert log;
    }
    
    public static void createLogOK(String metodo,String respuesta, String jobId, Integer elements){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'CORRECTO', Metodo__c = metodo,RespuestaWS__c = respuesta, ApexJobId__c = jobId, NumeroRegistros__c = elements);
    	insert log;
    }
    
    public static void createLogError(String metodo,String enviado, String respuesta, String jobId, Integer elements){
    	LogIntegracion__c log = new LogIntegracion__c(Estatus__c = 'ERROR', Metodo__c = metodo,EnvioWS__c = enviado,RespuestaWS__c = respuesta, ApexJobId__c = jobId, NumeroRegistros__c = elements);
    	insert log;
    }
}