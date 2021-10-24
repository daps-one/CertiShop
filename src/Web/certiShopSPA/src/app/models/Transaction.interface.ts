import { Franchise } from "./Franchise.interface";
import { User } from "./User.interface";

export interface Transaction {
    transactionId?: number;
    user: User;
    franchise: Franchise;
    creditCardNumber: string;
    expirationDate: Date;
    fees: number;
    totalPrice?: number;
    observations: string;
}