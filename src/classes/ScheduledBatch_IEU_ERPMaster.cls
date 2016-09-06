global with sharing class ScheduledBatch_IEU_ERPMaster implements Schedulable {
	
    global void execute(SchedulableContext sc) {

    	Batch_IEU_ERPMaster batch = new Batch_IEU_ERPMaster('addCandidatoInfo');
    	database.executebatch(batch, 100);
 
        /*
        batch = new Batch_IEU_ERPMaster('addCandidatoInfo_OP');
        database.executebatch(batch, 100); */

    	batch = new Batch_IEU_ERPMaster('addGrupoInfo');
    	database.executebatch(batch, 100);
    	
    	batch = new Batch_IEU_ERPMaster('addBecasInfo');
    	database.executebatch(batch, 100);
        /*
        batch = new Batch_IEU_ERPMaster('addBecasInfo_OP');
        database.executebatch(batch, 100); */
    	
    	batch = new Batch_IEU_ERPMaster('addPagosGrupoInfo');
    	database.executebatch(batch, 100);
    	
    	batch = new Batch_IEU_ERPMaster('addPagosInscripcionInfo');
    	database.executebatch(batch, 100);
    }
}