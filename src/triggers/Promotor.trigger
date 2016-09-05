trigger Promotor on Promotor__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    new TriggerPromotorHandler().run();
}