public without sharing class OPP_PagoTarjetaController {
	
    private Pago__c pagos;
    private Opportunity opportunity;
    public List<String> numTarjeta {get; set;}
    public String concepto {get; set;}
    public String tipoTarjeta {get; set;}
    public String mes {get; set;}
    public String anyo {get; set;}
    public String conceptoNum;
    public String codigo {get; set;}   
    public String error {get; set;}
    public Boolean pagoRealizado {get; set;}
    public String urlComprobante {get; set;}
    public FichaPago__c ficha;
    
    public Opportunity opp{
        get {
            if(opp == null){
                opp = [SELECT Id, Name, Folio__c, ImportePagarSinDescuento__c, ImportePagarConDescuento__c, PrimerPagoConTarjeta__c, DescuentoParaFicha__c, 
                       Nivel__r.Name, Nivel__r.IdInternoNivel__c, Plantel__r.IdInterno__c, Periodo__r.IdPeriodo__c,
                       Periodo__c, Plantel__c, Nivel__c, CorreoCuenta__c, StageName, Pago__c
                       FROM Opportunity 
                       WHERE Id =: opportunity.Id];
            }
            return opp;
        }
        private set;
    }
    
    public OPP_PagoTarjetaController(ApexPages.StandardController stdController) {
        this.opportunity = (Opportunity)stdController.getRecord();
        pagoRealizado = opp.Pago__c == true ? opp.Pago__c : false;
        numTarjeta = new String[4];
        for (Integer i = 0; i<numTarjeta.size(); i++){
            numTarjeta[i] = '';
        }
        pagos = Pago__c.getInstance();
        
        if((opp.Nivel__r.Name).equals('Doctorado') && !opp.PrimerPagoConTarjeta__c){
            concepto = Schema.sObjectType.Pago__c.fields.Examen__c.getLabel();
            conceptoNum = pagos.Examen__c;
        }
        else{
        	concepto = Schema.sObjectType.Pago__c.fields.Inscripcion__c.getLabel();
            conceptoNum = pagos.Inscripcion__c;
        }
    }
    
    
    	    
    public List<SelectOption> getTipoTarjetaSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0', '-- Seleccione --'));  
        options.add(new SelectOption(pagos.TarjetaMasterCard__c, Schema.sObjectType.Pago__c.fields.TarjetaMasterCard__c.getLabel()));
        options.add(new SelectOption(pagos.TarjetaVisa__c , Schema.sObjectType.Pago__c.fields.TarjetaVisa__c.getLabel()));
        return options;
    }

    public List<SelectOption> getMonths() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0', '-- mm --')); 
        for(Integer i=1; i<=12; i++){
            String m = String.valueOf(i);
            if (m.length() == 1){
                m = '0' + m;
            }
            options.add(new SelectOption(m , m));
        }
        return options;
    }
    
    public List<SelectOption> getYears() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0', '-- yyyy --')); 
        Date dateToday = Date.today(); 
        Integer year = (dateToday).year();
        for(Integer i=year; i<=year+15; i++){
            String y = String.valueOf(i);
            options.add(new SelectOption(y, y));
        }
        return options;
    }
    
    public PageReference sentPayment(){
        Map<String, String> datosEnviar = new Map<String, String>();
        Boolean infoCorrect = true; 
        pagoRealizado = false;
        PageReference page;
        
        datosEnviar.put('matricula', opp.Folio__c);
        infoCorrect = (!datosEnviar.containsKey('matricula') || datosEnviar.get('matricula').equals(null) || datosEnviar.get('matricula').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('concepto', conceptoNum);
		infoCorrect = (!datosEnviar.containsKey('concepto') || datosEnviar.get('concepto').equals(null) || datosEnviar.get('concepto').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('descripcionConcepto', concepto);
        infoCorrect = (!datosEnviar.containsKey('descripcionConcepto') || datosEnviar.get('descripcionConcepto').equals(null) || datosEnviar.get('descripcionConcepto').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('cantidad', String.valueOf(opp.ImportePagarConDescuento__c));
        infoCorrect = (!datosEnviar.containsKey('cantidad') || datosEnviar.get('cantidad').equals(null) || datosEnviar.get('cantidad').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('tipo', tipoTarjeta);
        infoCorrect = (!datosEnviar.containsKey('tipo') || datosEnviar.get('tipo').equals(null) || datosEnviar.get('tipo').equals('0')) ? false : infoCorrect; 
        
        datosEnviar.put('pnumero', numTarjeta[0]);
        infoCorrect = (!datosEnviar.containsKey('pnumero') || datosEnviar.get('pnumero').equals(null) || datosEnviar.get('pnumero').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('snumero', numTarjeta[1]);
        infoCorrect = (!datosEnviar.containsKey('snumero') || datosEnviar.get('snumero').equals(null) || datosEnviar.get('snumero').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('tnumero', numTarjeta[2]);
        infoCorrect = (!datosEnviar.containsKey('tnumero') || datosEnviar.get('tnumero').equals(null) || datosEnviar.get('tnumero').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('cnumero', numTarjeta[3]);
        infoCorrect = (!datosEnviar.containsKey('cnumero') || datosEnviar.get('cnumero').equals(null) || datosEnviar.get('cnumero').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('mes', mes);
        infoCorrect = (!datosEnviar.containsKey('mes') || datosEnviar.get('mes').equals(null) || datosEnviar.get('mes').equals('0')) ? false : infoCorrect; 
        
        datosEnviar.put('anio', anyo);
        infoCorrect = (!datosEnviar.containsKey('anio') || datosEnviar.get('anio').equals(null) || datosEnviar.get('anio').equals('0')) ? false : infoCorrect; 
        
        datosEnviar.put('codigo', codigo);
        infoCorrect = (!datosEnviar.containsKey('codigo') || datosEnviar.get('codigo').equals(null) || datosEnviar.get('codigo').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('formaPago', pagos.FormaPago__c);
        infoCorrect = (!datosEnviar.containsKey('formaPago') || datosEnviar.get('formaPago').equals(null) || datosEnviar.get('formaPago').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('nivel', String.valueOf(opp.Nivel__r.IdInternoNivel__c));
        infoCorrect = (!datosEnviar.containsKey('nivel') || datosEnviar.get('nivel').equals(null) || datosEnviar.get('nivel').equals('')) ? false : infoCorrect; 
        
        Date dateToday = Date.today();
        dateToday = dateToday.addMonths(1);
        datosEnviar.put('fechaserver', dateToday.day() +'/'+ dateToday.month() +'/'+ dateToday.year());
        infoCorrect = (!datosEnviar.containsKey('fechaserver') || datosEnviar.get('fechaserver').equals(null) || datosEnviar.get('fechaserver').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('IdPlantel', String.valueOf(opp.Plantel__r.IdInterno__c));
        infoCorrect = (!datosEnviar.containsKey('IdPlantel') || datosEnviar.get('IdPlantel').equals(null) || datosEnviar.get('IdPlantel').equals('')) ? false : infoCorrect; 
        
        datosEnviar.put('periodoEscolar', String.valueOf(opp.Periodo__r.IdPeriodo__c));
        infoCorrect = (!datosEnviar.containsKey('periodoEscolar') || datosEnviar.get('periodoEscolar').equals(null) || datosEnviar.get('periodoEscolar').equals('')) ? false : infoCorrect; 
        
        if(!infoCorrect){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'Todos los parametros son obligatorios'));
            page = ApexPages.CurrentPage();
            return page;
        }
        
        String respuestaSer = EnvioPago(datosEnviar);
        page = ApexPages.CurrentPage();
        
        if(respuestaSer.contains('MAXIMUM ISSUING BANK NAME PER JAN')){
            Integer position = respuestaSer.lastIndexOf('Y_');
            String codigAuto = respuestaSer.substring(position + 2, position + 8);
            createFichaPago(codigAuto);
            pagoRealizado = true;
            ComprobanteLeadCtrl.sendMailComprobante(opp.Folio__c, concepto, opp.CorreoCuenta__c, codigAuto, String.valueOf(opp.ImportePagarConDescuento__c), String.valueOf(ficha.FechaPago__c), pagos.Mensaje_nota_comprobante__c);            
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.CONFIRM, 'La operación fue aprobada, con el siguiente código de aprobación: '+codigAuto+'.'));            
            urlComprobante = 'https://' + String.valueOf(URL.getSalesforceBaseUrl().getHost()) +'/apex/ComprobanteLead?folio='+ encodeASCII(opp.Folio__c);
            urlComprobante += '&concepto='+ encodeASCII(concepto); 
            urlComprobante += '&autorizacion='+ encodeASCII(codigAuto) +'&cantidad='+ encodeASCII(String.valueOf(opp.ImportePagarConDescuento__c))+'&fecha='+ encodeASCII(String.valueOf(ficha.FechaPago__c)) +'&nota2='+ encodeASCII(pagos.Mensaje_nota_comprobante__c); 
            return new PageReference(urlComprobante).setRedirect(true);
            
        }else if(respuestaSer.contains('N_INVALID ACCOUNT NUMBER')){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'El número que usted ingresó no corresponde a los números de tarjetas soportadas por el sistema. Debe verificar el número que digito y corregirlo.'));          
        
        }else if(respuestaSer.contains('N_')){
            error = respuestaSer.substring(respuestaSer.lastIndexOf('-->N_'));
            List<String> partsError = error.split('\n'); 
			error = partsError.size() > 0 ? partsError[0].substring((partsError[0].lastIndexOf('-->N_'))+5) : 'Error al ejecutar la operación por favor intente más tarde';
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, error));          
        
        }else if(respuestaSer.contains('este concepto ya se ha realizado')){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'La transacción para este concepto ya se ha realizado con anterioridad'));          
            pagoRealizado = true;
        
        }else if(respuestaSer.equals('Read timed out') || respuestaSer.contains('N_Servidor Saturado ')){
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, 'No es posible realizar la transacción en este momento, intenete nuevamente más tarde'));          
        
        }else{
            PageMessagesController.addMessage(new PageMessagesController.PageMessage(PageMessagesController.Severity.ERROR, respuestaSer));          
        	//page = new PageReference('/'+opp.Id);
        }
        return page;
    }
    
    public PageReference cancelPayment(){
        PageReference page;
        page = new PageReference('/'+opp.Id);
        page.setRedirect(true);
        return page;
    }
    
   
    public String EnvioPago(Map<String,String> datosPago){
        String url = pagos.EndPoint__c;
        Integer timeout = Integer.valueOf(pagos.TimeOut__c);
        String body = '';
        String bodyLog = '';
        String respuesta = '';      
        
        for(String parametro: datosPago.keySet()){
            body += parametro + '=' + datosPago.get(parametro) + '&';
            if(parametro.contains('numero') || parametro.equals('codigo')){
                bodyLog += parametro + '=' + '***' + '&';
            }
            else{
            	bodyLog += parametro + '=' + datosPago.get(parametro) + '&';
            }
        }
        body = body.removeEnd('&');
        
        Http objhttp;
        HttpRequest req ;
        HttpResponse res ;
        
        objhttp = new Http();
        req = new HttpRequest();
        res = new HttpResponse();
        req.setMethod('POST'); // req.setMethod('GET');
        req.setEndpoint(url);        
        req.setBody(body);
        req.setTimeout(120000);
        try {
            res = objhttp.send(req);
            if(res.getStatusCode() == 200){
                UtilsLog.createLog(UtilsLog.Estatus.CORRECTO, 'POSTenvioPago', bodyLog , String.valueOf(res.getBody()));                
                respuesta = String.valueOf(res.getBody());                
            }
            else{
                UtilsLog.createLogError('POSTenvioPagoE', bodyLog, res.getBody());
                respuesta = res.getBody();
            }
        }
        catch(System.Exception e) {
            UtilsLog.createLogError('POSTenvioPagoEx', bodyLog, e.getMessage()); 
            respuesta = e.getMessage();
        }        
        System.debug(res.getBody());
        return respuesta;
    } 
    
    public void createFichaPago(String folioAutorizacion){
        ficha = new FichaPago__c();      
        ficha.Descuento__c = opp.DescuentoParaFicha__c;
        ficha.FuentePago__c = 'T';
        ficha.Importe__c = opp.ImportePagarSinDescuento__c;
        ficha.MontoPagado__c = opp.ImportePagarConDescuento__c;
        ficha.TotaPagar__c = opp.ImportePagarConDescuento__c;
        ficha.Nivel__c = opp.Nivel__c;
        ficha.NumeroAutorizacion__c = folioAutorizacion;
        ficha.Oportunidad__c = opp.Id;
        ficha.Periodo__c = opp.Periodo__c;
        ficha.Plantel__c = opp.Plantel__c;
        ficha.RecibimosDe__c = opp.Name;
        ficha.TipoTarjeta__c = tipoTarjeta == pagos.TarjetaMasterCard__c ? 'MásterCard' : 'Visa';
        ficha.FechaPago__c = Date.today();
        ficha.Hasta__c = Date.today();
        ficha.HoraPago__c = Datetime.now().format('h:mm a');
        ficha.TipoFicha__c = 'Pago Online';
        ficha.RecordTypeId = Schema.SObjectType.FichaPago__c.getRecordTypeInfosByName().get('Pago Online').getRecordTypeId();
        try{
            insert ficha; 
        }
        catch(Exception e){
            UtilsLog.createLogError('InsertNewFichaPagoByPagoConTarjeta', String.valueOf(ficha), e.getMessage());
        }
        
    }
    
    public static String encodeASCII(String cadena){
        return EncodingUtil.urlEncode(cadena, 'UTF-8');
    }
    
}