import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { SERVICES_URL } from './route.providers'
import { Product } from '../models/Product.interface'
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  private PRODUCTS_URL = SERVICES_URL.urlProduct + '/products';
  private ADD_PRODUCT_URL = this.PRODUCTS_URL + '/addToCart';

  constructor(private http: HttpClient) { }

  getProducts(): Observable<Product[]> {
    return this.http.get<Product[]>(this.PRODUCTS_URL);
  }

  getProduct(productId: number): Observable<Product> {
    return this.http.get<Product>(this.PRODUCTS_URL + '/' + productId);
  }

  addProductToCart(productId: number) : Observable<Product> {
    return this.http.get<Product>(this.ADD_PRODUCT_URL +'/' + productId);
  }
}
