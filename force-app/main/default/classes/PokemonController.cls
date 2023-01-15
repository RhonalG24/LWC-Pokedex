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
    public static Pokemon__c[] searchPokemons(String searchTerm, String type, Integer generation) {
        // Return all pokemons when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '' & type == '' && generation == null) {
            return getAllPokemons();
        }
        // Prepare query paramters
        
        String query = 'SELECT Id, Name, Altura__c, Ataque__c, Defensa__c, ExtId__c, Generacion__c, Imagen__c, Habilidad__r.Name, Peso__c, Slot1__r.Name, Slot2__r.Name, Slot3__r.Name, Slot4__r.Name, Tipos__c, Velocidad__c, Vida__c FROM Pokemon__c';
        if(searchTerm != '' ){
            searchTerm = '%' + searchTerm + '%';
            query += ' WHERE Name LIKE :searchTerm ';
        }
        if(type != ''){
            query += ( query.contains('WHERE') ? ' AND ': ' WHERE ') + 'Tipos__c INCLUDES (:type) ';
            // query.includes('WHERE') ? (query += ' AND Tipos__c = ' + type) : (query += ' WHERE Tipos__c = ' + type);
        }
        if(generation != null){
            query += ( query.contains('WHERE') ? ' AND ': ' WHERE ') + 'Generacion__c =:generation ';
            // query.includes('WHERE') ? (query += ' AND Generacion__c = ' + String.valueOf(generation)) : (query += ' AND Generacion__c = ' + String.valueOf(generation)) ;
        }
        query += ' ORDER BY ExtId__c LIMIT 50';
        return Database.query(query);
    }
}