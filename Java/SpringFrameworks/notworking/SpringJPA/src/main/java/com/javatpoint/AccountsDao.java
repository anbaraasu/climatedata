package com.javatpoint;

// Imports
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Transactional
public class AccountsDao {
    @PersistenceContext
    private EntityManager _entityManager;

    public void createAccount(int accountNumber, String owner, double balance) {
        Account account = new Account(accountNumber, owner, balance);
        _entityManager.persist(account);
    }

    public void updateBalance(int accountNumber, double newBalance) {
        Account account = _entityManager.find(Account.class, accountNumber);
        if (account != null) {
            account.setBalance(newBalance);
            _entityManager.merge(account);
        }
    }

    public void deleteAccount(int accountNumber) {
        Account account = _entityManager.find(Account.class, accountNumber);
        if (account != null)
            _entityManager.remove(account);
    }

    public List<Account> getAllAccounts() {
        return _entityManager.createQuery("select acc from Account acc", Account.class).getResultList();
    }
}