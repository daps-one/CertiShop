package com.certishop.certishop.Entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "Franchise")
public class Franchise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FranchiseId", nullable = false)
    private Integer franchiseId;

    @Column(name = "Description", nullable = false)
    private String description;

    @OneToMany(mappedBy = "franchise", cascade = CascadeType.ALL)
    private Set<Transactions> transactions = new HashSet<Transactions>();

    public Franchise() { 
    }

    public Franchise(String description) {
        this.description = description;
    }

    public int getFranchiseId() {
        return this.franchiseId;
    }

    public String getDescription() {
        return this.description;
    }

    public Set<Transactions> getTransactions() {
        return transactions;
    }

    public void setTransactions(Set<Transactions> transactions) {
        this.transactions = transactions;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}