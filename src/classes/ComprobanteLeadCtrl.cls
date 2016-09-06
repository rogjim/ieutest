public with sharing class ComprobanteLeadCtrl {
    public String folio {get; set;}
    public String concepto {get; set;}
    public String autorizacion {get; set;}
    public String cantidad {get; set;}
    public String fecha  {get; set;} 
    public String encabezado {get; set;}
    public String nota2 {get; set;}
    
    public ComprobanteLeadCtrl(){ 
        System.debug('entra a controlador ComprobanteLeadCtrl');
        Integer myIntDate = 9;
        folio = apexpages.currentpage().getparameters().get('folio');
        fecha =apexpages.currentpage().getparameters().get('fecha');
        concepto= apexpages.currentpage().getparameters().get('concepto');
        autorizacion = apexpages.currentpage().getparameters().get('autorizacion');
        cantidad = apexpages.currentpage().getparameters().get('cantidad');
        nota2 = apexpages.currentpage().getparameters().get('nota2');
    } 
    
    @future(callout=true)
    public static void sendMailComprobante(String folioR, String concepto, String leadmail, String autorizacion, String cantidad ,String fecha, String nota2){
        System.debug('entra a sendMailComprobante' + folioR + ' ' + concepto + ' ' + leadmail + ' ' + autorizacion + ' ' + cantidad + ' ' + fecha + ' ' + nota2 + ' ');
        String url ='';
        if ( ValidaEntorno.isSandbox()) { 
            url = 'https://c.cs2.visual.force.com/apex/ComprobanteLead?folio='+ encodeASCII(folioR) ;
            url = url +  '&concepto='+ encodeASCII(concepto); 
            url = url + '&autorizacion='+ encodeASCII(autorizacion) +'&cantidad='+ encodeASCII(cantidad)+'&fecha='+ encodeASCII(fecha) +'&nota2='+ encodeASCII(nota2); 
        } else { 
            url = 'https://c.cs2.visual.force.com/apex/ComprobanteLead?folio='+ encodeASCII(folioR) + '&concepto='+ encodeASCII(concepto); 
            url = url + '&autorizacion='+ encodeASCII(autorizacion) +'&cantidad='+ encodeASCII(cantidad) ;
        }
        System.debug('Comprobante url-------- ' +url);     
        
        PageReference pdf = new PageReference(url); 
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Blob body;
        try {
            
           body = pdf.getContent();
            //    body = pdf.getContentAsPDF();
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }
        
        System.debug('pdf---> '+body);
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Comprobante de Pago.pdf');
        
        attach.Body = body;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { leadmail });
        mail.setSubject('Comprobante de Pago');
        mail.setHtmlBody('PFA');
        System.debug('attach---> '+attach);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        mails.add(mail);  
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        }   
    }
    
    public static String encodeASCII(String cadena){
        return EncodingUtil.urlEncode(cadena, 'UTF-8');
    }
}