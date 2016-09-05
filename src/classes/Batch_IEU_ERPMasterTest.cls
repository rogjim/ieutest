@isTest  public class Batch_IEU_ERPMasterTest {
    
    static testmethod void test() {
        Test.startTest();
        
        List<Lead> leadList = new List<Lead>();
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 10; i++) {
            leadList.add(new Lead(LastName = 'Boards Test Accout ' + i));
            contactList.add(new Contact(
                FirstName = 'Boards ' + i,
                LastName = 'Test Contact'
            ));
        }
        List<sObject> objects = new List<sObject>();
        objects.addAll((List<sObject>)(leadList));
        objects.addAll((List<sObject>)(contactList));
        insert objects;
        
       IEU_ERPMaster obj = new IEU_ERPMaster();
     //   obj.ArrayOfCandidatoInfo;
     //   obj.ArrayOfCandidatoInfo
      //  Batch_IEU_ERPMaster.addCandidatoInfo( obj.ArrayOfCandidatoInfo);
        
        
        
       // Database.executeBatch(Batch_IEU_ERPMaster.addCandidatoInfo(objects));
        
        Test.stopTest();
        
        
    }
    
}