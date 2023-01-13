import { LightningElement, wire } from 'lwc';
import getAllPokemons from '@salesforce/apex/PokemonController.getAllPokemons';
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';

export default class PokemonList extends LightningElement {
	//get all pokemons and render//
  	pokemons;
	error;
	connectedCallback() {
		this.loadPokemons();
	}
	loadPokemons() {
		getAllPokemons()
			.then(result => {
				this.pokemons = result;
			})
			.catch(error => {
				this.error = error;
			});
	}
	//get all pokemons and render//

	//searchPokemons
	// searchTerm = '';
	// @wire(searchPokemons, {searchTerm: '$searchTerm'})
	// pokemons;	
	
	// handleSearchTermChange(event) {
	// 	// Debouncing this method: do not update the reactive property as
	// 	// long as this function is being called within a delay of 300 ms.
	// 	// This is to avoid a very large number of Apex method calls.
	// 	window.clearTimeout(this.delayTimeout);
	// 	const searchTerm = event.target.value;
	// 	// eslint-disable-next-line @lwc/lwc/no-async-operation
	// 	this.delayTimeout = setTimeout(() => {
	// 		this.searchTerm = searchTerm;
	// 	}, 300);
	// }
	// get hasResults() {
	// 	return (this.pokemons.data.length > 0);
	// }
}