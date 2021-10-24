package com.certishop.certishop.Entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "[User]")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserId", nullable = false)
    private Integer userId;

    @NotNull
    @Length(min = 10, max = 15)
    @Column(name = "IdentificationNumber", length = 15, nullable = false)
    private String identificationNumber;

    @NotNull
    @Length(max = 255)
    @Column(name = "Names", length = 255, nullable = false)
    private String names;

    @NotNull
    @Length(max = 255)
    @Column(name = "Surnames", length = 255, nullable = false)
    private String surnames;

    @NotNull
    @Email
    @Length(max = 255)
    @Column(name = "Email", length = 255, nullable = false)
    private String email;

    @Column(name = "Status", nullable = false)
    private Boolean status;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Transactions> transactions = new HashSet<Transactions>();

    public User() {
    }

    public User(String identificationNumber, String names, String surnames, String email, Boolean status) {
        this.identificationNumber = identificationNumber;
        this.names = names;
        this.surnames = surnames;
        this.email = email;
        this.status = status;
    }

    public Integer getUserId() {
        return userId;
    }

    public String getIdentificationNumber() {
        return identificationNumber;
    }

    public Set<Transactions> getTransactions() {
        return transactions;
    }

    public void setTransactions(Set<Transactions> transactions) {
        this.transactions = transactions;
    }

    public void setIdentificationNumber(String identificationNumber) {
        this.identificationNumber = identificationNumber;
    }

    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
    }

    public String getSurnames() {
        return surnames;
    }

    public void setSurnames(String surnames) {
        this.surnames = surnames;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
