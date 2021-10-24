package com.certishop.certishop.Entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "Product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductId", nullable = false)
    private Integer productId;

    @Column(name = "Name", length = 50, nullable = false)
    private String name;

    @Column(name = "Image", length = 1024, nullable = true)
    private String image;

    @Column(name = "UnitPrice", nullable = false)
    private Integer unitPrice;

    @Column(name = "Description", length = 1024, nullable = true)
    private String description;

    @Column(name = "Amount", nullable = false)
    private Integer amount;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private Set<TransactionDetail> transactions = new HashSet<TransactionDetail>();

    public Product() {
    }

    public Product(String name, String image, Integer unitPrice, String description, Integer amount) {
        this.name = name;
        this.image = image;
        this.unitPrice = unitPrice;
        this.description = description;
        this.amount = amount;
    }

    public int getProductId() {
        return this.productId;
    }

    public Set<TransactionDetail> getTransactions() {
        return transactions;
    }

    public void setTransactions(Set<TransactionDetail> transactions) {
        this.transactions = transactions;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return this.image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Integer getUnitPrice() {
        return this.unitPrice;
    }

    public void setUnitPrice(Integer unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getAmount() {
        return this.amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }
}