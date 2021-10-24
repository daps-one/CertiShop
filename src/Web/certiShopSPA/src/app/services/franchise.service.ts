import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { SERVICES_URL } from './route.providers'
import { Observable } from 'rxjs';
import { Franchise } from '../models/Franchise.interface';

@Injectable({
  providedIn: 'root'
})
export class FranchiseService {

  private FRANCHISES_URL = SERVICES_URL.urlProduct + '/franchises';

  constructor(private http: HttpClient) { }

  getFranchises(): Observable<Franchise[]> {
    return this.http.get<Franchise[]>(this.FRANCHISES_URL);
  }
}
