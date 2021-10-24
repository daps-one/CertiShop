import { Product } from "./Product.interface";

export interface TransactionDetail {
    transactionDetailId?: number;
    transactionId?: number;
    product: Product;
    amount: number;
    unitPrice: number;
    totalPrice: number;
}