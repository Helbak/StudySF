import { LightningElement, api, track } from 'lwc';
import getFieldSetArticle from "@salesforce/apex/AC_articleViewCtrl.getFieldSetArticle";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import IMAGES from "@salesforce/resourceUrl/images";


export default class Ac_articleView extends LightningElement {
  @api recordId;
  @track arrayArticles;
  @track fieldSetArrayArticles;
  fieldSetArray = [];

  iconChecked = IMAGES + "/iconChecked.png";
  iconUnchecked = IMAGES + "/iconUnchecked.png";

  styleListViewBlock = 'max-width:100%;display:flex;flex-direction:column;border-bottom:solid;border-bottom-width:0.5px;border-bottom-color:rgb(217,219,221);margin-top:1%;margin-bottom:1%;margin-left:4%;margin-right:3%;';
  styleListViewBlockTitle = 'width:100%;text-transform:uppercase;height:20px;font-size:16px;font-weight:700;margin-bottom:1%;';
  styleListViewBlockContent = 'width:100%;font-size:14px;min-height:18px;font-weight:400;margin-bottom:0.5%;word-wrap:break-word;';

  connectedCallback() {

    getFieldSetArticle({ articleId: this.recordId, status: 'Online' })
      .then((data) => {
        console.log('===', data)
        if (data === null) {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error",
              message: 'There are no any data',
              variant: 'error'
            })
          );
          this.fieldSetArray.push({ key: 'Error', value: 'Tehere are no any data' });
          this.fieldSetArrayArticles = this.fieldSetArray;
          return;
        }
        for (const property in data) {
          this.fieldSetArray.push({ key: property, value: data[property] });
        }
        this.fieldSetArrayArticles = this.fieldSetArray;
        this.pasteInnerHTML();
      })
      .catch((error) => {
        console.log(error);
      });
  }

  pasteInnerHTML() {
    let innerString = '';
    this.fieldSetArrayArticles.forEach(el => {
      if (typeof el.value === "boolean") {
        let imgCheckBox = '';
        el.value === true ? imgCheckBox = `<img src=${this.iconChecked} style="max-height:18px;" />` : imgCheckBox = `<img src=${this.iconUnchecked} style="max-height:18px;" />`;
        innerString = innerString + `<div class="list-view_block" style=${this.styleListViewBlock}><div class="list-view_block-title" style=${this.styleListViewBlockTitle}>${el.key}</div><div class="list-view_block-content" style=${this.styleListViewBlockContent}>${imgCheckBox}</div></div>`;
      }
      if (typeof el.value !== "boolean") {
        innerString = innerString + `<div class="list-view_block" style=${this.styleListViewBlock}><div class="list-view_block-title" style=${this.styleListViewBlockTitle}>${el.key}</div><div class="list-view_block-content" style=${this.styleListViewBlockContent}>${el.value}</div></div>`;
      }
    });
    this.template.querySelector('.list-view').innerHTML = innerString;
  }

}