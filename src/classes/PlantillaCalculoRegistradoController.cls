public with sharing class PlantillaCalculoRegistradoController {
    public Id id {get; set;}
	public String promedio {get; set;}
    public String descuentoInsc {get; set;}
    public String descuentoMens {get; set;}
    public Double inscripcionDescuento {get; set;}
    public Double colegiaturaDescuento {get; set;}
    public String vigencia {get; set;}
    public Lead lead {get; set;}
    
    public PlantillaCalculoRegistradoController(){
        id = apexpages.currentpage().getparameters().get('id');
        promedio = apexpages.currentpage().getparameters().get('prom');
        descuentoInsc = apexpages.currentpage().getparameters().get('descInsc');
        descuentoMens = apexpages.currentpage().getparameters().get('descMens');
        vigencia = apexpages.currentpage().getparameters().get('vig');
        lead = [Select Modalidad__r.Name, Nivel__r.Name, Plantel__r.Name, Programa__r.Name, Promedio__c, PorcentajeBeca__c, 
                FolioCalculadora__c, Inscripcion__c, InscripcionDescuento__c, PorcentajeDescuento__c, Colegiatura__c, 
                ColegiaturaDescuento__c, Numero_Mensualidades__c, VigenciaDescuento__c, OfertaEducativa__c  
                FROM Lead WHERE Id = : id ];
        lead.PorcentajeDescuento__c = Integer.valueOf(descuentoInsc);
        lead.PorcentajeBeca__c = Integer.valueOf(descuentoMens);
        lead.Promedio__c = promedio;
        lead.VigenciaDescuento__c = Date.valueOf(vigencia);
        inscripcionDescuento = Double.valueOf(lead.Inscripcion__c) * (1-(Double.valueOf(descuentoInsc)/100));
        colegiaturaDescuento= Double.valueOf(lead.Colegiatura__c) * (1-(Double.valueOf(descuentoMens)/100));
        
    }
    
    @future(callout=true)
    public static void sendMail(Id leadId, String mailLead, String promedioL, String descuentoInscL, String descuentoMensL, String vigenciaL){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();        
        String hostUrl = URL.getSalesforceBaseUrl().getHost();
        String urlM ='';
        if ( ValidaEntorno.isSandbox()) { 
            urlM = 'https://sandbox-ieu.cs2.force.com/PlantillaCalculoRegistrado?Id=' + leadId + '&prom='+promedioL+'&descInsc='+descuentoInscL+'&descMens='+descuentoMensL+'&vig='+vigenciaL;
        } else { 
            urlM = 'https://c.cs2.visual.force.com/apex/PlantillaCalculoRegistrado?Id=' + leadId + '&prom='+promedioL+'&descInsc='+descuentoInscL+'&descMens='+descuentoMensL+'&vig='+vigenciaL;
        }
        
        PageReference pdf = new PageReference(urlM);
        
        Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { mailLead });
        mail.setSubject('Cálculo de tu colegiatura');                
        mail.setHtmlBody(body.toString());
        //mail.setReplyTo(mailPromotor);
        mails.add(mail);  
        
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        }  
        
    }
    
}