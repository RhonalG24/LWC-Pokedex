@isTest
public with sharing class PokeAPIUtilsTest {
    @isTest
    public static void shouldRetrieveAPokemon() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'OK',
                                                 '{"name": "bulbasaur"}',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        String pokemon = PokeAPIUtils.GetPokemon(0);
        Test.stopTest();
        system.debug(pokemon);
        System.assertEquals('{"name": "bulbasaur"}', pokemon);
    }
    
    @isTest
    public static void ShouldThrowAnErrorWhenRetrievingPokemon() {
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                 'Error',
                                                 'No encontrado',
                                                 null);
        string error = null;
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            try {
                String pokemon = PokeAPIUtils.GetPokemon(0);
            } catch (Exception e) {
                error = e.getMessage();
            }
        Test.stopTest();
        System.assertEquals('Error : No encontrado', error);
    }

    @isTest
    public static void shouldRetrieveAnHabilidad() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'OK',
                                                 '{"name": "stench"}',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        String habilidad = PokeAPIUtils.GetHabilidad(0);
        Test.stopTest();
        //system.debug(habilidad);
        System.assertEquals('{"name": "stench"}', habilidad);
    }
    
    @isTest
    public static void ShouldThrowAnErrorWhenRetrievingAnHabilidad() {
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                 'Error',
                                                 'No encontrado',
                                                 null);
        string error = null;
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            try {
                String habilidad = PokeAPIUtils.GetHabilidad(0);
            } catch (Exception e) {
                error = e.getMessage();
            }
        Test.stopTest();
        System.assertEquals('Error : No encontrado', error);
    }

    @isTest
    public static void shouldRetrieveAMovimiento() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'OK',
                                                 '{"name": "pound"}',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        String movimiento = PokeAPIUtils.GetMovimiento(0);
        Test.stopTest();
        //system.debug(movimiento);
        System.assertEquals('{"name": "pound"}', movimiento);
    }
    
    @isTest
    public static void ShouldThrowAnErrorWhenRetrievingAMovimiento() {
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                 'Error',
                                                 'No encontrado',
                                                 null);
        string error = null;
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            try {
                String movimiento = PokeAPIUtils.GetMovimiento(0);
            } catch (Exception e) {
                error = e.getMessage();
            }
        Test.stopTest();
        System.assertEquals('Error : No encontrado', error);
    }

}

// @isTest
// public class StarWarsCalloutTest {
//     @isTest
//     public static void testGetName() {
//         SingleRequestMock fakeResponse = new SingleRequestMock(200,
//                                                  'OK',
//                                                  '{"name": "Luke Skywalker"}',
//                                                  null);
// 		Test.setMock(HttpCalloutMock.class, fakeResponse);
//         Test.startTest();
//         String name = StarWarsCallout.getName(0);
//         Test.stopTest();
//         system.debug(name);
//         System.assertEquals('Luke Skywalker', name);
//     }
    
//     @isTest
//     public static void ShouldThrowAnError() {
//         SingleRequestMock fakeResponse = new SingleRequestMock(404,
//                                                  'Error',
//                                                  'No encontrado',
//                                                  null);
//         string error = null;
// 		Test.setMock(HttpCalloutMock.class, fakeResponse);
//         Test.startTest();
//             try {
//                 String name = StarWarsCallout.getName(0);
//             } catch (Exception e) {
//                 error = e.getMessage();
//             }
//         Test.stopTest();
//         System.assertEquals('Error : No encontrado', error);
//     }

// }