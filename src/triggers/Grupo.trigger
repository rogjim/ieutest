trigger Grupo on Grupo__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
     new TriggerGrupoHandler().run();
}