trigger SolicitudBeca on SolicitudBeca__c (after delete, after insert, after undelete, after update, before delete, before insert, before update){
     new TriggerSolicitudBecaHandler().run();
}