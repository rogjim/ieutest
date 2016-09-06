public class FichaPagoPendienteCtrl { 
    public List<FichaPago__c> fichas  {
        get{
            
            if(fichas==null){
                 fichas= [SELECT Id, Name,Periodo__r.Name,Hasta__c,
                          Nivel__r.Name, Plantel__c,
                          TotaPagar__c  FROM FichaPago__c 
                          where TipoFicha__c  =:'Ficha Móvil']; 
                
                
             
            }
            return fichas;
        }
        private set; 
    }
}