package com.certishop.certishop.Controllers;

import java.util.List;

import org.springframework.web.bind.annotation.*;
import com.certishop.certishop.Repositories.*;
import com.certishop.certishop.Entities.*;

@RestController
@RequestMapping("/api")
public class ProductController {
    private final ProductRepository productRepository;

    public ProductController(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @GetMapping("/products")
    public List<Product> getProducts() {
        return productRepository.findAll();
    }
}