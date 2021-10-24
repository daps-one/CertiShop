import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { SERVICES_URL } from './route.providers'
import { Observable } from 'rxjs';
import { Franchise } from '../models/Franchise.interface';
import { Transaction } from '../models/Transaction.interface';

@Injectable({
  providedIn: 'root'
})
export class TransactionService {

  private TRANSACTION_URL = SERVICES_URL.urlTransaction + '/addTransaction';

  constructor(private http: HttpClient) { }

  saveTransaction(transaction: Transaction): Observable<Response> {
    return this.http.post<Response>(this.TRANSACTION_URL, transaction, {

    });
  }
}
