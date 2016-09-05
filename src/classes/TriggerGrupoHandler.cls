public with sharing class TriggerGrupoHandler extends TriggerHandler {
        private Map<Id, Grupo__c> newMap;
        private Map<Id, Grupo__c> oldMap;
        private List<Grupo__c> newList;
        private List<Grupo__c> oldList;
        
        public TriggerGrupoHandler() {
                this.newMap = (Map<Id, Grupo__c>) trigger.newMap;
                this.oldMap = (Map<Id, Grupo__c>) trigger.oldMap;
                this.newList = (List<Grupo__c>) trigger.new;
                this.oldList = (List<Grupo__c>) trigger.old;
                
        }
    
        //Asignar nomenclatura a grupo autorizado -calvarez
        public override void beforeUpdate() {
            Map<Id, Grupo__c> toUpdate = new Map<Id, Grupo__c>();
            for(Grupo__c grupo: newList){
                if(grupo.Estatus__c == 'Autorizado' && oldMap.get(grupo.Id).Estatus__c != grupo.Estatus__c && String.isBlank(grupo.Nomenclatura__c)){
                    toUpdate.put(grupo.Id, grupo);
                }
                if(grupo.Estatus__c == 'Rechazado') {
                    grupo.Activo__c = 'Inactivo ';
                }
            }
            List<Grupo__c> groups_u = [SELECT Id, Consecutivo__c, Nomenclatura__c, OfertaEducativa__r.RvoeVigente__r.Plan__c, 
                                       OfertaEducativa__r.Plantel__c,
                                       OfertaEducativa__r.Nivel__c,
                                       OfertaEducativa__r.Programa__c FROM Grupo__c WHERE Id IN :toUpdate.keySet()];
            if(groups_u.size() > 0) {
                Map<String, Integer> consecutivo = new Map<String, Integer>();
                for(Grupo__c gr : groups_u) {
                    String key = gr.OfertaEducativa__r.Plantel__c +''+ gr.OfertaEducativa__r.Nivel__c +''+ gr.OfertaEducativa__r.Programa__c;
                    List<sObject> listGr = [SELECT MAX(Consecutivo__c) maxVal FROM Grupo__c 
                                            WHERE OfertaEducativa__r.Plantel__c= :gr.OfertaEducativa__r.Plantel__c 
                                            AND OfertaEducativa__r.Nivel__c= :gr.OfertaEducativa__r.Nivel__c 
                                            AND OfertaEducativa__r.Programa__c= :gr.OfertaEducativa__r.Programa__c
                                           AND Nomenclatura__c != null];
                    if(toUpdate.containsKey(gr.Id)) {
                        Grupo__c grpUpdate = (Grupo__c) toUpdate.get(gr.Id);
                        //System.debug('Plantel__c: '+gr.OfertaEducativa__r.Plantel__c + ' - Nivel__c: ' + gr.OfertaEducativa__r.Nivel__c + ' - Programa__c: ' + gr.OfertaEducativa__r.Programa__c);
                        if(listGr.size() > 0) {
                            sObject sobj= listGr[0];
                            if(sobj.get('maxVal') != null) {
                                
                                Decimal val = ((Decimal)sobj.get('maxVal')) + 1;
                                
                                if(consecutivo.containsKey(key)) {
                                    Integer newVal = ((Integer)consecutivo.get(key)) + ((Integer)val);
                                    consecutivo.put(key, (((Integer)consecutivo.get(key)) + 1));
                                    val = (Decimal) newVal;
                                } else {
                                    consecutivo.put(key, 1);
                                }
                                gr.Consecutivo__c = (Double) val;
                                
                                
                            } else {
                           		if(consecutivo.containsKey(key)) {
                                    Integer newVal = ((Integer)consecutivo.get(key)) + 1;
                                    gr.Consecutivo__c = newVal;
                                    consecutivo.put(key, newVal);
                                } else {
                                    consecutivo.put(key, 1);
                                    gr.Consecutivo__c = 1;
                                } 
                            }
                        } else {
                            if(consecutivo.containsKey(key)) {
                                Integer newVal = ((Integer)consecutivo.get(key)) + 1;
                                gr.Consecutivo__c = newVal;
                                consecutivo.put(key, newVal);
                            } else {
                                consecutivo.put(key, 1);
                           		gr.Consecutivo__c = 1;
                            } 
                        }
                        if(gr.OfertaEducativa__c != null 
                           && gr.OfertaEducativa__r.RvoeVigente__c != null
                           && !String.isBlank(gr.OfertaEducativa__r.RvoeVigente__r.Plan__c)) {   
                               grpUpdate.Consecutivo__c =gr.Consecutivo__c;
                               grpUpdate.Nomenclatura__c = gr.OfertaEducativa__r.RvoeVigente__r.Plan__c + Integer.valueOf(String.valueOf(gr.Consecutivo__c));
                        }
                    }
                }
            }
        }
        
        public override void afterUpdate(){
            updateOpportunities(newList);
        }
        
        public void updateOpportunities(List<Grupo__c> groups){
            set<Id> idGroup = new set<Id>();
            for(Grupo__c grupo: groups){
                if(grupo.Estatus__c == 'Autorizado' && oldMap.get(grupo.Id).Estatus__c != grupo.Estatus__c){
                    idGroup.add(grupo.Id);
                }
            }
            
            
            
            list<Opportunity> opportunities = [SELECT id,Name,StageName FROM Opportunity WHERE Grupo__c IN : idGroup AND  StageName = 'Inscrito'];
            for(Opportunity opportunidad:opportunities){
                opportunidad.StageName = 'Ganada';
            }
            update opportunities;
        }
        
        
    }