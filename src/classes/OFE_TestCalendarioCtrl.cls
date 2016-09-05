public with sharing class OFE_TestCalendarioCtrl {
 	string bodyToSendLogin;
	string outCallResultLogin;
	public string sessionID {get;set;}
	public string userName = 'ieu@ctconsulting.com.mx.sandbox';  //A great place to keep these values is in a custom object with an encrypted field for the password.
	public string password = 'ctconsulting2016IAXPEMQ84uEjBFjWFbSEdfbp';
	
	//This beginning piece of XML can be re-used for the subsequent calls
	private final string SOAP_START = '<?xml version="1.0" encoding="utf-8"?>';
	private string loginURL = '';
			
	public OFE_TestCalendarioCtrl(){
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
		System.debug(outCallResultLogin);
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
}