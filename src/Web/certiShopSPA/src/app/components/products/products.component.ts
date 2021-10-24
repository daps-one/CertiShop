import { Component, OnInit } from '@angular/core';
import { Title } from '@angular/platform-browser'
import { Product } from 'src/app/models/Product.interface';
import { DetailStorageService } from 'src/app/services/detailStorage.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent implements OnInit {

  products: Product[] = [];

  constructor(private titleService: Title, private productService: ProductService, private detailStorageService: DetailStorageService) {
    this.titleService.setTitle('CertiShop | Productos');
  }

  ngOnInit(): void {
    this.getProducts();
  }

  getProducts() {
    this.productService.getProducts().subscribe(products => {
      this.products = products;
    });
  }

  onAdd(productId: number) {
    this.productService.addProductToCart(productId).subscribe(product => {
      this.detailStorageService.addDetailStorage(product);
    });
  }
}
