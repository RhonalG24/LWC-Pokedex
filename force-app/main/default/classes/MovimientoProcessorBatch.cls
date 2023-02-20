public with sharing class MovimientoProcessorBatch implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
	public Integer recordsProcessed = 0;
	// Integer TOTAL_POKEMONS = 898;
	
	//Integer TOTAL_HABILIDADES = 267;
	Integer TOTAL_MOVIMIENTOS = 826;
	
	public Iterable<Integer> start(Database.BatchableContext bc) {
		
		List<Integer> listToReturn = new List<Integer>();
		if(!Test.isRunningTest()){
			for(Integer i = 1; i <= TOTAL_MOVIMIENTOS; i++){
				listToReturn.add(i);
			}
		}else {
			listToReturn.add(1);
		}
		return listToReturn;
		
	}
	public void execute(Database.BatchableContext bc, List<Integer> intList){
		List<Movimiento__c> movimientosList = new List<Movimiento__c>();
		
		for(Integer index: intList){
			try{
				String response = GetMovimiento(index);
				Movimiento__c movimiento = getMappedMovimiento(response);
				movimientosList.add(movimiento);
				recordsProcessed++;
			}catch(Exception e){
				// System.debug(e.getMessage());
				throw new CalloutException(e.getMessage());
		}
		}
		try {
			upsert movimientosList;
		} catch(Exception e) {
			System.debug(e);
		}
		
		return;
	}
	
	
	public void finish(Database.BatchableContext bc){
		System.debug(recordsProcessed + ' records processed!');
		if(!Test.isRunningTest()){
			Database.executeBatch(new PokemonProcessorBatch(), 1);
		}
	}
	
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
			System.debug(id);
			throw new CalloutException('Error : '+response.getBody());
		}
		return response.getBody();
	}
	
	public static Movimiento__c getMappedMovimiento(String JSONToMap) {
		Movimiento__c movimientoMapped = new Movimiento__c();
		
		JSON2ApexMovimiento movimientoParsed = JSON2ApexMovimiento.parse(JSONToMap);
		try {
			movimientoMapped.ExtId__c = movimientoParsed.id;
			movimientoMapped.Nombre__c = movimientoParsed.name.capitalize();
			movimientoMapped.Name = movimientoParsed.name.capitalize();	
			for(Integer i = 0; i < movimientoParsed.effect_entries.size(); i++){
				if(movimientoParsed.effect_entries[i].language.name == 'en'){
					movimientoMapped.Efecto__c = movimientoParsed.effect_entries[i].short_effect;
					break;
				}
		}
		movimientoMapped.Chance_de_Efecto__c = movimientoParsed.effect_chance;
		movimientoMapped.Objetivo__c = movimientoParsed.target.name;
			movimientoMapped.Poder__c = movimientoParsed.power;
			movimientoMapped.Pp__c = movimientoParsed.pp;
			movimientoMapped.Prioridad__c = movimientoParsed.priority;
			movimientoMapped.Punteria__c = movimientoParsed.accuracy;
			movimientoMapped.Tipo__c = movimientoParsed.type.name;

		} catch(Exception e) {
			System.debug(e+'Error mapping');
		}
		
		return movimientoMapped;
		
	}
	
	// public static void deleteAllMovimiento(){
	// 	List<Movimiento__c> habLst = [SELECT id FROM Movimiento__c];
	// 	delete habLst;
	// 	return;
	// }
}