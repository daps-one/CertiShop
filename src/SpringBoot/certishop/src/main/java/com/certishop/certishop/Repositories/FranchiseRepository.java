package com.certishop.certishop.Repositories;

import com.certishop.certishop.Entities.Franchise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FranchiseRepository extends JpaRepository<Franchise, Integer> {
    
}
