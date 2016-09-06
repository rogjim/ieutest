global with sharing class SchedulablePromotor implements Schedulable{
    global void execute(SchedulableContext sc) {
    	list<Promotor__c>promotores = [SELECT Id,Name, UrlFotoGrande__c,Promotor__c FROM  Promotor__c];
    	update promotores;
    }
}