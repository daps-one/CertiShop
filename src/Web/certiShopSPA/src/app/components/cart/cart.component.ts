import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatSnackBarHorizontalPosition, MatSnackBarVerticalPosition } from '@angular/material/snack-bar/snack-bar-config';
import { Title } from '@angular/platform-browser';
import { Franchise } from 'src/app/models/Franchise.interface';
import { Response } from 'src/app/models/Response.interface';
import { TransactionDetail } from 'src/app/models/TransactionDetail.interface';
import { DetailStorageService } from 'src/app/services/detailStorage.service';
import { FranchiseService } from 'src/app/services/franchise.service';
import { ProductService } from 'src/app/services/product.service';
import { TransactionService } from 'src/app/services/transaction.service';
import { Router, ActivatedRoute, ParamMap } from '@angular/router';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.scss']
})
export class CartComponent implements OnInit {

  details: TransactionDetail[] = [];
  total: number = 0;
  displayedColumns: string[] = ['name', 'totalPrice', 'amount', 'actions'];
  franchises: Franchise[] = [];
  options: FormGroup;
  identificationControl = new FormControl('', [Validators.required]);
  namesControl = new FormControl('', Validators.required);
  surnamesControl = new FormControl('', Validators.required);
  emailControl = new FormControl('', [Validators.required, Validators.email]);
  franchiseControl = new FormControl(0, Validators.required);
  creditCardControl = new FormControl(0, Validators.required);
  dateControl = new FormControl('', Validators.required);
  feesControl = new FormControl(0, Validators.required);

  horizontalPosition: MatSnackBarHorizontalPosition = 'right';
  verticalPosition: MatSnackBarVerticalPosition = 'bottom';

  constructor(private titleService: Title, private detailStorageService: DetailStorageService,
    private productService: ProductService, private franchiseService: FranchiseService, fb: FormBuilder,
    private transactionService: TransactionService, private _snackBar: MatSnackBar, private router: Router) {
    this.titleService.setTitle('CertiShop | Carrito');
    this.options = fb.group({
      identificationControl: this.identificationControl,
      namesControl: this.namesControl,
      surnamesControl: this.surnamesControl,
      emailControl: this.emailControl,
      franchiseControl: this.franchiseControl,
      creditCardControl: this.creditCardControl,
      dateControl: this.dateControl,
      feesControl: this.feesControl,
    });
  }

  onSubmit() {
    if (this.options.valid) {
      this.transactionService.saveTransaction({
        creditCardNumber: this.options.get('creditCardControl')?.value,
        expirationDate: new Date(this.options.get('dateControl')?.value + '-1'),
        fees: this.options.get('feesControl')?.value,
        user: {
          identificationNumber: this.options.get('identificationControl')?.value,
          names: this.options.get('namesControl')?.value,
          surnames: this.options.get('surnamesControl')?.value,
          email: this.options.get('emailControl')?.value
        },
        franchise: {
          franchiseId: this.options.get('franchiseControl')?.value,
          description: undefined
        },
        observations: ''
      }).subscribe((result: Response) => {
        this.openSnackBar(result);
        if (result.status == 1) {
          setTimeout(() => {
            this.detailStorageService.clearStorage();
            this.router.navigateByUrl('/');
          }, 1000);
        }
      })
    } else {
      this.openSnackBar({
        description: 'Formulario incompleto',
        status: 0,
        modelId: 0
      });
    }
  }

  ngOnInit(): void {
    this.getDetails();
    this.getFranchises();
  }

  openSnackBar(response : Response) {
    const message = response.status == 1 ? `${response.description} (transacción ${response.modelId})` : response.description;
    this._snackBar.open(message, 'Cerrar', {
      horizontalPosition: this.horizontalPosition,
      verticalPosition: this.verticalPosition,
      panelClass: 'mat-snack-bar-color-' + response.status
    });
  }


  getDetails() {
    this.details = this.detailStorageService.getDetailsStorage();
    this.setTotal()
  }

  getFranchises() {
    this.franchiseService.getFranchises().subscribe(franchises => {
      this.franchises = franchises;
    });
  }

  toogleDetail(value: number, productId: number) {
    console.log(value)
    if (value == 1) {
      this.productService.addProductToCart(productId).subscribe(product => {
        this.detailStorageService.addDetailStorage(product);
        this.details = this.detailStorageService.getDetailsStorage();
        this.setTotal();
      });
    }
    if (value == -1) {
      this.detailStorageService.removeDetailStorage(productId);
      this.details = this.detailStorageService.getDetailsStorage();
      this.setTotal();
    }
  }

  setTotal() {
    let tempTotal = 0;
    this.details.forEach(detail => {
      tempTotal += detail.totalPrice;
    });
    this.total = tempTotal;
  }
}
