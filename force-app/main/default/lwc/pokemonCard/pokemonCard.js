import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PokemonCard extends NavigationMixin(LightningElement) {
  @api pokemon;
  handleOpenRecordClick(event){
    console.log(this.pokemon.Id);
		console.log(this.pokemon.Name);
		
		if(this.pokemon.Tipos__c.includes('Normal')){
			console.log(this.pokemon.Tipos__c);
		}
    this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: this.pokemon.Id,
				objectApiName: 'Pokemon__c',
				actionName: 'view',
			},
		});
  }

}