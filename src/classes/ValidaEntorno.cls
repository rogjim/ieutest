public class ValidaEntorno {
    
    public Static Boolean isSandbox(){

        String host = URL.getSalesforceBaseUrl().getHost();
        String server = host.substring(0,host.indexOf('.'));

        // It's easiest to check for 'my domain' sandboxes first 
        // even though that will be rare
        if(server.contains('--'))
            return true;

        // tapp0 is a unique "non-cs" server so we check it now
        if(server == 'tapp0')
            return true;

        // If server is 'cs' followed by a number it's a sandbox
        if(server.length()>2){
            if(server.substring(0,2)=='cs'){
                try{
                    Integer.valueOf(server.substring(2,server.length()));
                }
                catch(exception e){
                    //started with cs, but not followed by a number
                    return false;
                }

                //cs followed by a number, that's a hit
                return true;
            }
        }

        // If we made it here it's a production box
        return false;
    }

}