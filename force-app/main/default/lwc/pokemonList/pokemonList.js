import { LightningElement, wire } from 'lwc';
import getAllPokemons from '@salesforce/apex/PokemonController.getAllPokemons';
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';

export default class PokemonList extends LightningElement {
	//get all pokemons and render//
  // 	pokemons;
	// error;
	// connectedCallback() {
	// 	this.loadPokemons();
	// }
	// loadPokemons() {
	// 	getAllPokemons()
	// 		.then(result => {
	// 			this.pokemons = result;
	// 		})
	// 		.catch(error => {
	// 			this.error = error;
	// 		});	
	// }
	//get all pokemons and render//

	//searchPokemons
	searchTerm = '';
	type = '';
	generation = null;
	pokemons;
	@wire(searchPokemons, {searchTerm: '$searchTerm', type: '$type', generation: '$generation'})
	loadPokemons(result){
		this.pokemons = result;
		// if(result.data){
		// 	let filteredPokemons = [];
		// 	for (let record of result.data) {
		// 		// let type = Object.getKey('Tipos__c');
		// 		if(record.Tipos__c.contains(this.type)){
		// 			filteredPokemons.add(record);
		// 		}
				
		// 		console.log(record.Tipos__c);

		// 		// for (let val of valuesArray) {
		// 		// 		console.log('val is ' + val);
		// 		// 		// let strVal = String(val);

		// 		// 		// if (strVal) {

		// 		// 		// 		if (strVal.toLowerCase().includes(searchKey)) {
		// 		// 		// 				searchRecords.push(record);
		// 		// 		// 				break;
		// 		// 		// 		}
		// 		// 		 }
		// 		// }
		// }
		// console.log(filteredPokemons);
		// console.log(result.data.size);
		// console.log(Object.values(result[0].data));
		// console.log(result.data.getKey(0));
		// for(let item of result.data){
		// 	console.log(item.Name);
		// 	// if(tipos.includes('Normal')){
		// 	// 	console.log(pokemon.Name);
		// 	// }
		// }
		// pokemonsFiltered;
		// if(this.type != ''){
		// 	pokemonsFiltered = result.filter()
		// }
	
	};	
	
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.pokemons.data.length > 0);
	}
	handleTypeChange(event){
		this.type = event.detail;
		// this.type = event.detail;
		// console.log(this.type);
		// console.log(event.detail);
	}
	// filterByType(item, type){
	// 	return item.data.tipos__c.contains()
	// }
}