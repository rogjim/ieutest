public class PlantillaPromotorAsignadoController {
    
    public ID  salesRepID {get; set;}
    Public List<Plantel__c> plantel = new List<Plantel__c>();
     Public List<RequisitosInscripcion__c> requisitos = new List<RequisitosInscripcion__c>();
    public  Lead AllLeads= new Lead();
    public  Plantel__c Direccion= new Plantel__c();
    public  Rvoe__c rvoe;
    //Integer cantidadPlanteles {get; set;}
    String dir='';
    String Nivel='';
      String RvoeVigente='';
    public PlantillaPromotorAsignadoController() {
        
    }    
    
    public Lead  getAllLeads() {              
        
        try {
                AllLeads = [select Id, Promotor__c, Promotor__r.PromotorName__c ,Folio__c,Name, Programa__r.Name ,Inscripcion__c, 
                            Nivel__r.Name,VigenciaDescuento__c,Programa__R.AbreviaturaPrograma__c,Programa__R.NombreMin__c,
                            Colegiatura__c, Nivel__c, Modalidad__c , Promotor__r.UrlFotoGrande__c, 
                            OfertaEducativa__R.RvoeVigente__R.ModalidadRVOE__c , OfertaEducativa__R.RvoeVigente__R.Name, 
                            OfertaEducativa__R.RvoeVigente__R.ClaveCentroTrabajo__c, Modalidad__R.Name ,
                            OfertaEducativa__R.DuracionPrograma__c , Plantel__c ,  Periodo__r.name , Periodo__r.FechaInicio__c ,
                            Programa__R.LigaPlan__c, OfertaEducativa__R.Periodicidad__C 
                            from Lead where Id=: salesRepID  LIMIT 1];                           
         //   System.debug('otra URLPlanEstudios__c--> '+AllLeads.OfertaEducativa__r.RvoeVigente__r.URLPlanEstudios__c);
            dir=AllLeads.Plantel__c; 
             Nivel=AllLeads.Nivel__r.Name; 
            RvoeVigente=AllLeads.OfertaEducativa__R.RvoeVigente__r.name;
            
        } catch (Exception e) {
            return AllLeads;
        }
        return AllLeads;
    }
    
    public Plantel__c  getDireccion() {   
        try{
            Direccion =[select Name, Calle__c,NumeroExterior__c,Ciudad__c, CodigoPostal__c, Colonia__c ,Estado__r.Name
                        from Plantel__c where id=:dir LIMIT 1];          
            
     
        }catch (Exception e) {
            return Direccion;    
        }
        return Direccion;
    }
    
     public RVOE__C  getRvoe() {   
        try{
            rvoe =[select URLPlanEstudios__c
                        from RVOE__C where Name=:RvoeVigente LIMIT 1];          
            
     System.debug('url de plan de estudios ----> ' +rvoe.URLPlanEstudios__c);
        }catch (Exception e) {
            return rvoe;    
        }
        return rvoe;
    }
    public List<Plantel__c> getplantel() {
        List<Plantel__c> plantel = [SELECT Plantel__c.Name FROM Plantel__c Order By Plantel__c.Name   ];
        return plantel ;
    }
    
     public Integer getcantidadplantel() {
        Integer cantidadplantel = [SELECT count() FROM Plantel__c  ];
                                     
        return cantidadplantel ;
    }
    
    public List<RequisitosInscripcion__c> getrequisitos() {
        List<RequisitosInscripcion__c> requisitos = [select  name from RequisitosInscripcion__c where nivel__R.name=:Nivel   
                                                Order By name    ];
        return requisitos ;
    }
}