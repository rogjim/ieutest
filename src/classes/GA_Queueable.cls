public with sharing class GA_Queueable implements Queueable,Database.AllowsCallouts {
	public list<Lead> leads {get;set;}
	
	public GA_Queueable(list<Lead> leads){
		this.leads = leads;
	}
    
    public void execute(QueueableContext context) {
    	
    	HttpRequest req = new HttpRequest();
    	HttpResponse response = new HttpResponse();
    	Http http = new Http();
    	String urlEndpoint = '';
    	req.setMethod('GET');
    	for(Lead lead: this.leads){
    			urlEndpoint = 'https://www.google-analytics.com/collect?';
	    		urlEndpoint = urlEndpoint + Utils.encodeQueryParam('cid' , lead.GACID__c) +  Utils.encodeQueryParam('cd1' , lead.Status) + '&'+ Utils.encodeQueryParam('cd2' , lead.Plantel__c) + 'tid=UA-79829568-1&v=1&ni=1&t=event&ec=salesforce&ea=Lead';
	    		req.setEndPoint(urlEndpoint);
	    		try{
	    		response = http.send(req);
	    		if(response.getStatusCode() == 200){
	    			UtilsLog.createLogOk('ANALYTICS',response.toString());
	    		}else{
	    			UtilsLog.createLogError('ANALYTICS',urlEndpoint,response.getStatusCode() + ', ' + response.toString());
	    		}
	    	}catch(Exception e){
	    		UtilsLog.createLogError('ANALYTICS',urlEndpoint,e.getMessage() + ', ' + response.toString());
	    	}
    	}
    	
    }
    
    
}