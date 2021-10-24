package com.certishop.certishop.Repositories.TransactionRepository;

import java.util.List;

import com.certishop.certishop.Entities.Transactions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true, rollbackFor = Exception.class)
public interface ITransactionRepository extends JpaRepository<Transactions, Integer> {
    // Optional<Transaction> findByDateAndUser(Date date, Integer userId);

    @Query("SELECT Tra FROM Transactions Tra WHERE userId = :userId AND YEAR(Tra.transactionDate) = :year AND MONTH(Tra.transactionDate) = :month")
    List<Transactions> findByUserAndDate(Integer userId, Integer year, Integer month);

    @Transactional
    @Override
    public <S extends Transactions> S save(S entity);

    @Transactional
    @Override
    public <S extends Transactions> java.util.List<S> saveAll(java.lang.Iterable<S> entities);
}
