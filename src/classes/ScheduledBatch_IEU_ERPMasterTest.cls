@isTest public class ScheduledBatch_IEU_ERPMasterTest {

     public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void test() {
        
        list<Promotor__c> promotores= new  list<Promotor__c>();
     
        
        Test.startTest();
        
        // programamos el  test job
        String jobId = System.schedule('ScheduleApexClassTest',
                                       CRON_EXP,
                                       new SchedulablePromotor());
        
        // obtenemos la informacion de CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,
                          NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        
        // validamos que la expresión sea la misma
        System.assertEquals(CRON_EXP,  ct.CronExpression);
        
        // validamos que el job aún no se haya ejecutado
        System.assertEquals(0, ct.TimesTriggered);
        
        
        // validamos la proxima vez que se ejecutara el job
        System.assertEquals('2022-03-15 00:00:00',String.valueOf(ct.NextFireTime));
        
       
    	Batch_IEU_ERPMaster batch = new Batch_IEU_ERPMaster('addCandidatoInfo');
         Database.executeBatch(batch);

        Test.stopTest();
        // en este momento de debe de ejecutar el job jespués de Test.stopTest(),
        
       // promotores=[SELECT Id FROM Promotor__c  ];
        
        //validamos que se haya ejecutado correctamente el job      
       // System.assertEquals(promotores.size(), 1);
    }
}