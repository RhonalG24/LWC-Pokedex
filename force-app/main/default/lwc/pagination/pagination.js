import { LightningElement, api, track } from 'lwc';

export default class Pagination extends LightningElement {
    currentPage = 1;
    @track totalRecords;
    @api recordSize = 10;
    totalPage = 0;
    visibleRecords;
    value = '1';
    options;
    get records(){
        return this.visibleRecords
    }
    @api 
    set records(data){
        if(data){ 
            this.totalRecords = data;
            this.recordSize = Number(this.recordSize);
            this.totalPage = Math.ceil(data.length/this.recordSize);
            this.currentPage = 1;
            this.value = '1';
            this.options = [];
            for(let i = 1; i <= this.totalPage; i++){
                this.options.push({label: i.toString(), value: i.toString()});
            }
            this.updateRecords();
        }
    }

    get disablePrevious(){ 
        return this.currentPage<=1;
    }
    get disableNext(){ 
        return this.currentPage>=this.totalPage;
    }
    previousHandler(){ 
        if(this.currentPage>1){
            this.currentPage = this.currentPage-1;
            this.updateRecords();
        }
    }
    nextHandler(){
        if(this.currentPage < this.totalPage){
            this.currentPage = this.currentPage+1;
            this.updateRecords();
        }
    }
    updateRecords(){ 
        const start = (this.currentPage-1)*this.recordSize;
        const end = this.recordSize*this.currentPage;
        this.visibleRecords = this.totalRecords.slice(start, end);
        this.value = this.currentPage.toString();
        this.dispatchEvent(new CustomEvent('update',{ 
            detail:{ 
                records:this.visibleRecords
            }
        }))
    }

    handleChange(event) {
        this.currentPage = event.target.value;
        this.updateRecords();
    
    }
}