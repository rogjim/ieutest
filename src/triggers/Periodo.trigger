trigger Periodo on Periodo__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    new TriggerPeriodoHandler().run();
}