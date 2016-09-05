global with sharing class ProcessBuilderMailAsignarPromotor {
    @InvocableMethod
    global static void sendMail(list<Lead> leads){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        map<Id,String> mapPromotorMail = new map<Id,String>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         
        for(Lead lead:leads){
        	String url = 'https://c.cs2.visual.force.com/apex/MailPromotorAsignado?Id=' + lead.Id;
	        PageReference pdf = new PageReference(url);
	     
	        Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
	
	      //  Blob body = pdf.getContent();
	       
	        mail.setToAddresses(new String[] { lead.Promotor__r.Promotor__r.Email});
	        mail.setSubject('Promotor Asignado');                
	        mail.setHtmlBody(body.toString());
	        mail.setReplyTo(lead.email);
	        mails.add(mail);  
	        
        }
        if(!mails.isEmpty())
	        {
	            Messaging.SendEmail(mails);
	        } 
        
        
        /*String mailPromotor = [SELECT Promotor__r.Promotor__r.Email FROM Lead WHERE Id =: leadId Limit 1].Promotor__r.Promotor__r.Email;
        String url = 'https://c.cs2.visual.force.com/apex/MailPromotorAsignado?Id=' + leadId;
        PageReference pdf = new PageReference(url);
     
        Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');

      //  Blob body = pdf.getContent();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { mailLead });
        mail.setSubject('Promotor Asignado');                
        mail.setHtmlBody(body.toString());
        mail.setReplyTo(mailPromotor);
        mails.add(mail);  
        
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        } */
        
    }
}