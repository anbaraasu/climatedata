package com.javatpoint;  

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "account100")
public class Account {  
    @Id
    private int accountNumber;  
    private String owner;  
    private double balance;  
        //no-arg and parameterized constructor  
    public Account() {
    }
    public Account(int accountNumber, String owner, double balance) {
        this.accountNumber = accountNumber;
        this.owner = owner;
        this.balance = balance;
    }
        //getters and setters  
    public int getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }
    public String getOwner() {
        return owner;
    }
    public void setOwner(String owner) {
        this.owner = owner;
    }
    public double getBalance() {
        return balance;
    }
    public void setBalance(double balance) {
        this.balance = balance;
    }
    @Override
    public String toString() {
        return "Account [accountNumber=" + accountNumber + ", owner=" + owner + ", balance=" + balance + "]";
    } 
}