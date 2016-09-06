trigger FichaPago on FichaPago__c (after insert, before insert) {
	new TriggerFichaHandler().run();
}