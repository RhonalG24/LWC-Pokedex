@IsTest
public with sharing class HabilidadProcessorBatchTest {
    //@TestSetup
    // static void makeData(){
    //     Account cuenta = new Account(name = 'Martin');
    //     insert cuenta;
    // }

    @IsTest
    static void ShouldRetrieveAnAbilitie(){
        String response = '{"effect_changes":[{"effect_entries":[{"effect":"Hat im Kampf keinen Effekt.","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"}},{"effect":"Has no effect in battle.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"}}],"version_group":{"name":"black-white","url":"https://pokeapi.co/api/v2/version-group/11/"}}],"effect_entries":[{"language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen."},{"language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a 10% chance of making target Pokémon flinch with each hit."}],"generation":{"name":"generation-iii","url":"https://pokeapi.co/api/v2/generation/3/"},"id":1,"is_main_series":true,"name":"stench","names":[{"language":{"name":"ja-Hrkt","url":"https://pokeapi.co/api/v2/language/1/"},"name":"あくしゅう"},{"language":{"name":"ko","url":"https://pokeapi.co/api/v2/language/3/"},"name":"악취"},{"language":{"name":"zh-Hant","url":"https://pokeapi.co/api/v2/language/4/"},"name":"惡臭"},{"language":{"name":"fr","url":"https://pokeapi.co/api/v2/language/5/"},"name":"Puanteur"},{"language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"name":"Duftnote"},{"language":{"name":"es","url":"https://pokeapi.co/api/v2/language/7/"},"name":"Hedor"},{"language":{"name":"it","url":"https://pokeapi.co/api/v2/language/8/"},"name":"Tanfo"},{"language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"name":"Stench"},{"language":{"name":"ja","url":"https://pokeapi.co/api/v2/language/11/"},"name":"あくしゅう"},{"language":{"name":"zh-Hans","url":"https://pokeapi.co/api/v2/language/12/"},"name":"恶臭"}],"pokemon":[{"is_hidden":true,"pokemon":{"name":"gloom","url":"https://pokeapi.co/api/v2/pokemon/44/"},"slot":3},{"is_hidden":false,"pokemon":{"name":"grimer","url":"https://pokeapi.co/api/v2/pokemon/88/"},"slot":1},{"is_hidden":false,"pokemon":{"name":"muk","url":"https://pokeapi.co/api/v2/pokemon/89/"},"slot":1},{"is_hidden":true,"pokemon":{"name":"koffing","url":"https://pokeapi.co/api/v2/pokemon/109/"},"slot":3},{"is_hidden":true,"pokemon":{"name":"weezing","url":"https://pokeapi.co/api/v2/pokemon/110/"},"slot":3},{"is_hidden":false,"pokemon":{"name":"stunky","url":"https://pokeapi.co/api/v2/pokemon/434/"},"slot":1},{"is_hidden":false,"pokemon":{"name":"skuntank","url":"https://pokeapi.co/api/v2/pokemon/435/"},"slot":1},{"is_hidden":false,"pokemon":{"name":"trubbish","url":"https://pokeapi.co/api/v2/pokemon/568/"},"slot":1},{"is_hidden":false,"pokemon":{"name":"garbodor","url":"https://pokeapi.co/api/v2/pokemon/569/"},"slot":1},{"is_hidden":false,"pokemon":{"name":"garbodor-gmax","url":"https://pokeapi.co/api/v2/pokemon/10207/"},"slot":1}]}';
        SingleRequestMock mock = new SingleRequestMock(
                                                        200,
                                                        'OK',
                                                        response,
                                                        null
                                                    );
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            Database.executeBatch(new HabilidadProcessorBatch(), 1);
        Test.stopTest();
        Habilidad__c habilidadAVerificar = [SELECT Id, Name FROM Habilidad__c Limit 1];

        System.assertNotEquals('stench', habilidadAVerificar.Name,
        'La primera letra del nombre debe estar en Mayúscula');

        System.assertEquals('Stench', habilidadAVerificar.Name, 
        'los nombres no coinciden, el resultado fue :: '+habilidadAVerificar.Name);
    }
    @IsTest
    static void ShouldNOTRetrieveAnAbilitie(){
        String response = 'no results';
        SingleRequestMock mock = new SingleRequestMock(
                                                        404,
                                                        'OK',
                                                        response,
                                                        null
                                                    );
        Test.setMock(HttpCalloutMock.class, mock);
        String error = '';
        try{
            Test.startTest();
            Database.executeBatch(new HabilidadProcessorBatch(), 1);
            Test.stopTest();
        }        catch(Exception e){
            // System.debug(e.getMessage());
            error = e.getMessage();
        }
        List<Habilidad__c> habilidadAVerificar = [SELECT Id, Name FROM Habilidad__c Limit 1];

        System.assertEquals('Error : no results', error);
        // System.assertEquals(0, habilidadAVerificar.size());
    }
}

/*
@IsTest
public with sharing class CuentasBatch2Test {
    @TestSetup
    static void makeData(){
        Account cuenta = new Account(name = 'Martin');
        insert cuenta;
    }
    @IsTest
    static void CaminoFeliz(){
        SingleRequestMock mock = new SingleRequestMock(
                                                        200,
                                                        'OK',
                                                        '{"name": "Charmander","Id":"31","Order":"41","forms":[{"name": "ditto"}]}',
                                                        null
                                                    );
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            Database.executeBatch(new CuentasBatch2(), 1);
        Test.stopTest();
        Account cuentaAVerificar = [SELECT Id, Name FROM Account Limit 1];

        System.assertNotEquals('Martin', cuentaAVerificar.Name,
        'Lamenteblemente el nomber de la cuenta sigue siendo el mismo');

        System.assertEquals('Martin ++ Charmander', cuentaAVerificar.Name, 
        'los nombres no coinciden, el resultado fue :: '+cuentaAVerificar.Name);
    }
    static void CaminoFeliz(){
        SingleRequestMock mock = new SingleRequestMock(
                                                        200,
                                                        'OK',
                                                        '{"name": "Charmander","Id":"31","Order":"41","forms":[{"name": "ditto"}]}',
                                                        null
                                                    );
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            Database.executeBatch(new CuentasBatch2(), 1);
        Test.stopTest();
        Account cuentaAVerificar = [SELECT Id, Name FROM Account Limit 1];

        System.assertNotEquals('Martin', cuentaAVerificar.Name,
        'Lamenteblemente el nomber de la cuenta sigue siendo el mismo');

        System.assertEquals('Martin ++ Charmander', cuentaAVerificar.Name, 
        'los nombres no coinciden, el resultado fue :: '+cuentaAVerificar.Name);
    }

}
*/