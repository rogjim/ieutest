public with sharing class FichaPagoMovilCtrl {
	public FichaPago__c ficha {get; set;}
    Public RecordType rt;
    public String numeroFichas {get; set;}
    public Boolean consulto {get; set;}
    public Boolean todosProgramas {get; set;}
    public List<OfertaEducativa__c> listPrograma {get; set;}
    Public List<WrapperPrograma> listPrograms {get; set;}    
    public List<String> listSelecteds {get; set;}
    public FichaPagoMovilCtrl(){
        ficha = new FichaPago__c();
        consulto = false;
        rt = [SELECT Id,Name FROM RecordType WHERE SobjectType='FichaPago__c' AND Name='Ficha Móvil'];
    }
    
    public PageReference getPrograms(){
        listPrograms = new List<WrapperPrograma>();
        String criteria = 'Nivel__c = \''+ficha.Nivel__c+'\'';
         System.debug('criteria1--> '+ criteria);
        if(ficha.Periodo__c != null){
            criteria += ' AND Periodo__c = \''+ ficha.Periodo__c+'\'';
        }
        if(ficha.Plantel__c != null){
            criteria += ' AND Plantel__c = \''+ ficha.Plantel__c +'\'';
        }
        
        String query = 'SELECT Id, Name, Programa__c, Programa__r.Name FROM OfertaEducativa__c WHERE ' + criteria;
        listPrograma = (List<OfertaEducativa__c>) Database.query(query);
        for(OfertaEducativa__c offer: listPrograma){
            WrapperPrograma data = new WrapperPrograma();
            data.name = offer.Programa__r.Name;
            data.IdPrograma = offer.Programa__c;
            listPrograms.add(data);
        }
        if(!listPrograms.isEmpty()){
        	consulto = true;
            return null;
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No existen programas para los filtros seleccionados'));
            return null;
        }
    }
    
    public PageReference saveToken(){
        
        ficha.TotaPagar__c = ficha.Importe__c - (ficha.Importe__c * (ficha.Descuento__c / 100));
        ficha.TipoFicha__c = 'Ficha Móvil';
        ficha.RecordTypeId = rt.Id;
        List<FichaPago__c> fichasInsert = new List<FichaPago__c>();
        String selectedPrograms = '';
        if(todosProgramas){
            for(WrapperPrograma wpPrograma: listPrograms){
                selectedPrograms += wpPrograma.IdPrograma + ',';
            }
        }else{
            for(WrapperPrograma wpPrograma: listPrograms){
                If(wpPrograma.active == true){
                    selectedPrograms += wpPrograma.IdPrograma + ',';
                }
            }
        }
        
        ficha.ProgramasRelacionados__c = selectedPrograms.removeEnd(',');
        String fichasId = '';
        if(selectedPrograms != ''){
            for(Integer i = 0; i< Integer.valueOf(numeroFichas); i++){
                FichaPago__c newFicha= new FichaPago__c();
                newFicha.Descuento__c = ficha.Descuento__c;
                newFicha.Importe__c = ficha.Importe__c;
                newFicha.Hasta__c = ficha.Hasta__c;
                newFicha.Periodo__c = ficha.Periodo__c;
                newFicha.RecordTypeId = ficha.RecordTypeId;
                newFicha.TipoFicha__c = ficha.TipoFicha__c;
                newFicha.ProgramasRelacionados__c = ficha.ProgramasRelacionados__c;
                newFicha.Plantel__c = ficha.Plantel__c;
                newFicha.Nivel__c = ficha.Nivel__c;
                newFicha.TotaPagar__c = ficha.TotaPagar__c;
                fichasInsert.add(newFicha);            
            }
            upsert fichasInsert;
            for(FichaPago__c fichaValue :fichasInsert){
                fichasId= fichasId+fichaValue.Id + '-';
            }
            fichasId.removeEnd('-');
            BarCodeMovilCtrl.sendMail(fichasId);
            PageReference toTokens = new PageReference('/apex/FichaPagoPendiente');
            toTokens.setRedirect(true);
            return toTokens;
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No se ha seleccionado ningun programa para la ficha'));
            return null;
        }
    }
    
    public PageReference exit(){
        PageReference toTokens = new PageReference('/apex/FichaPagoPendiente');
        toTokens.setRedirect(true);
        return toTokens;
    }
    
    Public class WrapperPrograma{
       
        Public String name {get; set;}
        Public Boolean active {get; set;}
        Public Id idPrograma {get; set;}
        public WrapperPrograma(){
            active = false;
        }
    }
}