public with sharing class PokeAPIUtils {

    @AuraEnabled
    public static String GetPokemon(Integer id) {

        Http http = new Http(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+id);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() != 200 && response.getbody() != null){
            throw new CalloutException('Error : '+response.getBody());
        }
        //System.debug(JSON2ApexPokemon.parse(response.getBody()));
        
        return response.getBody();  
    }

        /* Obtener los datos con el JSON2Apex
            JSON2ApexPokemon pokemon = JSON2ApexPokemon.parse(PokeAPIUtils.GetPokemon(1));
            System.debug(pokemon);
            System.debug((pokemon.name).capitalize());
            System.debug(pokemon.height);
            System.debug(pokemon.weight);
            System.debug(pokemon.types.size());
            System.debug(pokemon.types[0].type.name);
			System.debug(pokemon.types[1].type.name);
            for(integer i = 0; i < pokemon.stats.size(); i++){
            System.debug(pokemon.stats[i].base_stat);
            System.debug(pokemon.stats[i].stat.name);
            }
			//[0] -> HP
            //[1] -> attack
            //[2] -> defense
            //[5] -> speed
            System.debug(pokemon.abilities[0].ability.name);
			System.debug(pokemon.abilities[1].ability.name);
            

JSON2ApexPokemon pokemon = JSON2ApexPokemon.parse(PokeAPIUtils.GetPokemon(1));
            //System.debug(pokemon);
            //System.debug((pokemon.name).capitalize());
            //System.debug(pokemon.height);
            //System.debug(pokemon.weight);
            //System.debug(pokemon.types.size());
            //System.debug(pokemon.types[0].type.name);
//System.debug(pokemon.types[1].type.name);
            //for(integer i = 0; i < pokemon.stats.size(); i++){
            //System.debug(pokemon.stats[i].base_stat);
            //System.debug(pokemon.stats[i].stat.name);
           // }
            //System.debug(pokemon.abilities[0].ability.name);
//System.debug(pokemon.abilities[1].ability.name);

//System.debug(pokemon.sprites.front_default);
//System.debug(pokemon.name);
//System.debug(pokemon.weight);

List<String> movess = new List<String>();
System.debug(movess);
for(integer i = 1; i < pokemon.moves.size(); i++){
//for(integer i = 0; i < 4; i++){
//System.debug(pokemon.moves[i].move.name);
//movess = movess + ';' + (pokemon.moves[i].move.name);     
movess.add(pokemon.moves[i].move.name);
}
System.debug(movess);


}
        */

    @AuraEnabled
    public static String GetMovimiento(Integer id) {

        Http http = new Http();  
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+id);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');

        HttpResponse response = http.send(request);

        if(response.getStatusCode() != 200 && response.getbody() != null){
            throw new CalloutException('Error : '+response.getBody());
        }
        return response.getBody();
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
            throw new CalloutException('Error : '+response.getBody());
        }
        //JSON2ApexHabilidad habP = JSON2ApexHabilidad.parse(response.getBody());
        //Habilidad__c habObj = new Habilidad__c();
		//habObj.ExtId__c = habP.id;
        //habObj.Efecto__c = habP.effect_entries[1].short_effect;
        //habObj.Nombre__c = habP.name.capitalize();
        //habObj.Name = habP.name.capitalize();
        //String query = 'Select Id, ExtId__c, Efecto__c, Nombre__c, Name from Habilidad__c';
        //List<Habilidad__c> habList = database.query();
        return response.getBody();
    }
   
//---------------------PRUEBA--------------------------------------------
    // @AuraEnabled
    // public static Map<String, Object> GetMovimientoObject(Integer id) {
    //     String respuesta= null;

    //     // Clase HTTP 
    //     // realizar como tal la llamada y recibir la respuesta
    //     Http http = new Http(); 
    //     // Clase HTTPRquest
    //     // arma el metodo de llamada, especificamos : endpoint, metodo, header 
    //     HttpRequest request = new HttpRequest();
    //     request.setEndpoint('https://pokeapi.co/api/v2/move/'+id);
    //     request.setMethod('GET');
    //     request.setHeader('Content-Type', 'application/json');
    //     request.setHeader('Accept', 'application/json');
    //     // Clase HTTPResponse 
    //     // se encarga de guardar la resp
    //     HttpResponse response = http.send(request);

    //     if(response.getStatusCode() != 200 && response.getbody() != null){
    //         throw new CalloutException('Error : '+response.getBody());
    //     }
    //     Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    //     //System.debug(results);
    //     //System.debug(JSON2Apex(response.getBody()));
    //     //System.debug(JSON2ApexPokemon.parse(response.getBody()));
    //     return results;
        
    // }

    /*
Map<String, Object> movimiento = PokeAPIUtils.GetMovimientoObject(36);
System.debug(movimiento.get('name'));
System.debug(movimiento.get('accuracy'));

Map<String, Object> target =(Map<String, Object>) movimiento.get('target');
System.debug(target.get('name'));

    */
}