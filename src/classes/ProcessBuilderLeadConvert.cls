public class ProcessBuilderLeadConvert {
	@InvocableMethod
    public static void leadConvert(List<Id> leadId){
        for(Id lead: leadId){
            ProcessBuilderLeadConvert.convertLead(lead);
        }
    }
    
    @future(callout=true)
    public static void convertLead(Id leadId){
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(leadId);
        
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        Id oppId = lcr.getOpportunityId();
        
        Opportunity opp = [SELECT id, Grupo__r.Estatus__c  FROM Opportunity WHERE Id =: oppId];
        if(opp.Grupo__r.Estatus__c  == 'Autorizado'){
            opp.StageName = 'Ganada';
        }else{
            opp.StageName = 'Inscrito';
        }
        opp.Pago__c = true;
        update opp;
    }
}