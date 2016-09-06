global class Batch_IEU_ERPMaster implements Database.Batchable<sObject>, Database.AllowsCallouts{
		
		String query;
		String method;
	    String request = '';
	  
		global Batch_IEU_ERPMaster(String mtd) {
	        //result = 'Resultado del servicio web: ';
			method = mtd;
			if(method != null && String.isNotEmpty(method)) {
				if(method == 'addCandidatoInfo') {//Leads
					//query = 'SELECT ' + UtilsLog.getStrCampos(Lead.SObjectType) + ', CreatedDate,  Plantel__r.IdInterno__c, Pais__r.IdUbicacion__c, Estado__r.IdUbicacion__c, Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, GrupoAsignado__r.IdGrupo__c, Periodo__r.IdPeriodo__c, Owner.IDInterno__c, Profesion__r.IdProfesion__c FROM Lead WHERE (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true)) AND IsConverted = false AND Pais__r.IdUbicacion__c!=null AND Periodo__r.IdPeriodo__c!=null AND Name != null AND LastName!=null AND ApeMaterno__c!=null AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND GrupoAsignado__r.IdGrupo__c!=null AND Owner.IDInterno__c!=null AND Sexo__c!=null';
					query = 'SELECT EnviadoERP__c, ModificadoERP__c, Account.Ciudad__c, Folio__c ,Account.Profesion__r.IdProfesion__c, Account.Pais__r.IdUbicacion__c, Periodo__r.IdPeriodo__c, Account.FirstName, Account.LastName, Account.ApeMaterno__c, Account.Calle__c, Account.NumeroExterior__c, Account.NumeroInterior__c, Account.Colonia__c, Account.Estado__r.IdUbicacion__c, Account.CP__c, Account.Phone, Account.PersonHomePhone, Account.PersonMobilePhone, Account.PersonEmail, Plantel__r.IdInterno__c, Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, Grupo__r.IdGrupo__c, Pago__c, Owner.IDInterno__c, Account.FechaNacimiento__c, Account.Sexo__c, Account.EstadoCivil__c, Account.CreatedDate, (SELECT Id, Name, FechaPago__c FROM Fichas_de_pago__r WHERE FechaPago__c!=null ORDER BY FechaPago__c DESC) FROM Opportunity WHERE EnviadoERP__c=false AND Account.Pais__r.IdUbicacion__c!=null AND Periodo__r.IdPeriodo__c!=null AND Account.FirstName!=null AND Account.LastName!=null AND Account.ApeMaterno__c!=null AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND Grupo__r.IdGrupo__c!=null AND Owner.IDInterno__c!=null AND Account.Sexo__c!=null AND Id IN(SELECT Oportunidad__c FROM FichaPago__c WHERE FechaPago__c!=null)';
				/*} 
                else if(method == 'addCandidatoInfo_OP') {//Oportunidades
					query = 'SELECT EnviadoERP__c, ModificadoERP__c, Folio__c ,Account.Profesion__r.IdProfesion__c, Account.Pais__r.IdUbicacion__c, Periodo__r.IdPeriodo__c, Account.FirstName, Account.LastName, Account.ApeMaterno__c, Account.Calle__c, Account.NumeroExterior__c, Account.NumeroInterior__c, Account.Colonia__c, Account.Estado__r.IdUbicacion__c, Account.CP__c, Account.Phone, Account.PersonHomePhone, Account.PersonMobilePhone, Account.PersonEmail, Plantel__r.IdInterno__c, Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, Grupo__r.IdGrupo__c, Pago__c, Owner.Name, Account.FechaNacimiento__c, Account.Sexo__c, Account.EstadoCivil__c, Account.CreatedDate FROM Opportunity WHERE EnviadoERP__c=false AND Account.Pais__r.IdUbicacion__c!=null AND Periodo__r.IdPeriodo__c!=null AND Account.FirstName!=null AND Account.LastName!=null AND Account.ApeMaterno__c!=null AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND Grupo__r.IdGrupo__c!=null AND Owner.Name!=null AND Account.Sexo__c!=null';
				*/
                } else if(method == 'addGrupoInfo') {
					query = 'SELECT IdTurno__c, EnviadoERP__c, ModificadoERP__c, FechaInicioClases__c, Activo__c, AperturaOperativo__c, UsuarioApertura__r.Name, FechaApertura__c, FechaRegistro__c, IdGrupo__c, Grupo__c, OfertaEducativa__r.Plantel__r.IdInterno__c, OfertaEducativa__r.Periodo__r.IdPeriodo__c, OfertaEducativa__r.Programa__r.IdInterno__c, OfertaEducativa__r.Nivel__r.IdInternoNivel__c, OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c, Sede__r.ClavePlantelDepende__c, Sede__r.Name, Periodicidad__r.IdInternoPeriodicidad__c FROM Grupo__c WHERE (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true)) AND OfertaEducativa__r.Plantel__r.IdInterno__c!=null AND OfertaEducativa__r.Periodo__r.IdPeriodo__c!=null AND Grupo__c!=null AND OfertaEducativa__r.Programa__r.IdInterno__c!=null AND OfertaEducativa__r.Nivel__r.IdInternoNivel__c!=null AND IdTurno__c!=null AND OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c!=null AND Periodicidad__r.IdInternoPeriodicidad__c!=null AND FechaRegistro__c!=null AND FechaInicioClases__c!=null AND FechaApertura__c!=null AND Sede__r.ClavePlantelDepende__c!=null AND Sede__r.Name!=null';
	            } else if(method == 'addBecasInfo') {//Leads
					//query = 'SELECT EnviadoERP__c, ModificadoERP__c, Id, Name, Folio__c, Periodo__r.IdPeriodo__c, Plantel__r.IdInterno__c, Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, Beca__r.IdInterno__c, Beca__r.PorcentajeBeca__c, Beca__r.A__c, Beca__r.B__c, Beca__r.C__c, Beca__r.D__c, Beca__r.E__c, Beca__r.F__c, Beca__r.G__c, Beca__r.CreatedDate, Beca__r.CreatedBy.Name, Beca__r.IdTipoBeca__c, Beca__r.RecordType.Name, LetraBeca__c FROM Lead WHERE (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true)) AND Name!=null AND Folio__c!=null AND Periodo__r.IdPeriodo__c!=null AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND Beca__r.IdInterno__c!=null AND Beca__r.PorcentajeBeca__c!=null AND Beca__r.CreatedDate!=null AND Beca__r.CreatedBy.Name!=null AND Beca__r.IdTipoBeca__c!=null';
					query = 'SELECT EnviadoERP__c, ModificadoERP__c, Account.Name, Folio__c, Periodo__r.IdPeriodo__c, Plantel__r.IdInterno__c, Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, Beca__r.IdInterno__c, Beca__r.PorcentajeBeca__c, Beca__r.A__c, Beca__r.B__c, Beca__r.C__c, Beca__r.D__c, Beca__r.E__c, Beca__r.F__c, Beca__r.G__c, Beca__r.CreatedDate, Beca__r.CreatedBy.Name, Beca__r.IdTipoBeca__c, Beca__r.RecordType.Name, LetraBeca__c, (SELECT Id, Name, FechaPago__c FROM Fichas_de_pago__r WHERE FechaPago__c!=null ORDER BY FechaPago__c DESC) FROM Opportunity WHERE (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true)) AND Account.Name!=null AND Folio__c!=null AND Periodo__r.IdPeriodo__c!=null AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND Beca__r.IdInterno__c!=null AND Beca__r.PorcentajeBeca__c!=null AND Beca__r.CreatedDate!=null AND Beca__r.CreatedBy.Name!=null AND Beca__r.IdTipoBeca__c!=null AND Id IN(SELECT Oportunidad__c FROM FichaPago__c WHERE FechaPago__c!=null)';
                
                /*}  else if(method == 'addBecasInfo_OP') {//Oportunidades
					query = 'SELECT EnviadoERP__c, ModificadoERP__c, Account.Name, Folio__c, Periodo__r.IdPeriodo__c, Plantel__r.IdInterno__c, Nivel__r.IdInternoNivel__c, Programa__r.IdInterno__c, Beca__r.IdInterno__c, Beca__r.PorcentajeBeca__c, Beca__r.A__c, Beca__r.B__c, Beca__r.C__c, Beca__r.D__c, Beca__r.E__c, Beca__r.F__c, Beca__r.G__c, Beca__r.CreatedDate, Beca__r.CreatedBy.Name, Beca__r.IdTipoBeca__c, Beca__r.RecordType.Name, LetraBeca__c FROM Opportunity WHERE (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true)) AND Account.Name!=null AND Folio__c!=null AND Periodo__r.IdPeriodo__c!=null AND Plantel__r.IdInterno__c!=null AND Nivel__r.IdInternoNivel__c!=null AND Programa__r.IdInterno__c!=null AND Beca__r.IdInterno__c!=null AND Beca__r.PorcentajeBeca__c!=null AND Beca__r.CreatedDate!=null AND Beca__r.CreatedBy.Name!=null AND Beca__r.IdTipoBeca__c!=null';
				*/
                } else if(method == 'addPagosGrupoInfo') {
					query = 'SELECT IdGrupo__c, EnviadoERP__c, ModificadoERP__c FROM Grupo__c WHERE (EnviadoERP__c=false OR (EnviadoERP__c=true AND ModificadoERP__c=true))';
				} else if(method == 'addPagosInscripcionInfo') {
					query = 'SELECT Lead__r.Folio__c, Lead__r.Periodo__r.IdPeriodo__c, Lead__r.Plantel__r.IdInterno__c, Concepto__c, Lead__r.FormaPago__c, MontoPagado__c, NumeroAutorizacion__c, FechaPago__c, EnviadoERP__c FROM FichaPago__c WHERE EnviadoERP__c=false AND Lead__r.Folio__c!=null AND Lead__r.Periodo__r.IdPeriodo__c!=null AND Lead__r.Plantel__r.IdInterno__c!=null AND MontoPagado__c!=null AND NumeroAutorizacion__c!=null AND FechaPago__c!=null';
				} else {
					System.debug('Method ' + method + ' is not defined.');
				}
			} else {
				System.debug('Method is required.');
			}
		}
		 
		global Database.QueryLocator start(Database.BatchableContext BC) {
		    return Database.getQueryLocator(query);
		}
		 
		global void execute(Database.BatchableContext BC, List<sObject> sobjects) {

	    	IEU_ERPMasterCliente cliente = new IEU_ERPMasterCliente(120000);
		 	String user = Negocio__c.getOrgDefaults().UsuarioERPWS__c;
		 	String pwd = Negocio__c.getOrgDefaults().PasswordERPWS__c;
		 	String response = '';

			if(method != null && String.isNotEmpty(method)) {
				/*
                if(method == 'addCandidatoInfo') {
					IEU_ERPMaster.ArrayOfCandidatoInfo ls = addCandidatoInfo(sobjects);
	                response = cliente.addCandidato(user, pwd, ls);
	                for(IEU_ERPMaster.CandidatoInfo ci : ls.CandidatoInfo) {
	                    if(request.length() > 0) {
	                        request+=',';
	                    }
	                    request+='{folio:'+ci.folio+',';
	                    request+='idprofesion:'+ci.idprofesion+',';
	                    request+='idpais:'+ci.idpais+',';
	                    request+='periodo:'+ci.periodo+',';
	                    request+='idEstado:'+ci.idEstado+',';
	                    request+='idPlantel:'+ci.idPlantel+',';
	                    request+='Prog1Nivel:'+ci.Prog1Nivel+',';
	                    request+='Prog1Clave:'+ci.Prog1Clave+',';
	                    request+='idGrupo:'+ci.idGrupo+',';
	                    request+='pagado:'+ci.pagado+',';
	                    request+='periodoPago:'+ci.periodoPago+',';
	                    request+='idPlantelPago:'+ci.idPlantelPago+',';
	                    request+='Prog1NivelPago:'+ci.Prog1NivelPago+',';
	                    request+='Prog1ClavePago:'+ci.Prog1ClavePago+',';
	                    request+='idGrupoPago:'+ci.idGrupoPago+',';
	                    request+='actualizar:'+ci.actualizar+',';
	                    request+='idedocivil:'+ci.idedocivil+',';
	                    
	                    request+='nombre:\''+ci.nombre+'\',';
	                    request+='nombre:\''+ci.nombre+'\',';
	                    request+='aMaterno:\''+ci.aMaterno+'\',';
	                    request+='domicilio:\''+ci.domicilio+'\',';
	                    request+='colonia:\''+ci.colonia+'\',';
	                    request+='ciudad:\''+ci.ciudad+'\',';
	                    request+='cp:\''+ci.cp+'\',';
	                    request+='telCasa:\''+ci.telCasa+'\',';
	                    request+='telOficina:\''+ci.telOficina+'\',';
	                    request+='celular:\''+ci.celular+'\',';
	                    request+='mail:\''+ci.mail+'\',';
	                    request+='usuario:\''+ci.usuario+'\',';
	                    request+='fechaPago:\''+ci.fechaPago+'\',';
	                    request+='fechaNac:\''+ci.fechaNac+'\',';
	                    request+='fRegistro:\''+ci.fRegistro+'\'}';
	                }
				} else 
				//Antes if(method == 'addCandidatoInfo_OP')
				*/
                if(method == 'addCandidatoInfo') {
					IEU_ERPMaster.ArrayOfCandidatoInfo ls = addCandidatoInfo(sobjects);
	                response = cliente.addCandidato(user, pwd, ls);
	                for(IEU_ERPMaster.CandidatoInfo ci : ls.CandidatoInfo) {

	                    if(request.length() > 0) {
	                        request+=',';
	                    }
	                    request+='{folio:'+ci.folio+',';
	                    request+='idprofesion:'+ci.idprofesion+',';
	                    request+='idpais:'+ci.idpais+',';
	                    request+='periodo:'+ci.periodo+',';
	                    request+='idEstado:'+ci.idEstado+',';
	                    request+='idPlantel:'+ci.idPlantel+',';
	                    request+='Prog1Nivel:'+ci.Prog1Nivel+',';
	                    request+='Prog1Clave:'+ci.Prog1Clave+',';
	                    request+='idGrupo:'+ci.idGrupo+',';
	                    request+='pagado:'+ci.pagado+',';
	                    request+='periodoPago:'+ci.periodoPago+',';
	                    request+='idPlantelPago:'+ci.idPlantelPago+',';
	                    request+='Prog1NivelPago:'+ci.Prog1NivelPago+',';
	                    request+='Prog1ClavePago:'+ci.Prog1ClavePago+',';
	                    request+='idGrupoPago:'+ci.idGrupoPago+',';
	                    request+='actualizar:'+ci.actualizar+',';
	                    request+='idedocivil:'+ci.idedocivil+',';
	                    
	                    request+='nombre:\''+ci.nombre+'\',';
	                    request+='nombre:\''+ci.nombre+'\',';
	                    request+='aMaterno:\''+ci.aMaterno+'\',';
	                    request+='domicilio:\''+ci.domicilio+'\',';
	                    request+='colonia:\''+ci.colonia+'\',';
	                    request+='ciudad:\''+ci.ciudad+'\',';
	                    request+='cp:\''+ci.cp+'\',';
	                    request+='telCasa:\''+ci.telCasa+'\',';
	                    request+='telOficina:\''+ci.telOficina+'\',';
	                    request+='celular:\''+ci.celular+'\',';
	                    request+='mail:\''+ci.mail+'\',';
	                    request+='usuario:\''+ci.usuario+'\',';
	                    request+='fechaPago:\''+ci.fechaPago+'\',';
	                    request+='fechaNac:\''+ci.fechaNac+'\',';
	                    request+='fRegistro:\''+ci.fRegistro+'\'}';
	                }
				} else if(method == 'addGrupoInfo') {
					IEU_ERPMaster.ArrayOfGrupoInfo ls = addGrupoInfo(sobjects);
				   	response = cliente.addGrupo(user, pwd, ls);
	                for(IEU_ERPMaster.GrupoInfo gi : ls.GrupoInfo) {
	                    if(request.length() > 0) {
	                        request+=',';
	                    }
	                    request+='{idGrupo:'+gi.idGrupo+',';
	                    request+='idPlantel:'+gi.idPlantel+',';
	                    request+='periodo:'+gi.periodo+',';
	                    request+='grupo:\''+gi.grupo+'\',';
	                    request+='programa:'+gi.programa+',';
	                    request+='nivel:'+gi.nivel+',';
	                    request+='idTurno:'+gi.idTurno+',';
	                    request+='modalidad:\''+gi.modalidad+'\',';
	                    request+='periodicidad:'+gi.periodicidad+',';
	                    request+='fechaRegistro:\''+gi.fechaRegistro+'\',';
	                    request+='fechaInicio:\''+gi.fechaInicio+'\',';
	                    request+='activo:'+gi.activo+',';
	                    request+='aperturaOperativo:'+gi.aperturaOperativo+',';
	                    request+='usuarioApertura:\''+gi.usuarioApertura+'\',';
	                    request+='fAperturaO:\''+gi.fAperturaO+'\',';
	                    request+='sede:'+gi.sede+',';
	                    request+='sede1:\''+gi.sede1+'\',';
	                    request+='actualizar:'+gi.actualizar+'}';
	                }
				} else if(method == 'addBecasInfo') {
					IEU_ERPMaster.ArrayOfBecasInfo ls = addBecasInfo(sobjects);
			   		response = cliente.addBeca(user, pwd, ls);
	            	for(IEU_ERPMaster.BecasInfo bi: ls.BecasInfo) {
	            		if(request.length() > 0) {
			   				request+=',';
			   			}
	                	request+='{usuario:\''+bi.usuario+'\',';
					    request+='folio:'+bi.folio+',';
					    request+='idplantel:'+bi.idplantel+',';
					    request+='idnivel:'+bi.idnivel+',';
					    request+='idprograma:'+bi.idprograma+',';
					    request+='idbeca:'+bi.idbeca+',';
					    request+='porcentaje:'+bi.porcentaje+',';
					    request+='valor:'+bi.valor+',';
					    request+='fecharegistro:\''+bi.fecharegistro+'\',';
					    request+='usuarioRegistra:\''+bi.usuarioRegistra+'\',';
					    request+='esquema:'+bi.esquema+',';
					    request+='usuarioAutoriza:\''+bi.usuarioAutoriza +'\',';
					    request+='fechaAutorizacion:\''+bi.fechaAutorizacion+'\',';
					    request+='actualizar:'+bi.actualizar+'}';
					}
				} else if(method == 'addPagosGrupoInfo') {
					IEU_ERPMaster.ArrayOfPagosGrupoInfo ls = addPagosGrupoInfo(sobjects);
			   		response = cliente.addPagosGrupo(user, pwd, ls);
	            	for(IEU_ERPMaster.PagosGrupoInfo pgi: ls.PagosGrupoInfo) {
	            		if(request.length() > 0) {
			   				request+=',';
			   			}
	                	request+='{usuario:'+pgi.idGrupo+',';
	                	request+='{usuario:'+pgi.concepto+',';
	                	request+='{usuario:'+pgi.cantidad+',';
	                	request+='{usuario:'+pgi.costo+',';
					    request+='actualizar:'+pgi.actualizar+'}';
					}
				} else if(method == 'addPagosInscripcionInfo') {
					IEU_ERPMaster.ArrayOfPagosInscripcionInfo ls = addPagosInscripcionInfo(sobjects);
			   		response = cliente.addPagosInscripcion(user, pwd, ls);
			   		for(IEU_ERPMaster.PagosInscripcionInfo pii : ls.PagosInscripcionInfo) {
				   		if(request.length() > 0) {
			   				request+=',';
			   			}
				   		request+='{folio:'+pii.folio+',';
					    request+='periodo:'+pii.periodo+',';
					    request+='idPlantel:'+pii.idPlantel+',';
					    request+='concepto:'+pii.concepto+',';
					    request+='idFormaPago:'+pii.idFormaPago+',';
					    request+='idBanco:'+pii.idBanco+',';
					    request+='cantidad:'+pii.cantidad+',';
					    request+='numAutorizacion:\''+pii.numAutorizacion +'\',';
					    request+='fechaPago:\''+pii.fechaPago +'\',';
					    request+='tipoTarjeta:'+pii.tipoTarjeta+',';
					    request+='actualizar:'+pii.actualizar+'}';
			   		}
				} else {
					System.debug('Method ' + method + ' is not defined.');
				}
				if(String.isNotEmpty(response) && response == 'Estatus ok: Correcto') {
					for(sObject sobj : sobjects) {
						sobj.put('EnviadoERP__c', true);
						sobj.put('ModificadoERP__c', false);
					}
		   			update sobjects;
		   			UtilsLog.createLogOK(method, response, String.valueOf(BC.getJobId()), sobjects.size());
		   		} else if(String.isNotEmpty(response)) {
	                UtilsLog.createLogError(method,  '{user: \'' + user + '\', pwd: \'' + pwd + '\', body: [' +  request+']}', response, String.valueOf(BC.getJobId()), sobjects.size());
		   		}

			} else {
				System.debug('Method is required.');
			}
		}
		  
		  	
		global void finish(Database.BatchableContext BC) {
	    	AsyncApexJob a = [SELECT Id, CreatedDate, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
	    	List<LogIntegracion__c> logIntegracion = [SELECT Id, Estatus__c, RespuestaWS__c, NumeroRegistros__c FROM LogIntegracion__c WHERE ApexJobId__c=:BC.getJobId()];
	    	String response = '';
	    	Integer i = 1;
	    	for(LogIntegracion__c li : logIntegracion) {
	    		response += '\t-Envío ' + i++ + ', registros enviados: ' + li.NumeroRegistros__c + ', respuesta: '+li.RespuestaWS__c +'\n';
	    	}
	    	if(response.length() > 0) {
	    		response = '\n\nRespuestas del servicio web: \n' + response;
			} else {
				response = 'No hay información para ser enviada.';
			}
	                          
	       // Send an email to the Apex job's submitter 
	       //   notifying of job completion. 
	       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	       //String[] toAddresses = new String[] {a.CreatedBy.Email};
	       //String[] toAddresses = new String[] {'calvarez@ctconsulting.com.mx'};
	       List<String> toAddresses = Negocio__c.getOrgDefaults().CorreoBatchERP__c != null ? String.valueOf(Negocio__c.getOrgDefaults().CorreoBatchERP__c).split(',') : new String[] {'calvarez@ctconsulting.com.mx'};
	       mail.setToAddresses(toAddresses);
	       mail.setSubject('Resúmen de ejecución de método: ' + method);
	       mail.setPlainTextBody('Lotes ejecutados: ' + a.TotalJobItems +', errores: '+ a.NumberOfErrors +',' + response +'\n\n Hora de inicio:     ' + a.CreatedDate.format('dd-MM-YYYY HH:mm ss') +'\n Hora de término: ' + DateTime.now().format('dd-MM-YYYY HH:mm ss'));
	       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	    }
		
    	/*
	    public IEU_ERPMaster.ArrayOfCandidatoInfo addCandidatoInfo(List<sObject> sobjects) {
		 	IEU_ERPMaster.ArrayOfCandidatoInfo ls = new IEU_ERPMaster.ArrayOfCandidatoInfo();
			ls.CandidatoInfo = new List<IEU_ERPMaster.CandidatoInfo>();
		   	for(sObject obj: sobjects) {
		   		Lead lead = (Lead) obj;
		   		IEU_ERPMaster.CandidatoInfo  candidatoInfo = new IEU_ERPMaster.CandidatoInfo();
		   		candidatoInfo.folio = lead.Folio__c != null && lead.Folio__c.isNumeric() ? Integer.valueOf(lead.Folio__c) : 0;
				candidatoInfo.idprofesion = 1;//lead.Profesion__r.IdProfesion__c != null && lead.Profesion__r.IdProfesion__c.isNumeric() ? Integer.valueOf(lead.Profesion__r.IdProfesion__c) : 0;
				candidatoInfo.idpais = lead.Pais__r.IdUbicacion__c != null && lead.Pais__r.IdUbicacion__c.isNumeric() ? Integer.valueOf(lead.Pais__r.IdUbicacion__c) : 0;
				candidatoInfo.periodo = lead.Periodo__r.IdPeriodo__c != null && lead.Periodo__r.IdPeriodo__c.isNumeric() ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
				candidatoInfo.idEstado = lead.Estado__r.IdUbicacion__c != null && lead.Estado__r.IdUbicacion__c.isNumeric() ? Integer.valueOf(lead.Estado__r.IdUbicacion__c) : 0;
				candidatoInfo.idPlantel = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Plantel__r.IdInterno__c)) : 0;
				candidatoInfo.Prog1Nivel = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(lead.Nivel__r.IdInternoNivel__c)) : 0;
				candidatoInfo.Prog1Clave = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Programa__r.IdInterno__c)) : 0;
				candidatoInfo.idGrupo = lead.GrupoAsignado__r.IdGrupo__c != null && lead.GrupoAsignado__r.IdGrupo__c.isNumeric() ? Integer.valueOf(lead.GrupoAsignado__r.IdGrupo__c) : 0;
				candidatoInfo.pagado = 0; 
				candidatoInfo.periodoPago = lead.Periodo__r.IdPeriodo__c != null && lead.Periodo__r.IdPeriodo__c.isNumeric() ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
				candidatoInfo.idPlantelPago = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(lead.Plantel__r.IdInterno__c) : 0;
				candidatoInfo.Prog1NivelPago = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(lead.Nivel__r.IdInternoNivel__c) : 0;
				candidatoInfo.Prog1ClavePago = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(lead.Programa__r.IdInterno__c) : 0;
				candidatoInfo.idGrupoPago = lead.GrupoAsignado__r.IdGrupo__c != null && lead.GrupoAsignado__r.IdGrupo__c.isNumeric() ? Integer.valueOf(lead.GrupoAsignado__r.IdGrupo__c) : 0;
	            candidatoInfo.idedocivil = 1;
	            
				if(lead.EstadoCivil__c == 'Soltero') {
					candidatoInfo.idedocivil = 1;
				} else if(lead.EstadoCivil__c == 'Casado') {
					candidatoInfo.idedocivil = 2;
				} else if(lead.EstadoCivil__c == 'Divorciado') {
					candidatoInfo.idedocivil = 3;
				} else if(lead.EstadoCivil__c == 'Viudo') {
					candidatoInfo.idedocivil = 4;
				}
	            candidatoInfo.actualizar = lead.ModificadoERP__c ? 1 : 0;
	            candidatoInfo.idsexo = 1;
				if(lead.Sexo__c == 'Masculino') {
					candidatoInfo.idsexo = 1;
				} else if(lead.Sexo__c == 'Femenino') {
					candidatoInfo.idsexo = 2;
				}
				candidatoInfo.nombre = lead.Name != null ? lead.Name : '';
	            if(candidatoInfo.nombre.length() > 30) {
	                candidatoInfo.nombre = candidatoInfo.nombre.substring(0, 29);
	            }
				candidatoInfo.aPaterno = lead.LastName != null ? lead.LastName : '';
	            if(candidatoInfo.aPaterno.length() > 25) {
	                candidatoInfo.aPaterno = candidatoInfo.aPaterno.substring(0, 24);
	            }
				candidatoInfo.aMaterno = lead.ApeMaterno__c != null ? lead.ApeMaterno__c : '';
	            if(candidatoInfo.aMaterno.length() > 25) {
	                candidatoInfo.aMaterno = candidatoInfo.aMaterno.substring(0, 24);
	            }
				candidatoInfo.domicilio = lead.Calle__c != null ? lead.Calle__c : '';
	            if(candidatoInfo.domicilio.length() > 55) {
	                candidatoInfo.domicilio = candidatoInfo.domicilio.substring(0, 54);
	            }
				candidatoInfo.colonia = lead.Colonia__c != null ? lead.Colonia__c : '';
	            if(candidatoInfo.colonia.length() > 35) {
	                candidatoInfo.colonia = candidatoInfo.colonia.substring(0, 34);
	            }
				candidatoInfo.ciudad = lead.Ciudad__c != null ? lead.Ciudad__c : '';
	            if(candidatoInfo.ciudad.length() > 35) {
	                candidatoInfo.ciudad = candidatoInfo.ciudad.substring(0, 34);
	            }
				candidatoInfo.cp = lead.CP__c != null ? String.valueOf(lead.CP__c) : '';
	            if(candidatoInfo.cp.length() > 10) {
	                candidatoInfo.cp = candidatoInfo.cp.substring(0, 9);
	            }
				candidatoInfo.telCasa = lead.Phone != null ? lead.Phone : '';
	            if(candidatoInfo.telCasa.length() > 10) {
	                candidatoInfo.telCasa = candidatoInfo.telCasa.substring(0, 9);
	            }
				candidatoInfo.telOficina = lead.TelOficina__c != null ? lead.TelOficina__c : '';
	            if(candidatoInfo.telOficina.length() > 10) {
	                candidatoInfo.telOficina = candidatoInfo.telOficina.substring(0, 9);
	            }
				candidatoInfo.celular = lead.MobilePhone != null ? lead.MobilePhone : '';
	            if(candidatoInfo.celular.length() > 10) {
	                candidatoInfo.celular = candidatoInfo.celular.substring(0, 9);
	            }
				candidatoInfo.mail = lead.Email != null ? lead.Email : '';
	            if(candidatoInfo.mail.length() > 80) {
	                candidatoInfo.mail = candidatoInfo.mail.substring(0, 79);
	            }
				candidatoInfo.usuario = lead.Owner.Name != null ? lead.Owner.Name : '';
                candidatoInfo.fechaPago = '2016-01-01';//Obligatorio - pudiera ser dependiente de 'pagado'
				candidatoInfo.fechaNac = lead.FechaNacimiento__c != null ? String.valueOf(lead.FechaNacimiento__c) : '0000-00-00';
				candidatoInfo.fRegistro = lead.CreatedDate != null ? lead.CreatedDate.format('yyyy-MM-dd') : '0000-00-00';
		   		ls.CandidatoInfo.add(candidatoInfo);
		   	}
		   	return ls;
	    } */
		
    	//Antes addCandidatoInfo_OP
	    public IEU_ERPMaster.ArrayOfCandidatoInfo addCandidatoInfo(List<sObject> sobjects) {
		 	IEU_ERPMaster.ArrayOfCandidatoInfo ls = new IEU_ERPMaster.ArrayOfCandidatoInfo();
			ls.CandidatoInfo = new List<IEU_ERPMaster.CandidatoInfo>();
		   	for(sObject obj: sobjects) {
		   		Opportunity lead = (Opportunity) obj;
		   		IEU_ERPMaster.CandidatoInfo  candidatoInfo = new IEU_ERPMaster.CandidatoInfo();
		   		candidatoInfo.folio = lead.Folio__c != null && lead.Folio__c.isNumeric() ? Integer.valueOf(lead.Folio__c) : 0;
				candidatoInfo.idprofesion = 1;//lead.Profesion__r.IdProfesion__c != null && lead.Profesion__r.IdProfesion__c.isNumeric() ? Integer.valueOf(lead.Profesion__r.IdProfesion__c) : 0;
				candidatoInfo.idpais = lead.Account.Pais__r.IdUbicacion__c != null && lead.Account.Pais__r.IdUbicacion__c.isNumeric() ? Integer.valueOf(lead.Account.Pais__r.IdUbicacion__c) : 0;
				//candidatoInfo.periodo = lead.Periodo__r.IdPeriodo__c != null && lead.Periodo__r.IdPeriodo__c.isNumeric() ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
				candidatoInfo.periodo = lead.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
				candidatoInfo.idEstado = lead.Account.Estado__r.IdUbicacion__c != null && lead.Account.Estado__r.IdUbicacion__c.isNumeric() ? Integer.valueOf(lead.Account.Estado__r.IdUbicacion__c) : 0;
				candidatoInfo.idPlantel = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Plantel__r.IdInterno__c)) : 0;
				candidatoInfo.Prog1Nivel = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(lead.Nivel__r.IdInternoNivel__c)) : 0;
				candidatoInfo.Prog1Clave = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Programa__r.IdInterno__c)) : 0;
				candidatoInfo.idGrupo = lead.Grupo__r.IdGrupo__c != null && String.valueof(lead.Grupo__r.IdGrupo__c).isNumeric() ? Integer.valueOf(lead.Grupo__r.IdGrupo__c) : 0;
				candidatoInfo.pagado = 0; 
				//candidatoInfo.periodoPago = lead.Periodo__r.IdPeriodo__c != null && lead.Periodo__r.IdPeriodo__c.isNumeric() ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
				candidatoInfo.periodoPago = lead.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
				candidatoInfo.idPlantelPago = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(lead.Plantel__r.IdInterno__c) : 0;
				candidatoInfo.Prog1NivelPago = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(lead.Nivel__r.IdInternoNivel__c) : 0;
				candidatoInfo.Prog1ClavePago = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(lead.Programa__r.IdInterno__c) : 0;
				candidatoInfo.idGrupoPago = lead.Grupo__r.IdGrupo__c != null && String.valueof(lead.Grupo__r.IdGrupo__c).isNumeric() ? Integer.valueOf(lead.Grupo__r.IdGrupo__c) : 0;
	            candidatoInfo.idedocivil = 1;
	            
				if(lead.Account.EstadoCivil__c == 'Soltero') {
					candidatoInfo.idedocivil = 1;
				} else if(lead.Account.EstadoCivil__c == 'Casado') {
					candidatoInfo.idedocivil = 2;
				} else if(lead.Account.EstadoCivil__c == 'Divorciado') {
					candidatoInfo.idedocivil = 3;
				} else if(lead.Account.EstadoCivil__c == 'Viudo') {
					candidatoInfo.idedocivil = 4;
				}
	            candidatoInfo.actualizar = lead.ModificadoERP__c ? 1 : 0;
	            candidatoInfo.idsexo = 1;
				if(lead.Account.Sexo__c == 'Masculino') {
					candidatoInfo.idsexo = 1;
				} else if(lead.Account.Sexo__c == 'Femenino') {
					candidatoInfo.idsexo = 2;
				}
				candidatoInfo.nombre = lead.Account.FirstName != null ? lead.Account.FirstName : '';
	            if(candidatoInfo.nombre.length() > 30) {
	                candidatoInfo.nombre = candidatoInfo.nombre.substring(0, 29);
	            }
				candidatoInfo.aPaterno = lead.Account.LastName != null ? lead.Account.LastName : '';
	            if(candidatoInfo.aPaterno.length() > 25) {
	                candidatoInfo.aPaterno = candidatoInfo.aPaterno.substring(0, 24);
	            }
				candidatoInfo.aMaterno = lead.Account.ApeMaterno__c != null ? lead.Account.ApeMaterno__c : '';
	            if(candidatoInfo.aMaterno.length() > 25) {
	                candidatoInfo.aMaterno = candidatoInfo.aMaterno.substring(0, 24);
	            }
				candidatoInfo.domicilio = (lead.Account.Calle__c != null ? lead.Account.Calle__c : '') + ' ' + (lead.Account.NumeroExterior__c != null ? lead.Account.NumeroExterior__c : '');
	            if(candidatoInfo.domicilio.length() > 55) {
	                candidatoInfo.domicilio = candidatoInfo.domicilio.substring(0, 54);
	            }
				candidatoInfo.colonia = lead.Account.Colonia__c != null ? lead.Account.Colonia__c : '';
	            if(candidatoInfo.colonia.length() > 35) {
	                candidatoInfo.colonia = candidatoInfo.colonia.substring(0, 34);
	            }
	            candidatoInfo.ciudad = '';//Se agrego el dia 18/08/16
				candidatoInfo.ciudad = lead.Account.Ciudad__c != null ? lead.Account.Ciudad__c : '';
	            if(candidatoInfo.ciudad.length() > 35) {
	                candidatoInfo.ciudad = candidatoInfo.ciudad.substring(0, 34);
	            }
				candidatoInfo.cp = lead.Account.CP__c != null ? String.valueOf(lead.Account.CP__c) : '';
	            if(candidatoInfo.cp.length() > 10) {
	                candidatoInfo.cp = candidatoInfo.cp.substring(0, 9);
	            }
				candidatoInfo.telCasa = lead.Account.Phone != null ? lead.Account.Phone : '';
	            if(candidatoInfo.telCasa.length() > 10) {
	                candidatoInfo.telCasa = candidatoInfo.telCasa.substring(0, 9);
	            }
				candidatoInfo.telOficina = lead.Account.PersonHomePhone != null ? lead.Account.PersonHomePhone : '';
	            if(candidatoInfo.telOficina.length() > 10) {
	                candidatoInfo.telOficina = candidatoInfo.telOficina.substring(0, 9);
	            }
				candidatoInfo.celular = lead.Account.PersonMobilePhone != null ? lead.Account.PersonMobilePhone : '';
	            if(candidatoInfo.celular.length() > 10) {
	                candidatoInfo.celular = candidatoInfo.celular.substring(0, 9);
	            }
				candidatoInfo.mail = lead.Account.PersonEmail != null ? lead.Account.PersonEmail : '';
	            if(candidatoInfo.mail.length() > 80) {
	                candidatoInfo.mail = candidatoInfo.mail.substring(0, 79);
	            }
				candidatoInfo.usuario = lead.Owner.IDInterno__c != null ? lead.Owner.IDInterno__c : '';
                if(lead.Fichas_de_pago__r != null && lead.Fichas_de_pago__r.size() > 0){
                    candidatoInfo.fechaPago = String.valueOf(lead.Fichas_de_pago__r[0].FechaPago__c);//Obligatorio - pudiera ser dependiente de 'pagado'
                }else{
                    candidatoInfo.fechaPago = '2016-01-01';
                }
				candidatoInfo.fechaNac = lead.Account.FechaNacimiento__c != null ? String.valueOf(lead.Account.FechaNacimiento__c) : '0000-00-00';
				candidatoInfo.fRegistro = lead.Account.CreatedDate != null ? lead.Account.CreatedDate.format('yyyy-MM-dd') : '0000-00-00';
		   		ls.CandidatoInfo.add(candidatoInfo);
		   	}
		   	return ls;
	    }

	    public IEU_ERPMaster.ArrayOfGrupoInfo addGrupoInfo(List<sObject> sobjects) {
	    	IEU_ERPMaster.ArrayOfGrupoInfo ls = new IEU_ERPMaster.ArrayOfGrupoInfo();
	    	ls.GrupoInfo = new List<IEU_ERPMaster.GrupoInfo>();
			for(sObject obj: sobjects) {
			    Grupo__c grupo = (Grupo__c) obj;
			    IEU_ERPMaster.GrupoInfo gi = new IEU_ERPMaster.GrupoInfo();

			    gi.idGrupo = grupo.IdGrupo__c != null ? Integer.valueOf(grupo.IdGrupo__c) : 0;
			    gi.idPlantel = grupo.OfertaEducativa__r.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(grupo.OfertaEducativa__r.Plantel__r.IdInterno__c)) : 0;
			    gi.periodo = grupo.OfertaEducativa__r.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(grupo.OfertaEducativa__r.Periodo__r.IdPeriodo__c) : 0;
			    gi.grupo = grupo.Grupo__c != null ? grupo.Grupo__c : '';
	            if(gi.grupo.length() > 7) {
	                gi.grupo = gi.grupo.substring(0, 6);
	            }
			    gi.programa = grupo.OfertaEducativa__r.Programa__r.IdInterno__c != null ? Integer.valueOf(grupo.OfertaEducativa__r.Programa__r.IdInterno__c) : 0;
			    gi.nivel = grupo.OfertaEducativa__r.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(grupo.OfertaEducativa__r.Nivel__r.IdInternoNivel__c)) : 0;
			    gi.idTurno = grupo.IdTurno__c != null ? Integer.valueOf(String.valueOf(grupo.IdTurno__c)) : 0;
			    gi.modalidad = grupo.OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c != null ? grupo.OfertaEducativa__r.Modalidad__r.IdInternoModalidad__c : '';
	            /*if(gi.modalidad.length() > 1) {
	                gi.modalidad = gi.modalidad.substring(0, 1);
	            }*/
			    gi.periodicidad = grupo.Periodicidad__r.IdInternoPeriodicidad__c != null ? Integer.valueOf(String.valueOf(grupo.Periodicidad__r.IdInternoPeriodicidad__c)) : 0;
			    gi.fechaRegistro = grupo.FechaRegistro__c != null ? String.valueOf(grupo.FechaRegistro__c) : '0000-00-00';
			    gi.fechaInicio = grupo.FechaInicioClases__c != null ? String.valueOf(grupo.FechaInicioClases__c) : '0000-00-00';
			    gi.activo = grupo.Activo__c != null && grupo.Activo__c == 'Activo' ? 1 : 0;
			    gi.aperturaOperativo = grupo.AperturaOperativo__c != null && grupo.AperturaOperativo__c ? 1 : 0;
			    gi.usuarioApertura = grupo.UsuarioApertura__r.Name != null && !String.isEmpty(grupo.UsuarioApertura__r.Name) ? grupo.UsuarioApertura__r.Name : '';//REQUERIDO EN WS
	            if(gi.usuarioApertura.length() > 50) {
	                gi.usuarioApertura = gi.usuarioApertura.substring(0, 49);
	            }
			    gi.fAperturaO = grupo.FechaApertura__c != null ? String.valueOf(grupo.FechaApertura__c)  : '0000-00-00';
			    gi.sede = grupo.Sede__r.ClavePlantelDepende__c != null ? Integer.valueOf(String.valueOf(grupo.Sede__r.ClavePlantelDepende__c)) : 0;
			    gi.sede1 = grupo.Sede__r.Name != null ? grupo.Sede__r.Name : '';
	            if(gi.sede1.length() > 80) {
	                gi.sede1 = gi.sede1.substring(0, 79);
	            }
			    gi.actualizar = 0;
			    ls.GrupoInfo.add(gi);
			}
	    	return ls;
	    }	
		/*
	    public IEU_ERPMaster.ArrayOfBecasInfo addBecasInfo(List<sObject> sobjects) {
	    	IEU_ERPMaster.ArrayOfBecasInfo ls = new IEU_ERPMaster.ArrayOfBecasInfo();
			ls.BecasInfo = new List<IEU_ERPMaster.BecasInfo>();
			for(sObject obj: sobjects) {
		   		Lead lead = (Lead) obj;
			    IEU_ERPMaster.BecasInfo bi = new IEU_ERPMaster.BecasInfo();

			    bi.usuario = lead.Name;
			    if(bi.usuario.length() > 50) {
			    	bi.usuario = bi.usuario.substring(0, 49);
			    }
			    bi.folio = lead.Folio__c.isNumeric() ? Integer.valueOf(lead.Folio__c) : 0;
			    bi.idperiodo = lead.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
			    bi.idplantel = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Plantel__r.IdInterno__c)) : 0;
			    bi.idnivel = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(lead.Nivel__r.IdInternoNivel__c)) : 0;
			    bi.idprograma = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(lead.Programa__r.IdInterno__c) : 0;
			    bi.idbeca = lead.Beca__r.IdInterno__c != null ? Integer.valueOf(lead.Beca__r.IdInterno__c) : 0;
			    bi.porcentaje = lead.Beca__r.PorcentajeBeca__c != null ? Integer.valueOf(String.valueOf(lead.Beca__r.PorcentajeBeca__c)) : 0;
			    bi.valor = 0;
			    if(lead.Beca__r.IdTipoBeca__c!=null && lead.Beca__r.IdTipoBeca__c == '2') {
			    	bi.valor = Integer.valueOf((lead.LetraBeca__c != null && lead.Beca__r != null ? lead.Beca__r.get(lead.LetraBeca__c+'__c') : '0'));
			    }
			    bi.fecharegistro = lead.Beca__r.CreatedDate != null ? lead.Beca__r.CreatedDate.format('yyyy-MM-dd') : '0000-00-00';
			    bi.usuarioRegistra = lead.Beca__r.CreatedBy.Name != null ? lead.Beca__r.CreatedBy.Name : '';
			    if(bi.usuarioRegistra.length() > 50) {
			    	bi.usuarioRegistra = bi.usuarioRegistra.substring(0, 49);
			    }
			    bi.esquema = lead.Beca__r.IdTipoBeca__c != null ? Integer.valueOf(lead.Beca__r.IdTipoBeca__c) : 0;
			    bi.usuarioAutoriza = lead.Beca__r.CreatedBy.Name != null ? lead.Beca__r.CreatedBy.Name : '';//PENDIENTE
			    if(bi.usuarioAutoriza.length() > 50) {
			    	bi.usuarioAutoriza = bi.usuarioAutoriza.substring(0, 49);
			    }
			    bi.fechaAutorizacion = lead.Beca__r.CreatedDate != null ? lead.Beca__r.CreatedDate.format('yyyy-MM-dd') : '0000-00-00';//PENDIENTE
			    bi.actualizar = lead.ModificadoERP__c ? 1: 0;
			    ls.BecasInfo.add(bi);
			}
	    	return ls;
	    } */
	    public IEU_ERPMaster.ArrayOfBecasInfo addBecasInfo(List<sObject> sobjects) {
	    	IEU_ERPMaster.ArrayOfBecasInfo ls = new IEU_ERPMaster.ArrayOfBecasInfo();
			ls.BecasInfo = new List<IEU_ERPMaster.BecasInfo>();
			for(sObject obj: sobjects) {
		   		Opportunity lead = (Opportunity) obj;
			    IEU_ERPMaster.BecasInfo bi = new IEU_ERPMaster.BecasInfo();

			    bi.usuario = lead.Account.Name;
			    if(bi.usuario.length() > 50) {
			    	bi.usuario = bi.usuario.substring(0, 49);
			    }
			    bi.folio = lead.Folio__c.isNumeric() ? Integer.valueOf(lead.Folio__c) : 0;
			    bi.idperiodo = lead.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(lead.Periodo__r.IdPeriodo__c) : 0;
			    bi.idplantel = lead.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(lead.Plantel__r.IdInterno__c)) : 0;
			    bi.idnivel = lead.Nivel__r.IdInternoNivel__c != null ? Integer.valueOf(String.valueOf(lead.Nivel__r.IdInternoNivel__c)) : 0;
			    bi.idprograma = lead.Programa__r.IdInterno__c != null ? Integer.valueOf(lead.Programa__r.IdInterno__c) : 0;
			    bi.idbeca = lead.Beca__r.IdInterno__c != null ? Integer.valueOf(lead.Beca__r.IdInterno__c) : 0;
			    bi.porcentaje = lead.Beca__r.PorcentajeBeca__c != null ? Integer.valueOf(String.valueOf(lead.Beca__r.PorcentajeBeca__c)) : 0;
			    bi.valor = 0;
			    if(lead.Beca__r.IdTipoBeca__c!=null && lead.Beca__r.IdTipoBeca__c == '2') {
			    	bi.valor = Integer.valueOf((lead.LetraBeca__c != null && lead.Beca__r != null ? lead.Beca__r.get(lead.LetraBeca__c+'__c') : '0'));
			    }
			    bi.fecharegistro = lead.Beca__r.CreatedDate != null ? lead.Beca__r.CreatedDate.format('yyyy-MM-dd') : '0000-00-00';
			    bi.usuarioRegistra = lead.Beca__r.CreatedBy.Name != null ? lead.Beca__r.CreatedBy.Name : '';
			    if(bi.usuarioRegistra.length() > 50) {
			    	bi.usuarioRegistra = bi.usuarioRegistra.substring(0, 49);
			    }
			    bi.esquema = lead.Beca__r.IdTipoBeca__c != null ? Integer.valueOf(lead.Beca__r.IdTipoBeca__c) : 0;
			    bi.usuarioAutoriza = lead.Beca__r.CreatedBy.Name != null ? lead.Beca__r.CreatedBy.Name : '';//PENDIENTE
			    if(bi.usuarioAutoriza.length() > 50) {
			    	bi.usuarioAutoriza = bi.usuarioAutoriza.substring(0, 49);
			    }
			    bi.fechaAutorizacion = lead.Beca__r.CreatedDate != null ? lead.Beca__r.CreatedDate.format('yyyy-MM-dd') : '0000-00-00';//PENDIENTE
			    bi.actualizar = lead.ModificadoERP__c ? 1 : 0;
			    ls.BecasInfo.add(bi);
			}
	    	return ls;
	    }

	    public IEU_ERPMaster.ArrayOfPagosGrupoInfo addPagosGrupoInfo(List<sObject> sobjects) {
	    	IEU_ERPMaster.ArrayOfPagosGrupoInfo ls = new IEU_ERPMaster.ArrayOfPagosGrupoInfo();
			ls.PagosGrupoInfo = new List<IEU_ERPMaster.PagosGrupoInfo>();
			for(sObject obj: sobjects) {
			    Grupo__c grupo = (Grupo__c) obj;
			    IEU_ERPMaster.PagosGrupoInfo pgi = new IEU_ERPMaster.PagosGrupoInfo();
			    pgi.idGrupo = grupo.IdGrupo__c != null ? Integer.valueOf(grupo.IdGrupo__c) : 0;
			    pgi.concepto = 1;//PENDIENTE	
			    pgi.cantidad = 1;//PENDIENTE
			    pgi.costo = 1.1;//PENDIENTE
			    pgi.actualizar = 0;
			    ls.PagosGrupoInfo.add(pgi);
			} 
	    	return ls;
	    }

	    public IEU_ERPMaster.ArrayOfPagosInscripcionInfo addPagosInscripcionInfo(List<sObject> sobjects) {
	    	IEU_ERPMaster.ArrayOfPagosInscripcionInfo ls = new IEU_ERPMaster.ArrayOfPagosInscripcionInfo();
			ls.PagosInscripcionInfo = new List<IEU_ERPMaster.PagosInscripcionInfo>();

			for(sObject obj: sobjects) {
			    FichaPago__c ficha = (FichaPago__c) obj;
			    IEU_ERPMaster.PagosInscripcionInfo pii = new IEU_ERPMaster.PagosInscripcionInfo();
			    pii.folio = ficha.Lead__r.Folio__c != null && ficha.Lead__r.Folio__c.isNumeric() ? Integer.valueOf(ficha.Lead__r.Folio__c) : 0;
			    pii.periodo = ficha.Lead__r.Periodo__r.IdPeriodo__c != null ? Integer.valueOf(ficha.Lead__r.Periodo__r.IdPeriodo__c) : 0;
			    pii.idPlantel = ficha.Lead__r.Plantel__r.IdInterno__c != null ? Integer.valueOf(String.valueOf(ficha.Lead__r.Plantel__r.IdInterno__c)) : 0;
			    pii.concepto = 1;//Integer.valueOf(ficha.Concepto__c);
			    pii.idFormaPago = 1;//ficha.Lead__r.FormaPago__c != null ? Integer.valueOf(ficha.Lead__r.FormaPago__c) : 0;
			    pii.idBanco = 1;//PENDIENTE
			    pii.cantidad = ficha.MontoPagado__c;
			    pii.numAutorizacion = ficha.NumeroAutorizacion__c;
			    if(pii.numAutorizacion.length() > 80) {
			    	pii.numAutorizacion = pii.numAutorizacion.substring(0, 79);
			    }
			    pii.fechaPago = ficha.FechaPago__c != null ? String.valueOf(ficha.FechaPago__c) : '';
			    pii.tipoTarjeta = 1;//PENDIENTE
			    pii.actualizar = 0;//ficha.ModificadoERP__c ? 1 : 0;
			    ls.PagosInscripcionInfo.add(pii);
			}
	    	return ls;
	    }
	    
	}