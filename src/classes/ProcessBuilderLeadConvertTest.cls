@isTest public class ProcessBuilderLeadConvertTest {
@isTest   public static void leadConvert(){
    
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
    
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio)
                             );
        insert lead;
    
    List<Id> leadId = new List<Id>();
leadiD.add(lead.Id);
    ProcessBuilderLeadConvert.leadConvert(leadId);
}
}