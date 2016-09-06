public class ConsumingHTTPPost {
    public static Http objhttp;
    public static HttpRequest req ;
    public static HttpResponse res ;
    public static void MakeRestCallout()
    {
        objhttp = new Http();
        req = new HttpRequest();
        res = new HttpResponse();
        req.setMethod('POST'); // req.setMethod('GET');
        req.setEndpoint('http://requestb.in/1fobfc91');
        /*Blob headerValue = Blob.valueOf(UserName+ ':' + Password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Accept','application/vnd.cpc.authreturn+xml');
        req.setHeader('Content-type','application/vnd.cpc.authreturn+xml; charset=UTF-8');
        req.setHeader('Accept-Language', 'en-CA');
        req.setTimeout(120000);*/
        
        //Set request format
        String reqBody = '<XML> </XML>';
        req.setBody(reqBody);
        try {
            res = objhttp.send(req);
        }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
        }
        
        System.debug(res);
        /*if(res.getStatus().equalsIgnoreCase('OK') && res.getStatusCode() == 200)
        {
            System.debug('Se logro consumir el servicio');
        }*/
    }
}