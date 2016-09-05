public with sharing class BarCodeLeadCtrl {
    public String hasta {get; set;}
    public String recibimosde {get; set;}
    public String pago {get; set;}
    public String nota1 {get; set;}
    public String nota2 {get; set;}
    public String folio {get; set;}
    public String HSBCRef {get; set;}
    public String cadenaCodigo {get; set;}
    public String concept {get; set;}
    public String encabezado {get; set;}
    
    
    
    public BarCodeLeadCtrl(){
        String myDate = apexpages.currentpage().getparameters().get('Hasta');
        String[] myDateOnly = myDate.split(' ');
        String[] strDate = myDateOnly[0].split('-');
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        Integer myIntDate = integer.valueOf(strDate[2]);
        hasta = myIntDate +'-'+myIntMonth+'-'+myIntYear;
        recibimosde = apexpages.currentpage().getparameters().get('recibimosde');
		pago = apexpages.currentpage().getparameters().get('pago');
        nota1 = apexpages.currentpage().getparameters().get('Nota1');
		nota2 = apexpages.currentpage().getparameters().get('Nota2');
        folio = apexpages.currentpage().getparameters().get('folio');
        HSBCRef = apexpages.currentpage().getparameters().get('HSBC');
        cadenaCodigo = apexpages.currentpage().getparameters().get('Oxxo');
        concept = apexpages.currentpage().getparameters().get('Concepto');
        encabezado = apexpages.currentpage().getparameters().get('encabezado');
        
    }
    
	@future(callout=true)
	public static void sendMail(Date hasta, String nota1, String nota2, String concepto, String leadmail,String recibimosde, String folioR, String pagoR, String refHSBC, String refOXXO, String encabezado){
        System.debug(encabezado);
    
        
         String url ='';
        if ( ValidaEntorno.isSandbox()) { 
            url = 'https://sandbox-ieu.cs2.force.com/apex/BarCodeLead?recibimosde='+ encodeASCII(recibimosde) + '&pago='+ encodeASCII(pagoR); 
        url = url + '&folio='+ encodeASCII(folioR) +'&HSBC='+ encodeASCII(refHSBC) +'&Oxxo='+ encodeASCII(refOXXO);
        url = url + '&Concepto=' + encodeASCII(concepto) + '&Nota1=' + encodeASCII(nota1) +'&Nota2=' + encodeASCII(nota2) + '&Hasta=' + encodeASCII(String.valueOf(hasta));
		url = url + '&encabezado=' + encodeASCII(encabezado);        
  
        } else { 
            url = 'https://c.cs2.visual.force.com/apex/BarCodeLead?recibimosde='+ encodeASCII(recibimosde) + '&pago='+ encodeASCII(pagoR); 
        url = url + '&folio='+ encodeASCII(folioR) +'&HSBC='+ encodeASCII(refHSBC) +'&Oxxo='+ encodeASCII(refOXXO);
        url = url + '&Concepto=' + encodeASCII(concepto) + '&Nota1=' + encodeASCII(nota1) +'&Nota2=' + encodeASCII(nota2) + '&Hasta=' + encodeASCII(String.valueOf(hasta));
		url = url + '&encabezado=' + encodeASCII(encabezado);        
        }

 
 

        PageReference pdf = new PageReference(url);
		//System.debug('/apex/BarCodeLead?recibimosde='+recibimosde+'&pago='+pagoR+'&folio='+folioR+'&HSBC='+refHSBC+'&Oxxo='+refOXXO+'&Concepto='+concepto+'&Nota1='+nota1+'&Nota2='+nota2+'&Hasta='+hasta);
        System.debug(url);
     
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		Blob body;
		try {
			body = pdf.getContent();
		} catch (VisualforceException e) {
			body = Blob.valueOf('Some Text');
		}
		
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Ficha de pago.pdf');
        
        attach.Body = body;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { leadmail });
        mail.setSubject('Ficha de pago');
        mail.setHtmlBody('PFA');
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