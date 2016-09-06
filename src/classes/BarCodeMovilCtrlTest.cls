@IsTest public class BarCodeMovilCtrlTest {
    @IsTest   public static void sendMail(){
        String ids='34253434';
        BarCodeMovilCtrl.sendMail(ids);
    }
    @IsTest   public static void refactorDate(){
        
        BarCodeMovilCtrl.refactorDate(Date.today());
    }
    @IsTest   public static void getFichasFromString(){
        
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today(),
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                           RecibimosDe__c ='demo'
                                          );
        
        insert fp;
        
        String ids=fp.Id;
        BarCodeMovilCtrl.getFichasFromString(ids);
    }
    @IsTest   public static void getProgramasRelacionados(){
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        String ids=pr.Id;
        BarCodeMovilCtrl.getProgramasRelacionados(ids);
    }
    @IsTest   public static void GetResourceURL(){
        
        List<StaticResource> resourceList= [SELECT Name FROM StaticResource limit 1];
        String resourceName=String.valueOf(resourceList.get(0));           
        BarCodeMovilCtrl.GetResourceURL(resourceName);
    }
 @IsTest   public static void encodeASCII(){
        
        String cadena='demo';
        BarCodeMovilCtrl.encodeASCII(cadena);
    }    
    @IsTest   public static void BarCodeMovilCtrl(){
      //  BarCodeMovilCtrl crtl = new BarCodeMovilCtrl();
      //crtl.BarCodeMovilCtrl();
       // BarCodeMovilCtrl.BarCodeMovilCtrl();
    }   
}