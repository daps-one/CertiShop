import { Injectable } from '@angular/core';
import { Product } from '../models/Product.interface'
import { TransactionDetail } from '../models/TransactionDetail.interface';

@Injectable({
    providedIn: 'root'
})
export class DetailStorageService {

    private ITEM_DETAILS = 'details';

    addDetailStorage(product: Product) {
        const details = this.getDetailsStorage();
        const index = details.findIndex(value => value.product.productId == product.productId);
        if (index == -1) {
            details.push({
                amount: 1,
                product,
                unitPrice: product.unitPrice,
                totalPrice: product.unitPrice
            })
        } else {
            details[index].amount++;
            details[index].unitPrice = product.unitPrice;
            details[index].totalPrice = details[index].amount * product.unitPrice;
        }
        localStorage.setItem(this.ITEM_DETAILS, JSON.stringify(details));
    }

    clearStorage() {
        localStorage.removeItem(this.ITEM_DETAILS);
    }

    removeDetailStorage(productId: number) {
        const details = this.getDetailsStorage();
        const index = details.findIndex(value => value.product.productId == productId);
        if (index > -1) {
            if (details[index].amount > 1) {
                details[index].amount--;
                details[index].totalPrice = details[index].amount * details[index].unitPrice;
            } else {
                details.splice(index, 1);
            }
        }
        localStorage.setItem(this.ITEM_DETAILS, JSON.stringify(details));
    }

    getDetailsStorage(): TransactionDetail[] {
        const storage = localStorage.getItem(this.ITEM_DETAILS);
        const json = JSON.parse(storage == null || storage == '' ? '[]' : storage);
        return json;
    }
}
