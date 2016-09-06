@isTest public class MailAsignacionPromotorTest {
    
    @IsTest  (SeeAllData=true)
    public static void test(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date fin = date.today();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo' 
                                         );
        insert  plan;
        
        /*  Profile perfil = new Profile( Name='demo'
);
insert perfil;



User usuario = new User( Username='dsanchez@ctconsulting.com.mx',
LastName='demo',
Alias='demo',
CommunityNickname='IEUdemo',
TimeZoneSidKey='America/Mexico_City', 
LocaleSidKey='es_MX', 
EmailEncodingKey='ISO-8859-1',
ProfileId=perfil.Id,
LanguageLocaleKey ='es',
Email='dsanchez@ctconsulting.com.mx'
);
insert usuario;
*/
        User usuario = [ select Id,Username,LastName,Alias,CommunityNickname,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,ProfileId,LanguageLocaleKey,Email from User where Id = :UserInfo.getUserId() ];
        
        Promotor__c promotor = new Promotor__c( 
            Promotor__c=usuario.Id,
            Plantel__c=plan.id,
            OrdenNumerico__c=90,
            Meta__c=3
            
        );
        insert promotor;
        
        
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio),
                              VigenciaDescuento__c=fin,
                              FirstName='demo',
                              Promotor__c=promotor.Id
                             );
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        
        
        Id leadId =lead.id;
        String mailLead='dsanchez@ctconsulting.com.mx';
        
        MailAsignacionPromotor obj = new MailAsignacionPromotor();
        
        // obj.sendMail(leadId, mailLead);
        try{
            MailAsignacionPromotor.sendMail(leadId, mailLead); 
        }catch(exception e){
            
        }
        
        
   
    
    
}

}