public with sharing class DescuentosByOpportunityCtrl {
   
    public List<Descuento__c > descuentos { set;}
    public List<SolicitudBeca__c> becas { set;}
    private	String Id_number;
    
  /**
    * @author:      Gerardo Martínez
    * @date:        27/06/2016
    * @description: Carga el id de un lead cuando se abre la visual force de detalles de un lead
    * @param:       ApexPages.StandardController
    * @return:      
    */
    
    public DescuentosByOpportunityCtrl(ApexPages.StandardController ctrl){
        Opportunity oppObj = (Opportunity)ctrl.getRecord();
        Id_number = oppObj.Id;
    }
    
  	/**
    * @author:      Gerardo Martínez
    * @date:        27/06/2016
    * @description: Obtiene los descuentos asociados a una Opportunity
    * @param:       
    * @return:      List<Descuento__c >
    */
    
    public List<Descuento__c > getDescuentos() {
        List<Descuento__c > results = [SELECT Id, Name, Estatus__c,CreatedDate,PorcentajeDescuento__c FROM Descuento__c Descuento WHERE Descuento.Oportunidad__c  =:Id_number];
        return results;
	}
    
    /**
    * @author:      Gerardo Martínez
    * @date:        24/06/2016
    * @description: Obtiene los descuentos asociados a un lead
    * @param:       
    * @return:      List<Descuento__c >
    */
    public List<SolicitudBeca__c> getBecas() {
        List<SolicitudBeca__c > results = [SELECT Id, Name, Estatus__c,CreatedDate,Porcentaje__c,Beca__c  FROM SolicitudBeca__c solicitudBeca WHERE solicitudBeca.Oportunidad__c =:Id_number];
        return results;
	}


}