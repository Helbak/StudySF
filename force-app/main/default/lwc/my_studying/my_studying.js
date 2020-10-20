import { LightningElement, api } from 'lwc';
import IMAGES from "@salesforce/resourceUrl/collection";
import Id from '@salesforce/user/Id';
import propertyName from '@salesforce/community/Id';
import formFactorPropertyName from '@salesforce/client/formFactor'

export default class My_studying extends LightningElement {
    @api nameComponent;
    @api recordId;
    @api objectApiName;
    myName = "Vas";
   
  
    form = formFactorPropertyName;
    communityName = propertyName;
    userId = Id;
    she = IMAGES + '/she.png';

}