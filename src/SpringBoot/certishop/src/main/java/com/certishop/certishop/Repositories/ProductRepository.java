package com.certishop.certishop.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.certishop.certishop.Entities.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {

}