public with sharing class TriggerDescuentoHandler extends TriggerHandler{
    /**
* @author:      Daniel Hernández
* @date:        07/06/2016
* @description: Valida que no se empalmen fechas en registros del objeto   coincidentes en Modalidad__c, Periodo__c y Nivel__c en el mismo periodo del tipo 'Descuento Individual vigente'
* @param:       
* @return:      
*/
    
    private Map<Id, Descuento__c> newMap;
    private Map<Id, Descuento__c> oldMap;
    private List<Descuento__c> newList;
    private List<Descuento__c> oldList;
    
    public List<Descuento__c> listaComparativa;
    
    public TriggerDescuentoHandler() {
        this.newMap = (Map<Id, Descuento__c>) trigger.newMap;
        this.oldMap = (Map<Id, Descuento__c>) trigger.oldMap;
        this.newList = (List<Descuento__c>) trigger.new;
        this.oldList = (List<Descuento__c>) trigger.old;
        
        listaComparativa = new List<Descuento__c>();
        try{
            listaComparativa = [SELECT Id,Name,Estatus__c,Comentarios__c,Lead__c,Modalidad__c,Modalidades__c,Nivel__c,Niveles__c,Periodo__c,Periodos__c,
                                DescuentoFinal__c,DescuentoInicial__c,FechaFinVigencia__c,FechaInicioVigencia__c,PorcentajeDescuento__c,TipoDescuento__c,Vigente__c 
                                FROM Descuento__c 
                                WHERE (TipoDescuento__c='Descuento individual vigente' OR TipoDescuento__c='Promoción 0')
                                AND Estatus__c='Activo'
                                LIMIT 100];
        }catch(Exception e){}
    }
    
    public override void beforeInsert(){
        for(Descuento__c disc : newList){
            if( listaComparativa.size()>0 && disc.Estatus__c=='Activo' && (disc.TipoDescuento__c=='Descuento individual vigente' || disc.TipoDescuento__c=='Promoción 0' ) ){
                validacionEmpalmeFecha(disc);
            }
        }
    }
    
    public override void afterInsert(){
        for(Descuento__c disc : newList){
            if(disc.TipoDescuento__c=='Promoción Solicitada' && disc.Lead__c!=null){
                actualizaPromocionLead(disc);
            }else if(disc.TipoDescuento__c=='Promoción Solicitada' && disc.Oportunidad__c!=null){
                actualizaPromocionOportunidad(disc);
            }
        }
    }
    
    
    public override void beforeUpdate(){
        for(Descuento__c disc : newList){
            if( listaComparativa.size()>0 && disc.Estatus__c=='Activo' && (disc.TipoDescuento__c=='Descuento individual vigente' || disc.TipoDescuento__c=='Promoción 0' ) ){
                validacionEmpalmeFecha(disc);
            }
        }
    }
    
    public override void afterUpdate(){
        for(Descuento__c disc : newList){
            if(disc.TipoDescuento__c=='Promoción Solicitada' && disc.Lead__c!=null){
                actualizaPromocionLead(disc);
            }else if(disc.TipoDescuento__c=='Promoción Solicitada' && disc.Oportunidad__c!=null){
                actualizaPromocionOportunidad(disc);
            }
        }
    }
    
    
    
    
    
    public void validacionEmpalmeFecha(Descuento__c disc){
        for(Descuento__c descuentoExistente: listaComparativa){
            if(disc.TipoDescuento__c == descuentoExistente.TipoDescuento__c){
                if( ( (disc.FechaInicioVigencia__c>=descuentoExistente.FechaInicioVigencia__c 	&& disc.FechaFinVigencia__c<=descuentoExistente.FechaFinVigencia__c) 	||
                     (descuentoExistente.FechaFinVigencia__c>=disc.FechaInicioVigencia__c 	&& descuentoExistente.FechaFinVigencia__c<=disc.FechaFinVigencia__c) 	||
                     (descuentoExistente.FechaInicioVigencia__c>=disc.FechaInicioVigencia__c 	&& descuentoExistente.FechaInicioVigencia__c<=disc.FechaFinVigencia__c) 
                    )&& descuentoExistente.Id !=disc.Id
                  ){
                      disc.addError('No pueden existir dos descuentos de este tipo, activos en un mismo lapso de tiempo');
                  }
            }
        }
    }
    
    public void actualizaPromocionLead(Descuento__c disc){
        Lead candidato = new Lead();
        
        try{
            candidato = [SELECT Id, Name, SolicitudPromocion__c, VigenciaDescuento__c, AplicaPromocionCero__c, IsConverted, PorcentajeDescuento__c, Nivel__c, Modalidad__c, Periodo__c
                         FROM Lead 
                         WHERE Id=:disc.Lead__c LIMIT 1];
        }catch(Exception e){}
        
        
        if(!candidato.IsConverted){
            
            if(candidato.Id!=null && candidato.AplicaPromocionCero__c==false){
                
                if(disc.Estatus__c=='Activo'){
                    candidato.PorcentajeDescuento__c = disc.PorcentajeDescuento__c;
                    candidato.SolicitudPromocion__c=true;
                    candidato.VigenciaDescuento__c = disc.FechaFinVigencia__c;
                }else{
                    BecaConvenioAsignacion__c descuentoAplicable = new BecaConvenioAsignacion__c();
                    try{
                        descuentoAplicable = [SELECT Id, Name, RecordType.Name, Periodo__c, Nivel__c, Modalidad__c, NivelTodos__c, ModalidadTodas__c, Descuento__r.Vigente__c,
                                              Descuento__r.FechaInicioVigencia__c, Descuento__r.FechaFinVigencia__c, Descuento__r.PorcentajeDescuento__c, Descuento__r.Estatus__c 
                                              FROM BecaConvenioAsignacion__C 
                                              WHERE RecordType.Name='Descuento' AND Descuento__r.Vigente__c=true AND Descuento__r.Estatus__c='Activo'
                                              
                                              AND (//Todas las opciones devueltas deben corresponder a un sólo padre Descuento__c, por tanto tienen el mismo porcentajeDescuento
                                                  (NivelTodos__c=true AND ModalidadTodas__c=true AND PeriodosTodos__c=true)
                                                  
                                                  OR (Nivel__c=:candidato.Nivel__c AND ModalidadTodas__c=true AND PeriodosTodos__c=true) 
                                                  OR (NivelTodos__c=true AND Modalidad__c=:candidato.Modalidad__c AND PeriodosTodos__c=true) 
                                                  OR (NivelTodos__c=true AND ModalidadTodas__c=true AND Periodo__c=:candidato.Periodo__c)
                                                  
                                                  OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND PeriodosTodos__c=true) 
                                                  OR(Nivel__c=:candidato.Nivel__c AND ModalidadTodas__c=true AND Periodo__c=:candidato.Periodo__c) 
                                                  OR(NivelTodos__c=true AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c) 
                                                  
                                                  OR(Nivel__c=:candidato.Nivel__c AND Modalidad__c=:candidato.Modalidad__c AND Periodo__c=:candidato.Periodo__c)
                                              )
                                              LIMIT 1];
                        candidato.PorcentajeDescuento__c = descuentoAplicable.Descuento__r.PorcentajeDescuento__c;
                        candidato.VigenciaDescuento__c  = descuentoAplicable.Descuento__r.FechaFinVigencia__c;
                    }catch(Exception e){
                        candidato.PorcentajeDescuento__c = 0;
                    }
                    candidato.SolicitudPromocion__c=false;
                }
                upsert candidato;
            }
        }
    }
    
    
    
    public void actualizaPromocionOportunidad(Descuento__c disc){
        Opportunity oportunidad = new Opportunity();
        
        try{
            oportunidad = [SELECT Id, Name, PorcentajeDescuento__c, VigenciaDescuento__c, SolicitudPromocion__c, AplicaPromocionCero__c, Nivel__c, Modalidad__c, Periodo__c
                         FROM Opportunity 
                         WHERE Id=:disc.Oportunidad__c LIMIT 1];
        }catch(Exception e){}
        
        if(oportunidad.Id!=null && oportunidad.AplicaPromocionCero__c==false){
            
            if(disc.Estatus__c=='Activo'){
                oportunidad.PorcentajeDescuento__c = disc.PorcentajeDescuento__c;
                oportunidad.SolicitudPromocion__c=true;
                oportunidad.VigenciaDescuento__c = disc.FechaFinVigencia__c;
            }else{
                BecaConvenioAsignacion__c descuentoAplicable = new BecaConvenioAsignacion__c();
                try{
                    descuentoAplicable = [SELECT Id, Name, RecordType.Name, Periodo__c, Nivel__c, Modalidad__c, NivelTodos__c, ModalidadTodas__c, Descuento__r.Vigente__c,
                                          Descuento__r.FechaInicioVigencia__c, Descuento__r.FechaFinVigencia__c, Descuento__r.PorcentajeDescuento__c, Descuento__r.Estatus__c 
                                          FROM BecaConvenioAsignacion__C 
                                          WHERE RecordType.Name='Descuento' AND Descuento__r.Vigente__c=true AND Descuento__r.Estatus__c='Activo'
                                          
                                          AND (//Todas las opciones devueltas deben corresponder a un sólo padre Descuento__c, por tanto tienen el mismo porcentajeDescuento
                                              (NivelTodos__c=true AND ModalidadTodas__c=true AND PeriodosTodos__c=true)
                                              
                                              OR (Nivel__c=:oportunidad.Nivel__c AND ModalidadTodas__c=true AND PeriodosTodos__c=true) 
                                              OR (NivelTodos__c=true AND Modalidad__c=:oportunidad.Modalidad__c AND PeriodosTodos__c=true) 
                                              OR (NivelTodos__c=true AND ModalidadTodas__c=true AND Periodo__c=:oportunidad.Periodo__c)
                                              
                                              OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND PeriodosTodos__c=true) 
                                              OR(Nivel__c=:oportunidad.Nivel__c AND ModalidadTodas__c=true AND Periodo__c=:oportunidad.Periodo__c) 
                                              OR(NivelTodos__c=true AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c) 
                                              
                                              OR(Nivel__c=:oportunidad.Nivel__c AND Modalidad__c=:oportunidad.Modalidad__c AND Periodo__c=:oportunidad.Periodo__c)
                                          )
                                          LIMIT 1];
                    oportunidad.PorcentajeDescuento__c = descuentoAplicable.Descuento__r.PorcentajeDescuento__c;
                    oportunidad.VigenciaDescuento__c  = descuentoAplicable.Descuento__r.FechaFinVigencia__c;
                }catch(Exception e){
                    oportunidad.PorcentajeDescuento__c = 0;
                }
                oportunidad.SolicitudPromocion__c=false;
            }
            upsert oportunidad;
        }
    }
    
}