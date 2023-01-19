import { LightningElement, wire } from 'lwc';
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

    get options() {
        return [{ label: 'Todos', value: '' }, ...this.typesValues.data.values];
    }

    handleChange(event) {
        const selectEvent = new CustomEvent('typechange', {
            detail: event.target.value
        });
        this.dispatchEvent(selectEvent);
        // console.log(event.target.value);
        // console.log(event.target.value);
        // return;

    }
}