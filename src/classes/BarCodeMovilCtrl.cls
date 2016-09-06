public with sharing class BarCodeMovilCtrl {

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
    public String sig {get; set;}
    public String plantel {get; set;}
    public List<String> programas {get; set;}
    public String totalPagar {get; set;}
    public List<FichaPago__c> fichas {get; set;}
    
    
    public BarCodeMovilCtrl(){
      
        String Ids = apexpages.currentpage().getparameters().get('ids');
       
        programas = new List<String>();
        
         //Obtener Fichas de la base de datos
        fichas = getFichasFromString(Ids);
        
        if(fichas.size()>0){
            
            //Asignar valores que no cambian en las fichas de pago
            hasta = refactorDate(fichas.get(0).Hasta__c);
            totalPagar = String.valueOf(fichas.get(0).TotaPagar__c);
            nota1 = fichas.get(0).Notas1__c;
            concept = fichas.get(0).Concepto__c;
    
            
            //Asignar plantel obtenido de la base de datos
            Plantel__c plantelObj= [SELECT Id,Name,Instituto__c  FROM Plantel__c WHERE Id=:fichas.get(0).Plantel__c];
            Instituto__c ns = [SELECT Id,Name FROM Instituto__c WHERE Id=:plantelObj.Instituto__c ];
           	System.debug(fichas.get(0));
            encabezado=GetResourceURL(fichas.get(0).Plantel__r.Instituto__r.Encabezado__c); 
            System.debug(encabezado);
            
            
            
            if(plantelObj.Name.length()>0){
                plantel=plantelObj.Name;
            }
          
            //Obtener los Programas Relacionados a la ficha y asginagnarlos a una lista de strings 
            List<Programa__c> programasR= getProgramasRelacionados(fichas.get(0).ProgramasRelacionados__c);
            for(Programa__c  prog:  programasR ){
                programas.add(prog.Name+'<br/>');
            }
        }
        
        
    }
    
	@future(callout=true)
	public static void sendMail(String ids){
       
       
        String url = 'https://sandbox-ieu.cs2.force.com/apex/BarCodeMovil?ids='+ids;
        PageReference pdf = new PageReference(url);
        System.debug(url);
     
        String userName = UserInfo.getUserName();
       	User activeUser = [Select Email From User where Username = : userName limit 1];
		String userEmail = activeUser.Email;
        
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
        mail.setToAddresses(new String[] { userEmail });
        mail.setSubject('PDF Generation');
        mail.setHtmlBody('PFA');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        mails.add(mail);  
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        }
	}

    public static String encodeASCII(String cadena){
        return EncodingUtil.urlEncode(cadena, 'ASCII');
    }
    
  	/**
    * @author:      Gerardo Martínez
    * @date:        05/08/2016
    * @description: Reorganiza una fecha en el formato del cliente.  
    * @param:       Date
    * @return:      String
    */
 
    public static String refactorDate(Date dateToCast){
        String myDate = string.valueOfGmt(dateToCast);
        String[] myDateOnly = myDate.split(' ');
        String[] strDate = myDateOnly[0].split('-');
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        Integer myIntDate = integer.valueOf(strDate[2]);
        return  myIntDate +'-'+myIntMonth+'-'+myIntYear;
        
      
    }
    
  	/**
    * @author:      Gerardo Martínez
    * @date:        05/08/2016
    * @description: Regresa una lista de objetos FichaPago__c de un string de Ids, separados por un guion.  
    * @param:       String
    * @return:      List<FichaPago__c>
    */
    
    public static List<FichaPago__c> getFichasFromString(String Ids){
       List<FichaPago__c> results = new List<FichaPago__c>();
        if(Ids.length()>0 && !Ids.equals('')){
            
       		List<String> listOfIds = Ids.split('-');
     
            for(String s: listOfIds ){
                results.add([SELECT Id, Name, Notas1__c, Notas2__c, Hasta__c, Importe__c, Plantel__c, Plantel__r.Instituto__r.Encabezado__c,
                             Descuento__c, TotaPagar__c, ReferenciaOXXO__c, ReferenciaHSBC__c, Concepto__c, ProgramasRelacionados__c
                             FROM FichaPago__c WHERE Id=:s LIMIT 1]);
            }   
        }
        
        return results;
    }
    
    /**
    * @author:      Gerardo Martínez
    * @date:        05/08/2016
    * @description: Regresa una lista de objetos Programa__C de un string de Ids, separados por una coma.  
    * @param:       String
    * @return:      List<Programa__c>
    */
    
    public static List<Programa__c> getProgramasRelacionados(String Ids){
         List<Programa__c> results = new List<Programa__c>();
         if(Ids.length()>0 && !Ids.equals('') ){
            
       		List<String> listOfIds = Ids.split(',');
     
            for(String s: listOfIds ){
                results.add([SELECT Id, Name FROM Programa__c WHERE Id=:s LIMIT 1]);
            }   
        }
        return results;
    }
    
        /**
    * @author:      Gerardo Martínez
    * @date:        07/08/2016
    * @description: Regresa el url de un recurso estático.  
    * @param:       String
    * @return:      String
    */
    
    public static String GetResourceURL(String resourceName){

            // Fetching the resource
            List<StaticResource> resourceList= [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :resourceName];

            // Checking if the result is returned or not
            if(resourceList.size() == 1){

               // Getting namespace
               String namespace = resourceList[0].NamespacePrefix;
               // Resource URL
               return '/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
            }
            else return '';
        }
    

}