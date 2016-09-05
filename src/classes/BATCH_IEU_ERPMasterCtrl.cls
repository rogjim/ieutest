public class BATCH_IEU_ERPMasterCtrl {
	
    @RemoteAction
    public static List<AsyncApexJob> executeMethod(String method) {
    	List<AsyncApexJob> response = new List<AsyncApexJob>();
    	List<String> ids = new List<String>();
    	if(method != null && String.isNotEmpty(method)) {
    		ID jobId = null;
	    	Batch_IEU_ERPMaster batch = null;
	    	if(method == 'addCandidatoInfo') {
		    	batch = new Batch_IEU_ERPMaster('addCandidatoInfo');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId));
				/*
		    	batch = new Batch_IEU_ERPMaster('addCandidatoInfo_OP');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId)); */
	    	} else if(method == 'addGrupoInfo') {
		    	batch = new Batch_IEU_ERPMaster('addGrupoInfo');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId));
	    	} else if(method == 'addBecasInfo') {
		    	batch = new Batch_IEU_ERPMaster('addBecasInfo');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId));
				/**
		    	batch = new Batch_IEU_ERPMaster('addBecasInfo_OP');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId)); */
	    	} else if(method == 'addPagosGrupoInfo') {
		    	batch = new Batch_IEU_ERPMaster('addPagosGrupoInfo');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId));
	    	} else if(method == 'addPagosInscripcionInfo') {
		    	batch = new Batch_IEU_ERPMaster('addPagosInscripcionInfo');
		    	jobId = database.executebatch(batch, 100);
		    	ids.add(String.valueOf(jobId));
	    	} else {
	    		ids.add('ERROR|Método ' + method + ', no está definido.');
	    	}
    	} else {
    		ids.add('ERROR|Método es requerido.');
    	}
    	return getStatusTask(ids);
    }

    @RemoteAction
    public static List<AsyncApexJob> getStatusTask(List<String> ids) {
    	List<AsyncApexJob> response = new List<AsyncApexJob>();
    	if(ids != null && ids.size() > 0) {
	    	for(String id : ids) {
	    		List<AsyncApexJob> a = [SELECT Id, CreatedDate, CompletedDate,TotalJobItems, JobItemsProcessed, NumberOfErrors, ApexClass.Name, JobType, Status FROM AsyncApexJob WHERE Id =:id];
	    		if(a.size() > 0) {
	    			response.add(a[0]);
	    		}

	    	}
	    }
    	return response;
    }

}