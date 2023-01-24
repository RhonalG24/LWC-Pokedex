import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
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
	generation = -1;
	pokemons;
	visiblePokemons;
	error;
	isLoading = true;

	totalPokemons = 0;
	@wire(searchPokemons, {searchTerm: '$searchTerm', type: '$type', generation: '$generation'})
	loadPokemons({error, data}){
		this.isLoading = true;
		if(data){

			if(this.pokemons != data){
				this.pokemons = data;
			}

			if(this.pokemons){
				// console.log(this.pokemons);
				// console.log(this.pokemons.length);
				this.totalPokemons = this.pokemons.length;
			}
			return refreshApex(this.visiblePokemons);
		}
		if(error){
			this.error = error;
		}
	};	
	
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.isLoading = true;
			this.searchTerm = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.pokemons.length > 0);
	}
	handleTypeChange(event){
		this.isLoading = true;
		this.type = event.detail;
	}
	handleGenerationChange(event){
		this.isLoading = true;
		this.generation = event.detail;

	}

	updatePokemonsHandler(event){
		this.isLoading = true;
        this.visiblePokemons=[...event.detail.records]
		this.isLoading = false;
        // console.log(event.detail.records)
    }

}