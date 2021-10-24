package com.certishop.certishop.Entities;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "TransactionDetail")
public class TransactionDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TransactionDetailId", nullable = false)
    private Integer transactionDetailId;

    // @Column(name = "TransactionId", nullable = false)
    // private Integer transactionId;

    // @Column(name = "ProductId", nullable = false)
    // private Integer productId;

    @ManyToOne
    @JoinColumn(name = "TransactionId", nullable = false)
    private Transactions transactions;

    @ManyToOne
    @JoinColumn(name = "ProductId", nullable = false)
    private Product product;

    @NotNull
    @Column(name = "Amount", nullable = false)
    private Integer amount;

    @Column(name = "UnitPrice", nullable = false)
    private Integer unitPrice;

    @Column(name = "TotalPrice", nullable = false)
    private Integer totalPrice;

    public TransactionDetail() {
    }

    public TransactionDetail(Integer amount, Integer unitPrice, Integer totalPrice, Transactions transactions,
            Product product) {
        this.amount = amount;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.transactions = transactions;
        this.product = product;
    }

    public Integer getTransactionDetailId() {
        return transactionDetailId;
    }

    public Integer getAmount() {
        return amount;
    }

    public Transactions getTransactions() {
        return transactions;
    }

    public void setTransactions(Transactions transaction) {
        this.transactions = transaction;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Integer unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }
}
