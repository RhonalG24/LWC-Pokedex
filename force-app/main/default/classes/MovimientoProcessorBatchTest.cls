@IsTest
public with sharing class MovimientoProcessorBatchTest {
    @IsTest
    static void ShouldRetrieveAMove(){
        String response = '{"accuracy":100,"damage_class":{"name":"physical","url":"https://pokeapi.co/api/v2/move-damage-class/2/"},"effect_chance":100,"effect_entries":[{"effect":"Inflicts regular damage.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Inflicts regular damage with no additional effect."}],"id":1,"name":"pound","power":40,"pp":35,"priority":0,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"normal","url":"https://pokeapi.co/api/v2/type/1/"}}';
        SingleRequestMock mock = new SingleRequestMock(
                                                        200,
                                                        'OK',
                                                        response,
                                                        null
                                                    );
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            Database.executeBatch(new MovimientoProcessorBatch(), 1);
        Test.stopTest();
        Movimiento__c movimientoAVerificar = [SELECT Id, Name FROM Movimiento__c Limit 1];

        System.assertNotEquals('pound', movimientoAVerificar.Name,
        'La primera letra del nombre debe estar en Mayúscula');

        System.assertEquals('Pound', movimientoAVerificar.Name, 
        'los nombres no coinciden, el resultado fue :: '+movimientoAVerificar.Name);
    }
    @IsTest
    static void ShouldNOTRetrieveAMove(){
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
            Database.executeBatch(new MovimientoProcessorBatch(), 1);
            Test.stopTest();
        }catch(Exception e){
            error = e.getMessage();
        }
        List<Movimiento__c> movimientoAVerificar = [SELECT Id, Name FROM Movimiento__c Limit 1];

        System.assertEquals('Error : no results', error);
        System.assertEquals(0, movimientoAVerificar.size());
    }
}