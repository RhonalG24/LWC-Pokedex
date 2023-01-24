import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PokemonCard extends NavigationMixin(LightningElement) {
	@api pokemon;
	renderedCallback() {
		// this.template.querySelector('.exclusivity-error[data-recid="Jupitar"]')?.classList.remove('hide-error');
		this.setBackground();
		
	// 	card = this.template.querySelector('lightning-card'); // <div>First</div>
	// 	console.log(card);
	}
	handleOpenRecordClick(event){
		this[NavigationMixin.Navigate]({
				type: 'standard__recordPage',
				attributes: {
					recordId: this.pokemon.Id,
					objectApiName: 'Pokemon__c',
					actionName: 'view',
				},
			});
	}
	setBackground(){
		let string = this.pokemon.Tipos__c.toLowerCase();
		let type = '';
		// console.log(string.includes(';'));
		if(string.includes(';') ){
			// console.log(string.length());
			type = string.substring(string.lastIndexOf(';')+1, string.length);
			// type = string.lastIndexOf(';');
		} else{
			type = string;
		}
		// this.card = this.template.querySelector('.pokemon-card');
		this.template.querySelector('.pokemon-card').classList.add(`${type}-background`);
			
		console.log(type);
		// refreshApex(this.pokemon);
		// console.log(type);
		// if(this.pokemon.Tipos__c.contains(';')){

		// }
	}

}