public with sharing class CalculadoraInfoCtrl {
    public String idLead {get; set;}
    public Lead dataLead {get; set;}
    public Date vigencia {get; set;}
    public Date hoy;
    
    public CalculadoraInfoCtrl(){
        idLead = System.currentPagereference().getParameters().get('id');
        dataLead = [Select Name, Email, Modalidad__r.Name, Nivel__r.Name, Plantel__r.Name, Programa__r.Name, Promedio__c, PorcentajeBeca__c, FolioCalculadora__c, 
                    Inscripcion__c, InscripcionDescuento__c, Colegiatura__c, ColegiaturaDescuento__c, Numero_Mensualidades__c, VigenciaDescuento__c, OfertaEducativa__c  
                    FROM Lead WHERE Id = : idLead ];
        hoy = Date.today();
	    vigencia = hoy.addDays(10); 
    }
    
    /**
    * @author:      Gabriel Garcia
    * @date:        04/07/2016
    * @description: Método para obtener los Montos por oferta educativa
    * @param:       
    * @return:      
    */
    @RemoteAction
    public static Map<String, String> getMontos(String ofe){
    	Map<String, String> montos = new Map<String , String>();
        List<OfertaConceptoPagos__c> listMontos = new List<OfertaConceptoPagos__c>();
        listMontos = [SELECT Id, Monto__c, ConceptoPago__r.Name, OfertaEducativa__c FROM OfertaConceptoPagos__c  WHERE OfertaEducativa__c =: ofe];
        for(OfertaConceptoPagos__c mont: listMontos){
            montos.put(mont.ConceptoPago__r.Name, String.valueOf(mont.Monto__c));
        }
        return montos;
    }
}