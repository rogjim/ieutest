public with sharing class TriggerUsuarioHandler extends TriggerHandler{
    private Map<Id, User> newMap;
	private Map<Id, User> oldMap;
	private List<User> newList;
	private List<User> oldList;
	
	public TriggerUsuarioHandler() {
			this.newMap = (Map<Id, User>) trigger.newMap;
			this.oldMap = (Map<Id, User>) trigger.oldMap;
			this.newList = (List<User>) trigger.new;
			this.oldList = (List<User>) trigger.old;
			
	}
	
	public  override void afterUpdate(){
		
	}
	
	/*
	//No se tiene acceso a los campos PhotoUrl, se crea un sheluder que actuliza el objeto Promotores
	public void actulizarFotoPromotor(Map<Id, User> oldMap, List<User> newList,Map<Id, User> newMap){
		set<Id> idUsers = new set<Id>();
		list<Promotor__c> promotores = new list<Promotor__c>();
		for(User user : newList){
			System.debug('Cambio de foto1 ' + oldMap + user.FullPhotoUrl);
			System.debug('Cambio de foto ' + oldMap.get(user.Id).FullPhotoUrl  +',' + user.FullPhotoUrl);
			if ((oldMap.get(user.Id).FullPhotoUrl != user.FullPhotoUrl) || (oldMap.get(user.Id).SmallPhotoUrl != user.SmallPhotoUrl)){
				idUsers.add(user.id);
			}
		}
		
		try{
			promotores = [SELECT Id,Name, UrlFotoGrande__c,Promotor__c FROM  Promotor__c WHERE Promotor__c IN :idUsers];
			System.debug('Promotores cambio de foto ' + promotores);
		}catch(Exception e){
			System.debug('No hay usuarios asignados a promotores: ' + e.getMessage());
		}
		
		for(Promotor__c promotor: promotores){
			promotor.UrlFotoGrande__c = newMap.get(promotor.Promotor__c).FullPhotoUrl;
		}
		
		if(promotores.size() > 0){
			update promotores;
		}
		
	}*/
}