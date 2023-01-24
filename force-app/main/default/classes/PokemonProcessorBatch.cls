public with sharing class PokemonProcessorBatch implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
	public Integer recordsProcessed = 0;
	public Integer TOTAL_POKEMONS = 898;
    //public Integer TOTAL_POKEMONS = 10;

	
	//Integer TOTAL_HABILIDADES = 267;
	//Integer TOTAL_MOVIMIENTOS = 826;
	
	public Iterable<Integer> start(Database.BatchableContext bc) {
		
		List<Integer> listToReturn = new List<Integer>();

		if(!Test.isRunningTest()){
            for(Integer i = 1; i <= TOTAL_POKEMONS; i++){
                listToReturn.add(i);
            }
        }else {
            listToReturn.add(1);
        }

		return listToReturn;
		
	}
	public void execute(Database.BatchableContext bc, List<Integer> intList){
		List<Pokemon__c> pokemonList = new List<Pokemon__c>();
		
		for(Integer index: intList){
            try{
                String response = GetPokemon(index);
                Pokemon__c pokemon = getMappedPokemon(response);
                pokemonList.add(pokemon);
                recordsProcessed++;
            }catch(Exception e){
                throw new CalloutException(e.getMessage());
            }
		}
        
		try {
			upsert pokemonList;
		} catch(Exception e) {
			System.debug(e);
		}
		
		return;
	}
	
	
	public void finish(Database.BatchableContext bc){
		System.debug(recordsProcessed + ' records processed!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug(bc.getJobId());
		
	}
	
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

	public static Pokemon__c getMappedPokemon(String JSONToMap) {
		Pokemon__c pokemonMapped = new Pokemon__c();
        Integer MAX_MOVES = 4; //4 slots
		
		JSON2ApexPokemon pokemonParsed = JSON2ApexPokemon.parse(JSONToMap);
		try {
            Double heightInMeters = Double.valueOf(pokemonParsed.height)/10;
            pokemonMapped.Altura__c = String.valueOf(heightInMeters) + ' mts.';        
            pokemonMapped.Vida__c = pokemonParsed.stats[0].base_stat;
            pokemonMapped.Ataque__c = pokemonParsed.stats[1].base_stat;
            pokemonMapped.Defensa__c = pokemonParsed.stats[2].base_stat;
            pokemonMapped.Velocidad__c = pokemonParsed.stats[5].base_stat;
            pokemonMapped.ExtId__c = pokemonParsed.id;
            pokemonMapped.Nombre__c = (pokemonParsed.name).capitalize();
            pokemonMapped.Name = (pokemonParsed.name).capitalize();
            Double weightInKg = Double.valueOf(pokemonParsed.weight)/10;
            pokemonMapped.Peso__c = String.valueOf(weightInKg) + ' kg.';
            //set Image
            if(pokemonParsed.sprites.other.dream_world.front_default == null){
                pokemonMapped.Imagen__c = pokemonParsed.sprites.front_default;
            }else{
                pokemonMapped.Imagen__c = pokemonParsed.sprites.other.dream_world.front_default;
            }
            
            //set ability
            String abilityURL = '';
            if(pokemonParsed.abilities.size() > 1){
                Integer abilityIndex = Integer.valueOf(Math.random() * pokemonParsed.abilities.size());
                abilityURL = pokemonParsed.abilities[abilityIndex].ability.url; 
            }else{
                abilityURL = pokemonParsed.abilities[0].ability.url; 
            }
            Integer abilityId = getAbilityIdFromURL(abilityURL);
            Habilidad__c abilityObject = [SELECT Id FROM Habilidad__c WHERE ExtId__c =: abilityId];
            pokemonMapped.Habilidad__c = abilityObject.Id; //debo usar el Id de la habilidad
            //set ability
            
            //get available moves
            Integer availableMoves = pokemonParsed.moves.size();
            Integer cantMoves = (availableMoves <= MAX_MOVES) ? availableMoves : MAX_MOVES;
            List<Integer> movesTaken = new List<Integer>();
            List<Integer> movesToSet = new List<Integer>();
            for(Integer i = 0; i < cantMoves; i++){ //get random moves from available list
                Integer index = Integer.valueof((Math.random() * availableMoves));
                while(movesTaken.contains(index)){
                    index = Integer.valueof((Math.random() * availableMoves));
                }
                movesTaken.add(index);
                
                //get the id from the url
                String url = pokemonParsed.moves[index].move.url;
                Integer moveId = getMoveIdFromURL(url);
                //save the move id
                movesToSet.add(moveId);
            }
            
            List<Movimiento__c> moveObjectList = [SELECT Id FROM Movimiento__c WHERE ExtId__c IN: movesToSet];
            //set available moves//
            for(Integer i = 0; i < moveObjectList.size();i++){
                switch on i {
                    when 0 {
                        pokemonMapped.Slot1__c = moveObjectList[0].Id; //debo usar el Id del movimiento
                    }
                    when 1 {
                        pokemonMapped.Slot2__c = moveObjectList[1].Id;
                    }
                    when 2 {
                        pokemonMapped.Slot3__c = moveObjectList[2].Id;
                    }
                    when else {
                        pokemonMapped.Slot4__c = moveObjectList[3].Id;
                        
                    }
                }
            }
            //set available moves//

            //set the pokemon types
            for(Integer i = 0; i < pokemonParsed.types.size(); i++){
                //String values = values + ';' + pokemonParsed.types[i].type.name;
                if(i == 0){
                    pokemonMapped.Tipos__c = pokemonParsed.types[i].type.name.capitalize() + ';';
                    continue;
                }
                pokemonMapped.Tipos__c += pokemonParsed.types[i].type.name.capitalize() + ';';				
            }
		} catch(Exception e) {
            System.debug(e+'Error mapping');
		}
		
		return pokemonMapped;
		
	}

    public static Integer getMoveIdFromURL(String url){
        Integer lastSlash = url.lastIndexOf('/');
        String moveId = url.substring(31, lastSlash); //https://pokeapi.co/api/v2/move/806/
        Integer id = Integer.valueOf(moveId);
        return id;
    }
    public static Integer getAbilityIdFromURL(String url){
        Integer lastSlash = url.lastIndexOf('/');
        String abilityId = url.substring(34, lastSlash); //https://pokeapi.co/api/v2/ability/10/
        Integer id = Integer.valueOf(abilityId);
        return id;
    }
	
	// public static void deleteAllPokemon(){
	// 	List<Pokemon__c> pokeLst = [SELECT id FROM Pokemon__c];
	// 	delete pokeLst;
	// 	return;
	// }
}