@IsTest
public with sharing class PokemonControllerTest {
    @TestSetup
    static void makeData(){
        Pokemon__c pokemon1 = new Pokemon__c(Name='nombre', ExtId__c=1, Nombre__c='nombre', Tipos__c='Fighting;Bug');
        insert pokemon1;
        Pokemon__c pokemon2 = new Pokemon__c(Name='nombre2', ExtId__c=2, Nombre__c='nombre2', Tipos__c='Fighting');
        insert pokemon2;
    }

    @IsTest
    static void shouldRetrievePokemons(){

        Test.startTest();
        List<Pokemon__c> pokemonlst = PokemonController.getAllPokemons();
        Test.stopTest();

        System.assertEquals(2, pokemonlst.size());
    }
    @IsTest
    static void shouldNotRetrievePokemons(){
        
        delete [SELECT Id FROM Pokemon__c];
        String error = '';
        Test.startTest();
            try{
                List<Pokemon__c> pokemonlst = PokemonController.getAllPokemons();
            }Catch(Exception e){
                error = e.getMessage();
            }
        Test.stopTest();
        System.assertEquals('', error);
    }

    @IsTest
    static void shouldRetrieveAllPokemonsUsingSearchMethod(){

        Test.startTest();
        List<Pokemon__c> pokemonlst = PokemonController.searchPokemons('', '', -1 );
        Test.stopTest();

        System.assertEquals(2, pokemonlst.size());
    }

    @IsTest
    static void shouldRetrievePokemonsUsingSearchMethod(){

        Test.startTest();
        List<Pokemon__c> pokemonlst = PokemonController.searchPokemons('no', 'Fighting', 1 );
        Test.stopTest();

        System.assertEquals(2, pokemonlst.size());
    }

    @IsTest
    static void shouldNotRetrievePokemonsUsingSearchMethod(){
        
        delete [SELECT Id FROM Pokemon__c];
        String error = '';
        Test.startTest();
            try{
                List<Pokemon__c> pokemonlst = PokemonController.searchPokemons('asdw', '', -1);
            }Catch(Exception e){
                error = e.getMessage();
            }
        Test.stopTest();
        System.assertEquals('', error);
    }
}
/*

@IsTest
static void deberiaObtenerCuentas(){

    Test.startTest();
    List<Account> cuentalst = AccountController.getAccounts();
    Test.stopTest();

    System.assertEquals(2, cuentalst.size());
}

@IsTest
static void noDeberiaObtenerNingunaCuenta(){
    
    delete [SELECT Id FROM Account];
    String error = '';
    Test.startTest();
        try{
            List<Account> cuentalst = AccountController.getAccounts();
        }Catch(Exception e){
            error = e.getMessage();
        }
    Test.stopTest();
    System.assertEquals('Ups! no se enocontraron cuentas', error);
}
}
*/