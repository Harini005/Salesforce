import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    connectedCallback() {
        console.log('Hello World');
    }
}