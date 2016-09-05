public with sharing class IEU_ERPMasterCliente {
    public IEU_ERPMaster.serviceSoap soap = new IEU_ERPMaster.serviceSoap();
    
    public IEU_ERPMasterCliente(Integer timeout){
    	this.soap.timeout_x = timeout;
    }
    
    public String addCandidato(String usuario,String pwd,IEU_ERPMaster.ArrayOfCandidatoInfo candidatoInfo) {
    	String respuesta = '';
    	try{
    		respuesta = soap.AddCandidatoInfo(usuario,pwd,candidatoInfo);
    	}catch(Exception e){
    		respuesta = e.getMessage();
    	}
    	return respuesta;
    }
    public String addGrupo(String usuario,String pwd,IEU_ERPMaster.ArrayOfGrupoInfo grupoInfo) {
        String respuesta = '';
        try{
            respuesta = soap.AddGrupoInfo(usuario,pwd,grupoInfo);
        }catch(Exception e){
    		respuesta = e.getMessage();
        }
        return respuesta;
    }
    public String addBeca(String usuario,String pwd,IEU_ERPMaster.ArrayOfBecasInfo becasInfo) {
        String respuesta = '';
        try{
            respuesta = soap.AddBecasInfo(usuario,pwd,becasInfo);
        }catch(Exception e){
    		respuesta = e.getMessage();
        }
        return respuesta;
    }
    public String addPagosGrupo(String usuario,String pwd,IEU_ERPMaster.ArrayOfPagosGrupoInfo pagosGrupoInfo) {
        String respuesta = '';
        try{
            respuesta = soap.AddPagosGrupoInfo(usuario,pwd,pagosGrupoInfo);
        }catch(Exception e){
    		respuesta = e.getMessage();
        }
        return respuesta;
    }
    public String addPagosInscripcion(String usuario,String pwd,IEU_ERPMaster.ArrayOfPagosInscripcionInfo pagosInscripcionInfo) {
        String respuesta = '';
        try{
            respuesta = soap.AddPagosInscripcionInfo(usuario,pwd,pagosInscripcionInfo);
        }catch(Exception e){
    		respuesta = e.getMessage();
        }
        return respuesta;
    }
    
}