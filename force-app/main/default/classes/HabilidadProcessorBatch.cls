public with sharing class HabilidadProcessorBatch implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    public Integer recordsProcessed = 0;
    // Integer TOTAL_POKEMONS = 898;
    
    Integer TOTAL_HABILIDADES = 267;
    // Integer TOTAL_MOVIMIENTOS = 826;
    
    public Iterable<Integer> start(Database.BatchableContext bc) {
        
        List<Integer> listToReturn = new List<Integer>();
        if(!Test.isRunningTest()){
            for(Integer i = 1; i <= TOTAL_HABILIDADES; i++){
                listToReturn.add(i);
            }
        }else {
            listToReturn.add(1);
        }

        return listToReturn;

    }
    public void execute(Database.BatchableContext bc, List<Integer> intList){
        List<Habilidad__c> habilitiesList = new List<Habilidad__c>();

        for(Integer index: intList){
            try{
                String response = GetHabilidad(index);
                Habilidad__c habilidad = getMappedHabilidad(response);
                habilitiesList.add(habilidad);
                recordsProcessed++;
            }catch(Exception e){
                // System.debug(e.getMessage());
                throw new CalloutException(e.getMessage());
            }
        }
        try {
            upsert habilitiesList;
        } catch(Exception e) {
            System.debug(e);
        }
        
        return;
    }


    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed!');
        if(!Test.isRunningTest()){
            Database.executeBatch(new MovimientoProcessorBatch(), 10);
        }
        
    }

    @AuraEnabled
    public static String GetHabilidad(Integer id) {

        Http http = new Http(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/'+id);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');

        HttpResponse response = http.send(request);

        if(response.getStatusCode() != 200 && response.getbody() != null){
            System.debug(id);
            throw new CalloutException('Error : '+response.getBody());
        }
        return response.getBody();
    }

    public static Habilidad__c getMappedHabilidad(String JSONToMap) {
        Habilidad__c habilidadMapped = new Habilidad__c();
        
        JSON2ApexHabilidad habilidadParsed = JSON2ApexHabilidad.parse(JSONToMap);
        try {
            habilidadMapped.ExtId__c = habilidadParsed.id;
            for(Integer i = 0; i < habilidadParsed.effect_entries.size(); i++){
                if(habilidadParsed.effect_entries[i].language.name == 'en'){
                    habilidadMapped.Efecto__c = habilidadParsed.effect_entries[i].short_effect;
                    break;
                }
            }
            habilidadMapped.Nombre__c = habilidadParsed.name.capitalize();
            habilidadMapped.Name = habilidadParsed.name.capitalize();
        } catch(Exception e) {
            System.debug(e+'Error mapping');
        }

        return habilidadMapped;
        
    }

    // public static void deleteAllHabilidad(){
    //     List<Habilidad__c> habLst = [SELECT id FROM Habilidad__c];
    //     delete habLst;
    //     return;
    // }
}