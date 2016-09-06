trigger Descuento on Descuento__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
     new TriggerDescuentoHandler().run();
}