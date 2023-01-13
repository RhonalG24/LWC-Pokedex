import { LightningElement, wire } from 'lwc';
import getAllPokemons from '@salesforce/apex/PokemonController.getAllPokemons';
import searchPokemons from '@salesforce/apex/PokemonController.searchPokemons';
import NAME_FIELD from '@salesforce/schema/Pokemon__c.Name';
import ALTURA_FIELD from '@salesforce/schema/Pokemon__c.Altura__c';
import ATAQUE_FIELD from '@salesforce/schema/Pokemon__c.Ataque__c';
import DEFENSA_FIELD from '@salesforce/schema/Pokemon__c.Defensa__c';
import EXT_ID_FIELD from '@salesforce/schema/Pokemon__c.ExtId__c';
import GENERACION_FIELD from '@salesforce/schema/Pokemon__c.Generacion__c';
import IMAGEN_FIELD from '@salesforce/schema/Pokemon__c.Imagen__c';
// import HABILIDAD_FIELD from '@salesforce/schema/Pokemon__c.Habilidad__c';
import HABILIDAD_FIELD from '@salesforce/schema/Habilidad__c.Name';

import PESO_FIELD from '@salesforce/schema/Pokemon__c.Peso__c';
import SLOT_1_FIELD from '@salesforce/schema/Pokemon__c.Slot1__c';
import SLOT_2_FIELD from '@salesforce/schema/Pokemon__c.Slot2__c';
import SLOT_3_FIELD from '@salesforce/schema/Pokemon__c.Slot3__c';
import SLOT_4_FIELD from '@salesforce/schema/Pokemon__c.Slot4__c';
// import SLOT_1_FIELD from '@salesforce/schema/Movimiento__c.Name';
// import SLOT_2_FIELD from '@salesforce/schema/Movimiento__c.Name';
// import SLOT_3_FIELD from '@salesforce/schema/Movimiento__c.Name';
// import SLOT_4_FIELD from '@salesforce/schema/Movimiento__c.Name';
import TIPOS_FIELD from '@salesforce/schema/Pokemon__c.Tipos__c';
import VELOCIDAD_FIELD from '@salesforce/schema/Pokemon__c.Velocidad__c';
import VIDA_FIELD from '@salesforce/schema/Pokemon__c.Vida__c';

const COLUMNS = [
    { label: 'External ID', fieldName: EXT_ID_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Imagen', fieldName: IMAGEN_FIELD.fieldApiName, type: 'image', sortable: true },
    { label: 'Nombre', fieldName: NAME_FIELD.fieldApiName, type: 'text', sortable: true },
    { label: 'Tipos', fieldName: TIPOS_FIELD.fieldApiName, type: 'Picklist', sortable: true },
    { label: 'Generacion', fieldName: GENERACION_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Vida', fieldName: VIDA_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Altura', fieldName: ALTURA_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Ataque', fieldName: ATAQUE_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Defensa', fieldName: DEFENSA_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Velocidad', fieldName: VELOCIDAD_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Peso', fieldName: PESO_FIELD.fieldApiName, type: 'number', sortable: true },
    { label: 'Habilidad', fieldName: HABILIDAD_FIELD.fieldApiName, type: 'text', sortable: true },
    { label: 'Movimiento 1', fieldName: SLOT_1_FIELD.fieldApiName, type: 'text', sortable: true },
    { label: 'Movimiento 2', fieldName: SLOT_2_FIELD.fieldApiName, type: 'text', sortable: true },
    { label: 'Movimiento 3', fieldName: SLOT_3_FIELD.fieldApiName, type: 'text', sortable: true },
    { label: 'Movimiento 4', fieldName: SLOT_4_FIELD.fieldApiName, type: 'text', sortable: true },
];

export default class PokemonListRow extends LightningElement {
    columns = COLUMNS;
    @wire(getAllPokemons)
    pokemon/*(result) {
        if (result.data) {
            this.data = result.data.map(row=>{
                return{...row, Habilidad__c: row.Habilidad__r.Name, Slot1__c: row.Slot1__r.Name, Slot2__c: row.Slot2__r.Name, Slot3__c: row.Slot3__r.Name, Slot4__c: row.Slot4__r.Name}
            })
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }*/;

    handleKeyWordChange (event) {
        this.pageNumber = 1; 
        this.keyword = event.target.value; 
        // eslint-disable-next-line no-console
        console.log("Search Keyword:" + this.keyword);
        this.handlePageChange();
    }
}