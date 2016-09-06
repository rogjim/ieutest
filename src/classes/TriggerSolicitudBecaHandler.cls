public with sharing class TriggerSolicitudBecaHandler extends TriggerHandler{
    /**
    * @author:      Daniel Hernández
    * @date:        27/06/2016
    * @description: Si el estatus de una Beca Solicitada cambia a "Activo" y esta seleccionado, el campo PorcentajeBeca__c en Lead u Opp se atualiza con el importe autotrizado.
    * @param:       
    * @return:      
    */
    
    private Map<Id, SolicitudBeca__c> newMap;
    private Map<Id, SolicitudBeca__c> oldMap;
    private List<SolicitudBeca__c> newList;
    private List<SolicitudBeca__c> oldList;
    
    public TriggerSolicitudBecaHandler() {
        this.newMap = (Map<Id, SolicitudBeca__c>) trigger.newMap;
        this.oldMap = (Map<Id, SolicitudBeca__c>) trigger.oldMap;
        this.newList = (List<SolicitudBeca__c>) trigger.new;
        this.oldList = (List<SolicitudBeca__c>) trigger.old;
    }
    
    public override void afterInsert(){
        for(SolicitudBeca__c nuevaSolicitud : newList){
            if( nuevaSolicitud.Oportunidad__c!=null){
                asignaPorcentajeOpp(nuevaSolicitud);
            }else if(nuevaSolicitud.Lead__c!=null){
                asignaPorcentajeLead(nuevaSolicitud);
            }
        }
    }
    
    public override void afterUpdate(){
        for(SolicitudBeca__c nuevaSolicitud : newList){
            if( nuevaSolicitud.Oportunidad__c!=null){
                asignaPorcentajeOpp(nuevaSolicitud);
            }else if(nuevaSolicitud.Lead__c!=null){
                asignaPorcentajeLead(nuevaSolicitud);
            }
        }
    }
    
    public override void beforeDelete(){
        for(SolicitudBeca__c nuevaSolicitud : oldList){
            if(nuevaSolicitud.Estatus__c=='Activo'){
                if(nuevaSolicitud.Oportunidad__c!=null){
                    try{
                        Opportunity oportunidad = [SELECT Id, Name, Beca__c, BecaConvenioAsignacion__c, PorcentajeBeca__c 
                                       FROM Opportunity 
                                       WHERE Id=:nuevaSolicitud.Oportunidad__c 
                                       AND Beca__c=:nuevaSolicitud.Beca__c 
                                       AND BecaConvenioAsignacion__c=:nuevaSolicitud.AsignacionBecaConvenio__c  
                                       LIMIT 1];
                        
                        oportunidad.PorcentajeBeca__c = 0;
                        oportunidad.LetraBeca__c = null;
                        upsert oportunidad;
                    }catch(Exception e){}
                }else if(nuevaSolicitud.Lead__c!=null){
                    try{
                        Lead candidato = [SELECT Id, Name, Beca__c, BecaConvenioAsignacion__c, PorcentajeBeca__c 
                                          FROM Lead 
                                          WHERE Id=:nuevaSolicitud.Lead__c 
                                          AND Beca__c=:nuevaSolicitud.Beca__c 
                                          AND BecaConvenioAsignacion__c=:nuevaSolicitud.AsignacionBecaConvenio__c  
                                          LIMIT 1];
                        
                        candidato.PorcentajeBeca__c = 0;
                        candidato.LetraBeca__c = null;
                        upsert candidato;
                        
                    }catch(Exception e){}
                }
            }
        }
    }
    
    
    public void asignaPorcentajeLead(SolicitudBeca__c nuevaSolicitud){
        
        try{
            Lead candidato = [SELECT Id, isConverted, Name, Beca__c, BecaConvenioAsignacion__c, PorcentajeBeca__c 
                              FROM Lead 
                              WHERE Id=:nuevaSolicitud.Lead__c 
                              AND Beca__c=:nuevaSolicitud.Beca__c 
                              AND BecaConvenioAsignacion__c=:nuevaSolicitud.AsignacionBecaConvenio__c  
                              LIMIT 1];
            
            if(!candidato.IsConverted){
                if(nuevaSolicitud.Estatus__c=='Activo'){
                    candidato.PorcentajeBeca__c = nuevaSolicitud.Porcentaje__c;
                    candidato.LetraBeca__c = nuevaSolicitud.LetraBecaComercial__c;
                    
                }else {
                    candidato.PorcentajeBeca__c = 0;
                    candidato.LetraBeca__c = null;
                }
                upsert candidato;
            }
        }catch(Exception e){}
        
    }
    
    
    public void asignaPorcentajeOpp(SolicitudBeca__c nuevaSolicitud){
        
        try{
            Opportunity oportunidad = [SELECT Id, Name, Beca__c, BecaConvenioAsignacion__c, PorcentajeBeca__c 
                                       FROM Opportunity 
                                       WHERE Id=:nuevaSolicitud.Oportunidad__c 
                                       AND Beca__c=:nuevaSolicitud.Beca__c 
                                       AND BecaConvenioAsignacion__c=:nuevaSolicitud.AsignacionBecaConvenio__c  
                                       LIMIT 1];
            
            if(nuevaSolicitud.Estatus__c=='Activo'){
                oportunidad.PorcentajeBeca__c = nuevaSolicitud.Porcentaje__c;
                oportunidad.LetraBeca__c = nuevaSolicitud.LetraBecaComercial__c;
            }else {
                oportunidad.PorcentajeBeca__c = 0;
                oportunidad.LetraBeca__c = null;
            }
            upsert oportunidad;
        }catch(Exception e){}
    }
    
    
}