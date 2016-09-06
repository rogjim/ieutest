public with sharing class UtilsOferta {
    /*
* @author:     Daniel Hernández
* @date:        25/05/2016
* @description: Obtiene catálogos dinámicos, para Lead y Opp. Se retornan valores de lista de selección, excepto 
				en los elementos generales de Ubicación (por consideraciones de búsqueda en el objeto) y en los métodos
				getPeriodos() y getModalidadesMoviles() (debido a que se puede referenciar información adicional)
* @param:       idRelación
* @return:      List<SelectOption>
*/
    
    /* INFORMACIÓN DE OFERTA EDUCATIVA */
    public static List<SelectOption> getModalidades(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-- Seleccione una Modalidad --'));
        try{
            for(Catalogo__c cat: [SELECT Id, Name FROM Catalogo__c WHERE TipoCatalogo__c ='Modalidad' LIMIT 100]){
                options.add(new SelectOption(cat.Id,cat.Name));
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return options;
    }
    public static List<SelectOption> getPlanteles(String idModalidad){ 
        //Los planteles se repiten porque vienen de una lista de relación del objeto Oferta, pero el Id es el mismo, por eso se agregan a un mapa para evitar duplicados
        //Lo mismo aplica para Nivel, Programa y Periodo
        List<SelectOption> planteles = new List<SelectOption>();
        Map<String,String> mapaPlanteles = new Map<String,String>();
        
        planteles.add(new SelectOption('','-- Seleccione un Plantel --'));
        try{
            for(AggregateResult cat: [SELECT Plantel__c, Plantel__r.Name FROM OfertaEducativa__c WHERE Modalidad__c =: idModalidad GROUP BY Plantel__c, Plantel__r.Name ORDER BY Plantel__r.Name LIMIT 100]){
                if(!mapaPlanteles.containsKey(String.valueOf(cat.get('Plantel__c')))){
                    mapaPlanteles.put(String.valueOf(cat.get('Plantel__c')),String.valueOf(cat.get('Name')));
                    planteles.add(new SelectOption(String.valueOf(cat.get('Plantel__c')),String.valueOf(cat.get('Name'))));
                }
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return planteles;
    }
    public static List<SelectOption> getNiveles(String idPlantel, String idModalidad){
        List<SelectOption> niveles = new List<SelectOption>();
        Map<String,String> mapaNiveles = new Map<String,String>();
        
        niveles.add(new SelectOption('','-- Seleccione un Nivel --'));
        try{
            for(AggregateResult cat: [SELECT Nivel__c, Nivel__r.Name FROM OfertaEducativa__c WHERE Plantel__c =: idPlantel AND Modalidad__c=:idModalidad GROUP BY Nivel__c, Nivel__r.Name ORDER BY Nivel__r.Name LIMIT 100]){
                if(!mapaNiveles.containsKey(String.valueOf(cat.get('Nivel__c')))){
                    mapaNiveles.put(String.valueOf(cat.get('Nivel__c')),String.valueOf(cat.get('Name')));
                    niveles.add(new SelectOption(String.valueOf(cat.get('Nivel__c')),String.valueOf(cat.get('Name'))));
                }
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return niveles;
    }
    public static List<SelectOption> getProgramas(String idPlantel, String idModalidad, String idNivel){
        List<SelectOption> programas = new List<SelectOption>();
        Map<String,String> mapaPrograma = new Map<String,String>();
        
        programas.add(new SelectOption('','-- Seleccione un Programa --'));
        try{
            for(AggregateResult cat: [SELECT Programa__c, Programa__r.Name FROM OfertaEducativa__c WHERE Plantel__c =: idPlantel AND Modalidad__c=:idModalidad AND Nivel__c=:idNivel GROUP BY Programa__c, Programa__r.Name ORDER BY Programa__r.Name LIMIT 100]){
                if(!mapaPrograma.containsKey(String.valueOf(cat.get('Programa__c')))){
                    mapaPrograma.put(String.valueOf(cat.get('Programa__c')),String.valueOf(cat.get('Name')));
                    programas.add(new SelectOption(String.valueOf(cat.get('Programa__c')),String.valueOf(cat.get('Name'))));
                }
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return programas;
    }
    
    public static List<SelectOption> getProgramasMoviles(String fichaMovil){
        
        FichaPago__c fichaInfo = [SELECT ProgramasRelacionados__c FROM FichaPago__c WHERE Id =: fichaMovil LIMIT 1];
        SET<Id> programasMovil = new Set<Id>();
        String programasId = fichaInfo.ProgramasRelacionados__c;
        System.debug('programasId -> ' + programasId);
        List<String> splitProgramas = programasId.split(',');
        for(String idPrograma: splitProgramas){
            programasMovil.add(idPrograma);
        }
        List<SelectOption> programas = new List<SelectOption>();
        Map<String,String> mapaPrograma = new Map<String,String>();
        
        programas.add(new SelectOption('','-- Seleccione un Programa --'));
        try{
            for(Programa__c cat: [SELECT Id, Name FROM Programa__c  WHERE Id in: programasMovil LIMIT 100]){
                if(!mapaPrograma.containsKey(String.valueOf(cat.get('Id')))){
                    mapaPrograma.put(String.valueOf(cat.get('Id')),String.valueOf(cat.get('Name')));
                    programas.add(new SelectOption(String.valueOf(cat.get('Id')),String.valueOf(cat.get('Name'))));
                }
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return programas;
    }
    
    public static List<OfertaEducativa__c> getModalidadesMoviles(String idPlantel, String idPeriodo, String idNivel, String IdPrograma){
        List<OfertaEducativa__c> periodos = new List<OfertaEducativa__c>();
        System.debug('idPlantel'+idPlantel);
        System.debug('idPeriodo'+idPeriodo);
        System.debug('idNivel'+idNivel);
        System.debug('IdPrograma'+IdPrograma);
        try{
            periodos = [SELECT Id, Name, Modalidad__c, Modalidad__r.Name FROM OfertaEducativa__c WHERE Plantel__c =: idPlantel AND Periodo__c=:idPeriodo AND Nivel__c=:idNivel AND Periodo__r.Activo__c='Activo' AND Programa__c=:IdPrograma ORDER BY Periodo__r.Name LIMIT 100];
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        System.debug('tamaño periodos'+periodos.size());
        return periodos;
    }
    public static List<SelectOption> getPeriodo(String idPlantel, String idModalidad, String idNivel, String IdPrograma){ // Este método no se utiliza actualmente, en su lugar se usa el método getPeriodos()
        List<SelectOption> periodos = new List<SelectOption>();
        Map<String,OfertaEducativa__c> mapaPeriodos = new Map<String,OfertaEducativa__c>();
        periodos.add(new SelectOption('','-- Seleccione un Periodo --'));
        try{
            
            for(OfertaEducativa__c cat: [SELECT Id, Name, Periodo__c, Periodo__r.Name FROM OfertaEducativa__c WHERE Plantel__c =: idPlantel AND Modalidad__c=:idModalidad AND Nivel__c=:idNivel AND Periodo__r.Activo__c='Activo' AND Programa__c=:IdPrograma ORDER BY Periodo__r.Name LIMIT 100]){
                if(!mapaPeriodos.containsKey(cat.Periodo__c)){
                    mapaPeriodos.put(cat.Periodo__c, cat);
                    periodos.add(new SelectOption(cat.Periodo__c,cat.Periodo__r.Name));
                }
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return periodos;
    }
    public static List<OfertaEducativa__c> getPeriodos(String idPlantel, String idModalidad, String idNivel, String IdPrograma){
        List<OfertaEducativa__c> periodos = new List<OfertaEducativa__c>();
        try{
            periodos = [SELECT Periodo__c, Periodo__r.Name FROM OfertaEducativa__c WHERE Plantel__c =: idPlantel AND Modalidad__c=:idModalidad AND Nivel__c=:idNivel AND Periodo__r.Activo__c='Activo' AND Programa__c=:IdPrograma ORDER BY Periodo__r.Name LIMIT 100];
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return periodos;
    }
    
    
    /* INFORMACIÓN DE DIRECCIÓN */
    public static List<Ubicacion__c> getPaises(){
        List<Ubicacion__c> options = new List<Ubicacion__c>();
        try{
            options = [SELECT Id,Name,Abreviatura__c,Cabecera__c,Capital__c,IdUbicacion__c,IdEstadoPais__c,TipoUbicacion__c FROM Ubicacion__c WHERE TipoUbicacion__c ='País' ORDER BY Name];
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return options;
    }
    public static List<Ubicacion__c> getEstados(String idPais){
        List<Ubicacion__c> options = new List<Ubicacion__c>();
        try{
            options = [SELECT Id,Name,Abreviatura__c,Cabecera__c,Capital__c,IdUbicacion__c,IdEstadoPais__c,TipoUbicacion__c FROM Ubicacion__c WHERE IdEstadoPais__c=:idPais AND TipoUbicacion__c='Estado' ORDER BY Name];
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return options;
    }
    
    public static List<SelectOption> getMunicipios(String idEstado){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-- Seleccione un Municipio --'));
        try{
            for(Ubicacion__c locality: [SELECT Id,Name,Abreviatura__c,Cabecera__c,Capital__c,IdUbicacion__c,IdEstadoPais__c,TipoUbicacion__c FROM Ubicacion__c WHERE IdEstadoPais__c=:idEstado AND TipoUbicacion__c='Municipio' ORDER BY Name]){
                options.add(new SelectOption(locality.Id,locality.Name));
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        if(options.size()==0){
            options = new List<SelectOption>();
            options.add(new SelectOption('','No disponible'));
        }
        return options;
    }
    
}