import { LightningElement,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import TYPES from '@salesforce/schema/Pokemon__c.Tipos__c';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import POKEMON_OBJECT from '@salesforce/schema/Pokemon__c';

export default class TypeFilterCombobox extends LightningElement {
    @wire(getObjectInfo, { objectApiName: POKEMON_OBJECT })
    pokemonInfo;

    @wire(getPicklistValues,
        {
            recordTypeId: '$pokemonInfo.data.defaultRecordTypeId',
            fieldApiName: TYPES
        }
    )
    typesValues;

    handleChange(event){
        console.log(event.target.value);
        return;
        //TODO: return the type selected to the list and find it 
    }
}