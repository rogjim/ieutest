public class TriggerFichaHandler extends TriggerHandler{
    
    /**
* @author:      Salvador Reyna 
* @date:        17/06/2016
* @description: Trigger antes de insertar para evitar la inserción de fichas erroneas por Data Loader
* @param:       
* @return:      
*/
    
    public override void beforeInsert(){
        for (FichaPago__c token : (List<FichaPago__c>) trigger.new){
            if(token.ReferenciaHSBC__c != null || token.ReferenciaOXXO__c != null){
                token.addError('No hay ficha asociada para esta referencia');
            }
        }
    }
    
    
    /**
* @author:      Gerardo Martínez 
* @date:        17/06/2016
* @description: Trigger despues de insertar una ficha de pago, envia la misma por correo electrónico 
* @param:       
* @return:      
*/
    
    public override void afterInsert(){
        
        SET<Id> ids = new SET<Id>();
        List<FichaPago__c> fichas= new List<FichaPago__c> ();
        
        for (FichaPago__c token : (List<FichaPago__c>) trigger.new){
            ids.add(token.Id);
        }
        System.debug('ids ->' +ids.size());
        fichas = [SELECT Id, Oportunidad__c, Oportunidad__r.CorreoCuenta__c, ReferenciaCliente__c, RecordType.Name, ConceptoEspecial__c,Concepto__c, RecibimosDe__c, TotaPagar__c,
                  Notas1__c, Notas2__c, NotaEspecial__c, Name, CondensacionFecha__c, Constante__c, CadenaCodigo__c, ReferenciaHSBC__c, ReferenciaOXXO__c,
                  Lead__r.Email, Hasta__c, Plantel__r.Instituto__r.Encabezado__c, ProgramasRelacionados__c, Lead__r.Nivel__r.Name, Plantel__r.Instituto__r.PrefijoOXXO__c  
                  FROM FichaPago__c WHERE Id IN :ids];
        
        for(FichaPago__c token : fichas){
            if(token.Lead__c!=null){
                token.ReferenciaOXXO__c = Utils.getOXXOReference(token.Plantel__r.Instituto__r.PrefijoOXXO__c  + token.cadenaCodigo__c);
                token.ReferenciaHSBC__c = Utils.getHSBCReference(token.ReferenciaCliente__c, token.CondensacionFecha__c, token.Constante__c, String.valueOf(token.TotaPagar__c));
                if(token.RecordType.Name == 'Ficha Especial'){
                    BarCodeLeadCtrl.sendMail(token.Hasta__c, token.NotaEspecial__c,'', token.ConceptoEspecial__c, token.Lead__r.Email, token.RecibimosDe__c, token.Name, String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf(token.Plantel__r.Instituto__r.Encabezado__c));
                }else if(token.RecordType.Name == 'Ficha de Nivel'){
                    if(token.Lead__r.Nivel__r.Name == 'Cursos y Diplomados'){
                        BarCodeLeadCtrl.sendMail(token.Hasta__c, token.Notas1__c, token.Notas2__c, token.Concepto__c, token.Lead__r.Email, token.RecibimosDe__c, token.Name, String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf('INSTITUTO_NIVEL2'));
                    }else{                
                        BarCodeLeadCtrl.sendMail(token.Hasta__c, token.Notas1__c, token.Notas2__c, token.Concepto__c, token.Lead__r.Email, token.RecibimosDe__c, token.Name, String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf(token.Plantel__r.Instituto__r.Encabezado__c));
                    }
                }
                update token;
            }else if(token.Oportunidad__c!=null){
                token.ReferenciaOXXO__c = Utils.getOXXOReference(token.Plantel__r.Instituto__r.PrefijoOXXO__c  + token.cadenaCodigo__c);
                token.ReferenciaHSBC__c = Utils.getHSBCReference(token.ReferenciaCliente__c, token.CondensacionFecha__c, token.Constante__c, String.valueOf(token.TotaPagar__c));
                if(token.RecordType.Name == 'Ficha Especial'){
                    BarCodeLeadCtrl.sendMail(token.Hasta__c, token.NotaEspecial__c,'', token.ConceptoEspecial__c, token.Oportunidad__r.CorreoCuenta__c, token.RecibimosDe__c, token.Name, String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf(token.Plantel__r.Instituto__r.Encabezado__c));
                }else if(token.RecordType.Name == 'Ficha de Nivel'){
                    if(token.Lead__r.Nivel__r.Name == 'Cursos y Diplomados'){
                        BarCodeLeadCtrl.sendMail(token.Hasta__c, token.Notas1__c, token.Notas2__c, token.Concepto__c, token.Oportunidad__r.CorreoCuenta__c, token.RecibimosDe__c, token.Name, String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf('INSTITUTO_NIVEL2'));
                    }else{                
                        BarCodeLeadCtrl.sendMail(token.Hasta__c, token.Notas1__c, token.Notas2__c, token.Concepto__c, token.Oportunidad__r.CorreoCuenta__c, token.RecibimosDe__c, token.Name, String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf(token.Plantel__r.Instituto__r.Encabezado__c));
                    }
                }
                update token;
            }else{
                token.ReferenciaOXXO__c = Utils.getOXXOReference(token.Plantel__r.Instituto__r.PrefijoOXXO__c + token.cadenaCodigo__c);
                token.ReferenciaHSBC__c = Utils.getHSBCReference(token.ReferenciaCliente__c, token.CondensacionFecha__c, token.Constante__c, String.valueOf(token.TotaPagar__c));
                update token;
            }
        } 
    }
}