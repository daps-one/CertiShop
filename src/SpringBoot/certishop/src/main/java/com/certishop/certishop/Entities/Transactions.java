package com.certishop.certishop.Entities;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.*;
import org.hibernate.validator.constraints.CreditCardNumber;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "Transactions")
public class Transactions {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TransactionId", nullable = false)
    private Integer transactionId;

    // @Column(name = "UserId", nullable = false)
    // private Integer userId;

    // @NotNull
    @ManyToOne
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    // @Column(name = "FranchiseId", nullable = false)
    // private Integer franchiseId;

    // @NotNull
    @ManyToOne
    @JoinColumn(name = "FranchiseId", nullable = false)
    private Franchise franchise;

    @NotNull
    @CreditCardNumber
    @Length(min = 16, max = 16)
    @Column(name = "creditCardNumber", length = 16, nullable = false)
    private String creditCardNumber;

    @Temporal(TemporalType.DATE)
    @Column(name = "ExpirationDate", nullable = false)
    private Date expirationDate;

    @NotNull
    @Max(36)
    @Column(name = "Fees", nullable = false)
    private Integer fees;

    @Column(name = "TotalPrice", nullable = false)
    private Integer totalPrice;

    @Column(name = "Observations", length = 1024, nullable = true)
    private String observations;

    @Temporal(TemporalType.DATE)
    @Column(name = "TransactionDate", nullable = false)
    private Date transactionDate;

    @NotNull
    @OneToMany(mappedBy = "transactions", cascade = CascadeType.ALL)
    private Set<TransactionDetail> transactionDetails = new HashSet<TransactionDetail>();

    public Transactions() {
    }

    public Transactions(String creditCardNumber, Date expirationDate, Integer fees, Integer totalPrice,
            String observations, Date transactionDate, Franchise franchise, User user) {
        this.creditCardNumber = creditCardNumber;
        this.expirationDate = expirationDate;
        this.fees = fees;
        this.totalPrice = totalPrice;
        this.observations = observations;
        this.transactionDate = transactionDate;
        this.franchise = franchise;
        this.user = user;
    }

    public Integer getTransactionId() {
        return transactionId;
    }

    public void setTransactionDetails(Set<TransactionDetail> transactions) {
        this.transactionDetails = transactions;
    }

    public Set<TransactionDetail> getTransactionsDetails() {
        return transactionDetails;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Franchise getFranchise() {
        return franchise;
    }

    public void setFranchise(Franchise franchise) {
        this.franchise = franchise;
    }

    public String getcreditCardNumber() {
        return creditCardNumber;
    }

    public void setcreditCardNumber(String creditCardNumber) {
        this.creditCardNumber = creditCardNumber;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public Integer getFees() {
        return fees;
    }

    public void setFees(Integer fees) {
        this.fees = fees;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getObservations() {
        return observations;
    }

    public void setObservations(String observations) {
        this.observations = observations;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
}
