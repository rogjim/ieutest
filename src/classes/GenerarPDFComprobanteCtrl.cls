public with sharing class GenerarPDFComprobanteCtrl { 
    Public FichaPago__c idToken {get; set;} 
    FichaPago__c  ord;  
        
    public GenerarPDFComprobanteCtrl( ){
        
    } 
    @future(callout=true)
    public static void sendMailComprobante(String folio, String concepto,String mail, String autorizacion, String cantidad, String id){ 
        //System.debug('ENTRA A SENDMAILCOMPROBANTE');
        FichaPago__c  ord; 
        DateTime hoy = datetime.now();
        
        String fecha= string.valueOf(hoy.format('dd/MM/yyyy HH:mm:ss') ); 
        ord = new  FichaPago__c();  
        ord = [SELECT  Notas2__c FROM FichaPago__c  WHERE Id = :id limit 1]; 
        String nota2=ord.Notas2__c; 
        if(folio!=''|| concepto!=''|| autorizacion !=''|| cantidad !='' ){  
            ComprobanteLeadCtrl.sendMailComprobante(folio, concepto,mail, autorizacion, cantidad ,fecha, nota2   );
        } else{
            
        }
        
        
    }
}