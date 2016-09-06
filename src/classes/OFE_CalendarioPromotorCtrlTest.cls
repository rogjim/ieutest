@isTest   public class OFE_CalendarioPromotorCtrlTest {
    
    @isTest   public static void GeneraHorario(){
        
        String fecha = string.valueof(Date.today());
        
       //   ApexPages.StandardController controller = new ApexPages.StandardController();
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('node',fecha);
        
        OFE_CalendarioPromotorCtrl ofe = new OFE_CalendarioPromotorCtrl();
        
        
    }

}