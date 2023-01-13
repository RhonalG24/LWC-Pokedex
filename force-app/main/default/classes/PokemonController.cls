public with sharing class PokemonController {

    @AuraEnabled(cacheable=true scope='global')
    public static Pokemon__c[] getAllPokemons() {
        return [
            SELECT
                Id,
                Name,
                Altura__c,
                Ataque__c,
                Defensa__c,
                ExtId__c,
                Generacion__c,
                Imagen__c,
                Habilidad__r.Name,
                Peso__c,
                Slot1__r.Name,
                Slot2__r.Name,
                Slot3__r.Name,
                Slot4__r.Name,
                Tipos__c,
                Velocidad__c,
                Vida__c
            FROM Pokemon__c
            WITH SECURITY_ENFORCED
            ORDER BY ExtId__c
            LIMIT 50
        ];
    }

    @AuraEnabled(cacheable=true scope='global')
    public static Pokemon__c[] searchPokemons(String searchTerm, String field, String sortOrder) {
        // Return all bears when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '' /*|| field == null && sortOrder == null*/) {
            return getAllPokemons();
        }
        // Prepare query paramters
        searchTerm = '%' + searchTerm + '%';
        // String query;
        // query  = 'SELECT Id, Name, Altura__c, Ataque__c, Defensa__c, ExtId__c, Generacion__c, Imagen__c, Habilidad__r.Name, Peso__c, Slot1__r.Name, Slot2__r.Name, Slot3__r.Name, Slot4__r.Name, Tipos__c, Velocidad__c, Vida__c FROM Pokemon__c WHERE Name LIKE ' + searchTerm + ' WITH SECURITY_ENFORCED';
        // // if(field != null && sortOrder !=null){
        // //     query += ' ORDER BY '+field+' '+sortOrder;
        // // }else {
        // //     query += ' ORDER BY Name';
        // // }
        // query += ' LIMIT 50';
        // return Database.query(query);
        // Execute search query
        return [
            SELECT
                Id,
                Name,
                Altura__c,
                Ataque__c,
                Defensa__c,
                ExtId__c,
                Generacion__c,
                Imagen__c,
                Habilidad__r.Name,
                Peso__c,
                Slot1__r.Name,
                Slot2__r.Name,
                Slot3__r.Name,
                Slot4__r.Name,
                Tipos__c,
                Velocidad__c,
                Vida__c
            FROM Pokemon__c
            WHERE Name LIKE :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY ExtId__c
            LIMIT 50
        ];
    }
}