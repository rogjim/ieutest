public class ProcessBuilderMethods {
	@InvocableMethod
    public static void changeStateOpportunity(List<Id> oppId){
        Opportunity opp = [SELECT id, Grupo__r.Estatus__c, Grupo__r.AutorizaGrupo__c FROM Opportunity WHERE Id =: oppId[0]];
        if(opp.Grupo__r.Estatus__c == 'Autorizado'){
            opp.StageName = 'Ganada';
        }else{
            opp.StageName = 'Inscrito';
        }
        update opp;
    }
}