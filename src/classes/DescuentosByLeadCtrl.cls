public with sharing class DescuentosByLeadCtrl {
    
    public List<Descuento__c> descuentos { set;}
    public List<SolicitudBeca__c> becas { set;}
    private	String Id_number;
    
    /**
    * @author:      Gerardo Martínez
    * @date:        24/06/2016
    * @description: Carga el id de un lead cuando se abre la visual force de detalles de un lead
    * @param:       ApexPages.StandardController
    * @return:      
    */
    
    public DescuentosByLeadCtrl(ApexPages.StandardController controller){
        Lead leadObj = (Lead)controller.getRecord();
        Id_number = leadObj.Id;
    }
   
    /**
    * @author:      Gerardo Martínez
    * @date:        24/06/2016
    * @description: Obtiene los descuentos asociados a un lead
    * @param:       
    * @return:      List<Descuento__c >
    */
    
    public List<Descuento__c > getDescuentos() {
        List<Descuento__c > results = [SELECT Id, Name, Estatus__c,CreatedDate,PorcentajeDescuento__c FROM Descuento__c Descuento WHERE Descuento.Lead__c =:Id_number];
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
        List<SolicitudBeca__c > results = [SELECT Id, Name, Estatus__c,CreatedDate,Porcentaje__c,Beca__c  FROM SolicitudBeca__c WHERE Lead__c =:Id_number];
        return results;
	}


}