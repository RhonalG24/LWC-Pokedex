import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PokemonCard extends NavigationMixin(LightningElement) {
  @api pokemon;
  handleOpenRecordClick(event){
    console.log(this.pokemon.Id);
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