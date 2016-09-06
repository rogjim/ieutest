public with sharing class OFE_OfertaEducativaCtrl {
    
    @RemoteAction
    public static List<sObject> query(String query) {
        return Database.query(query);
    }

    @RemoteAction
    public static Schema.DescribeSobjectResult[] describe(String[] objs) {
       
        return Schema.describeSObjects(objs);
    }

    @RemoteAction
    public static List<Database.DeleteResult> deleteIds(String[] ids) {
        return Database.delete(ids);
    }
    
    @RemoteAction
    public static List<Database.UpsertResult> upsertObjects(String objType, String jsonString) {
        Type t = Type.forName('List<'+objType+'>');
        List<sObject> instances = (List<sObject>) JSON.deserialize(jsonString, t);
        System.debug(instances);
        return Database.upsert(instances);
    }
}