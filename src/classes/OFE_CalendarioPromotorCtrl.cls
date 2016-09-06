public with sharing class OFE_CalendarioPromotorCtrl {
    public Boolean includeMyEvents {get;set;}
    public list<calEvent> events {get;set;}
    public id promotorID {get; set;}
    public id userID {get; set;}
    public String leadID {get; set;}
    public Promotor__c leadInform {get; set;}
    public List<String> horario {get; set;}
    //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss z';
    String FechaClick  ='';
    String TimeZonePage ='';
    String TimeZonePageAux ='';
    String FechaAux  {get; set;}
    public String haveDate {get; set;}
    public String haveDateStart {get; set;}
    public String haveDateOwner {get; set;}
    string bodyToSendLogin;
    string outCallResultLogin;
    public string sessionID {get;set;}
    //public string userName = 'ieu@ctconsulting.com.mx.sandbox';  //A great place to keep these values is in a custom object with an encrypted field for the password.
    //public string password = 'ctconsulting2016Adl5Q22PTrh0ApbGhrD1iWRtP';
    public string userName = AccesosPublicos__c.getOrgDefaults().UserAdmin__c;  //A great place to keep these values is in a custom object with an encrypted field for the password.
    public string password = AccesosPublicos__c.getOrgDefaults().PasswordToken__c;
    private final string SOAP_START = '<?xml version="1.0" encoding="utf-8"?>';
    private string loginURL = '';
    
    //constructor
    public OFE_CalendarioPromotorCtrl() {
        //Default showing my events to on
        includeMyEvents = true;
        bodyToSendLogin = SOAP_START ;
        bodyToSendLogin = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:partner.soap.sforce.com"> ' +
            '<soapenv:Body> ' +
            '<urn:login> ' +
            '<urn:username>'+ userName +'</urn:username>' +
            '<urn:password>'+ password + '</urn:password> ' +
            '</urn:login> ' +
            '</soapenv:Body> ' +
            '</soapenv:Envelope>';
        
        if (true){ //Keep the setting on whether this is a production or sandbox in a custom object.
            loginURL = 'https://test.salesforce.com/services/Soap/u/36.0';
        }else{
            loginURL = 'https://login.salesforce.com/services/Soap/u/36.0';
        }
        obtenerSesion();
    }
    
    public void GeneraHorario() {
        FechaClick = Apexpages.currentPage().getParameters().get('node');  
        if(FechaClick.length()!=0){            
            string[] splitted = FechaClick.split('/');
            Integer anio=integer.ValueOf(splitted[2]);
            Integer mes=integer.ValueOf(splitted[1]);
            Integer dia=integer.ValueOf(splitted[0]);
            
            List<Event> comparaHorario = [select  StartDateTime  from Event where OwnerID = :UserID 
                                          and CALENDAR_YEAR(StartDateTime) =: anio
                                          and CALENDAR_MONTH(StartDateTime)=:mes
                                          and DAY_IN_MONTH(StartDateTime)=:dia
                                         ];
            
            String cadena='';            
            horario = new List<String>();
            List<String> iniciaH = leadInform.HoraAtencionDe__c.split(':');
            List<String> iniciaF = new List<String>();
            iniciaF.add('18');
            if(leadInform.HoraAtencionHasta__c != null){
                iniciaF = leadInform.HoraAtencionHasta__c.split(':');
            }
            
            
            //   System.debug('hora fin ---> '+iniciaF);
            Integer valueI = Integer.valueOf(iniciaH[0]);
            Integer valueF = Integer.valueOf(iniciaF[0]);
            Integer valueFAux = Integer.valueOf(iniciaF[1]);
            horario.add('selecciona horario');
            
            
            
            String horarioAux='';
            for(Integer i = valueI; i < valueF; i++){
                
                //  System.debug('valueI ---> '+i);
                // System.debug('valueF ---> '+valueF);
                String addVal1 = '';
                String addVal2 = '';
                horarioAux= string.valueof(i);  
                //  System.debug('horarioAux ---> '+horarioAux);
                if(horarioAux.length()<2){
                    horarioAux= '0' +string.valueof(i);                  
                }else{
                    horarioAux= string.valueof(i);  
                }
                
                addVal1 = horarioAux+':00';
                addVal2 = horarioAux+':30';
                Boolean Bandera1 = false;
                Boolean Bandera2 = false;
                
                //    System.debug('comparaHorario ---> '+comparaHorario.size());
                
                for(Integer a=0; a<comparaHorario.size();a++){
                    cadena=  (string.valueOf( getLocalDateTime(comparaHorario.get(a).StartDateTime)).substring(11, 16));
                    //      system.debug('cadena-> ' +cadena);
                    //     system.debug('addVal1-> ' +addVal1);
                    if(addVal1.equals(cadena)){
                        Bandera1=true;
                    }
                    
                    //       system.debug('cadena-> ' +cadena);
                    //   system.debug('addVal2-> ' +addVal2);
                    if(addVal2.equals(cadena)){
                        Bandera2=true;
                    }                    
                }
                if(Bandera1==false ){
                    horario.add(addVal1);
                }
                if(Bandera2==false  ){
                    horario.add(addVal2);
                }  
                
                if(valueFAux==30 && Bandera1==false && i==(valueF-1)){
                    Integer aux =integer.valueof(horarioAux);
                    aux= aux+1;
                    horarioAux= string.valueof(aux);
                    horarioAux=  horarioAux+':00';
                    horario.add(horarioAux);
                } 
                
            }
            
            
        }
    }
    
    public PageReference pageLoad() {
        events = new list<calEvent>();
        promotorID = ApexPages.currentPage().getParameters().get('idPromotor');
        String apLeadID = ApexPages.currentPage().getParameters().get('folio');
        leadID = apLeadID.subString(0,15);
        
        leadInform = [SELECT id, HoraAtencionDe__c, HoraAtencionHasta__c, UrlFotoGrande__c, Promotor__c FROM Promotor__c WHERE id =: promotorID ];
        userID = leadInform.Promotor__c;
        try{
            Event eventLead = [SELECT id, Subject, StartDateTime, EndDateTime, Owner.Name FROM Event WHERE WhoId = : leadID LIMIT 1];
            if(eventLead != null){
                haveDate = 'none'; //Se ocultan elementos
                List<String> fecha = String.valueOf(eventLead.StartDateTime).split(' ');
                List<String> fechaSplit = fecha[0].split('-');
                //  System.debug(fecha[0]);
                haveDateStart = fechaSplit[2] + '/' + fechaSplit[1] + '/' +fechaSplit[0] + ' a las ' + fecha[1];
                haveDateOwner = eventLead.Owner.Name;
            }else{
                haveDate = 'inline';//Se muestran los elementos
            }
        }catch(Exception er){
            
        }
        //Get Contact's Birthdays
        for(Contact cont : [select Id, Birthdate, FirstName, LastName from Contact where Birthdate != null]){
            //here we need to replace the birth year with the current year so that it will show up on this years calendar
            DateTime startDT = datetime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());
            calEvent bday = new calEvent();
            
            bday.title = cont.FirstName + ' ' + cont.LastName + '\'s Birthday!';
            bday.allDay = true;
            bday.startString = startDT.format(dtFormat);
            //Because this is an all day event that only spans one day, we can leave the send date null
            bday.endString = '';
            bday.url = '/' + cont.Id;
            bday.className = 'event-birthday';
            events.add(bday);
        }
        
        //Get Campaigns
        for(Campaign camp : [select Id, Name, StartDate, EndDate from Campaign where IsActive = true]){
            DateTime startDT = camp.StartDate;
            DateTime endDT = camp.EndDate;
            calEvent campEvent = new calEvent();
            
            campEvent.title = camp.Name;
            campEvent.allDay = true;
            campEvent.startString = startDT.format(dtFormat);
            campEvent.endString = endDT.format(dtFormat);
            campEvent.url = '/' + camp.Id;
            campEvent.className = 'event-campaign';
            events.add(campEvent);
        }
        
        //Get my Events if we have selected the correct option
        if(includeMyEvents){
            TimeZone tz = UserInfo.getTimeZone();
            for(Event evnt: [select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime from Event where OwnerID = :UserID]){
                DateTime startDT = evnt.StartDateTime;
                DateTime endDT = evnt.EndDateTime;
                
                //  startDT= getLocalDateTime(startDT);
                //  endDT= getLocalDateTime(endDT);
                
                /*     System.debug('antes-->'+ startDT); 
System.debug('antes-->'+ startDT.format(dtFormat));
System.debug('despues-->'+startDT.format('dd MM yyyy hh:mm:s','GTM'));*/
                calEvent myEvent = new calEvent();
                
                myEvent.title = evnt.Subject;
                myEvent.allDay = evnt.isAllDayEvent;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + evnt.Id;
                myEvent.className = 'event-personal';
                events.add(myEvent);
            }
        }
        return null;
    }
    
    public static Datetime getLocalDateTime(Datetime z)
    {    
        DateTime CurentTime = z;
        
        String TimeZones = '(GMT-06:00) Central Standard Time (America/Mexico_City)';
        List<String> lststrsplit = TimeZones.substring(12,TimeZones.length()).split('\\(',2);
        string strTimeZone = lststrsplit[1].substring(0,lststrsplit[1].length()-1);
        string strCurrentTime = CurentTime.format('YYYY-MM-dd HH:mm:ss', strTimeZone);
        Datetime dateCurrentTime = Datetime.valueof(strCurrentTime);        
        return dateCurrentTime;
    }
    
    public PageReference toggleMyEvents() {
        if(includeMyEvents){
            includeMyEvents = false;
        }
        else{
            includeMyEvents = true;
        }
        pageload();
        return null;
    }
    
    private string makeHTTPCall(string endPoint, string soapBody){
        Http hLLogin = new Http();
        HttpRequest reqLLogin = new HttpRequest();
        reqLLogin.setTimeout(60000);
        reqLLogin.setEndpoint(endPoint);  
        reqLLogin.setMethod('POST');
        reqLLogin.setHeader('SFDC_STACK_DEPTH', '1');
        reqLLogin.setHeader('SOAPAction','DoesNotMatter'); 
        reqLLogin.setHeader('Accept','text/xml');  
        reqLLogin.setHeader('Content-type','text/xml');    
        reqLLogin.setHeader('charset','UTF-8'); 
        reqLLogin.setBody(soapBody);	
        HttpResponse resLLogin = hLLogin.send(reqLLogin);
        string outCallResultLogin = '';
        outCallResultLogin = resLLogin.getBody();
        //  System.debug(outCallResultLogin);
        return outCallResultLogin;
    }
    
    private string getValueFromXMLString(string xmlString, string keyField){
        string valueFound = '';
        if(xmlString.contains('<' + keyField + '>') && xmlString.contains('')){
            try{
                valueFound = xmlString.substring(xmlString.indexOf('<' + keyField + '>') + keyField.length() + 2, xmlString.indexOf('</' + keyField + '>'));	
            }catch (exception e){
                system.debug('Error in getValueFromXMLString.  Details: ' + e.getMessage() + ' keyfield: ' + keyfield);
            }            
        }
        return valueFound;
    }
    
    public void obtenerSesion(){
        outCallResultLogin = makeHTTPCall(loginURL,bodyToSendLogin);
        sessionID = getValueFromXMLString(outCallResultLogin, 'sessionId');
    }
    
    //Class to hold calendar event data
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;private set;}
        public String endString {get;private set;}
        public String url {get;set;}
        public String className {get;set;}
    }
}