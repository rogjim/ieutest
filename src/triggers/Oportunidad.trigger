trigger Oportunidad on Opportunity (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
      new TriggerOportunidadHandler().run();
}