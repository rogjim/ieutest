global class MailAsignacionPromotor {
    @future(callout=true)
    public static void sendMail(Id leadId, String mailLead){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        String mailPromotor = [SELECT Promotor__r.Promotor__r.Email FROM Lead WHERE Id =: leadId Limit 1].Promotor__r.Promotor__r.Email;
        
        String url ='';
        if ( ValidaEntorno.isSandbox()) { 
            url = 'https://sandbox-ieu.cs2.force.com/MailPromotorAsignado?Id=' + leadId;
        } else { 
            url = 'https://c.cs2.visual.force.com/apex/MailPromotorAsignado?Id=' + leadId;
        }
        
        PageReference pdf = new PageReference(url);
        
        Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { mailLead });
        mail.setSubject('Informes IEU');                
        mail.setHtmlBody(body.toString());
        mail.setReplyTo(mailPromotor);
        mails.add(mail);  
        
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        }  
        
    }
    
    @future(callout=true)
    public static void sendMail(String Idleads){
        Idleads = Idleads.replace('{','');
        Idleads = Idleads.replace('}','');
        
        list<String> ids = Idleads.split(',');
        list<Lead> leads = [SELECT id,Name,email,Promotor__r.Promotor__r.Email FROM Lead WHERE Id IN : ids];
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        for(Lead lead : leads){
            
            String url ='';
            
            if ( ValidaEntorno.isSandbox()) { 
                url = 'https://sandbox-ieu.cs2.force.com/MailPromotorAsignado?Id=' + lead.Id;
            } else { 
                url = 'https://c.cs2.visual.force.com/apex/MailPromotorAsignado?Id=' + lead.Id;
            }
            
            PageReference pdf = new PageReference(url);
            
            Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { lead.email });
            mail.setSubject('Informes IEU'); 
            mail.setHtmlBody(body.toString());
            mail.setReplyTo(lead.Promotor__r.Promotor__r.Email);
            mails.add(mail); 
        } 
        
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        } 
    }
    
    
}