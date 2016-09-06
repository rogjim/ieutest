public with sharing class GenerarPDFFichaPagoCtrl {
    Public FichaPago__c idToken {get; set;}
    
    public GenerarPDFFichaPagoCtrl(ApexPages.StandardController controller ){
        idToken = (FichaPago__c)controller.getRecord();
    }
    
    public void sendMail(){
        
        system.debug('sendmail id '+idToken.Id );
        FichaPago__c ord = [SELECT Id, ReferenciaCliente__c, RecordType.Name, ConceptoEspecial__c,Concepto__c, RecibimosDe__c, TotaPagar__c,
                            Notas1__c, Notas2__c, NotaEspecial__c, Name, CondensacionFecha__c, Constante__c, CadenaCodigo__c,
                            Lead__r.Email, Hasta__c, Plantel__r.Instituto__r.Encabezado__c, ProgramasRelacionados__c, Lead__r.Nivel__r.Name,
                            ReferenciaOXXO__c, ReferenciaHSBC__c FROM FichaPago__c WHERE Id = :idToken.Id];
        system.debug('ord.RecordType.Name--> '+ord.RecordType.Name);
        
         system.debug('ord.Lead__r.Nivel__r.Name--> '+ord.Lead__r.Nivel__r.Name);
        if(ord.RecordType.Name == 'Ficha Especial'){
            BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.NotaEspecial__c,'', ord.ConceptoEspecial__c, ord.Lead__r.Email, ord.RecibimosDe__c, ord.Name, String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf(ord.Plantel__r.Instituto__r.Encabezado__c));
        }else if(ord.RecordType.Name == 'Ficha de Nivel'){
            if(ord.Lead__r.Nivel__r.Name == 'Cursos y Diplomados'){
                BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.Notas1__c, ord.Notas2__c, ord.Concepto__c, ord.Lead__r.Email, ord.RecibimosDe__c, ord.Name, String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf('INSTITUTO_NIVEL2'));
            }else{        
             
                BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.Notas1__c, ord.Notas2__c, ord.Concepto__c, ord.Lead__r.Email, ord.RecibimosDe__c, ord.Name, String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf(ord.Plantel__r.Instituto__r.Encabezado__c));
            }
        }
        
    }
}