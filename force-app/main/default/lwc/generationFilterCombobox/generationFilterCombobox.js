import { LightningElement } from 'lwc';

export default class GenerationFilterCombobox extends LightningElement {
  value = '-1';
  get options() {
    return [{ label: 'Todos', value: '-1' },
            { label: '1', value: '1' }, 
            { label: '2', value: '2' },
            { label: '3', value: '3' },
            { label: '4', value: '4' },
            { label: '5', value: '5' },
            { label: '6', value: '6' },
            { label: '7', value: '7' },
            { label: '8', value: '8' },
          ];
}

handleChange(event) {
  
  // console.log(event.target.value);
    const selectEvent = new CustomEvent('generationchange', {
        detail: event.target.value
    });
    this.dispatchEvent(selectEvent);
    // console.log(event.target.value);
    // return;
    //TODO: return the type selected to the list and find it
}
}