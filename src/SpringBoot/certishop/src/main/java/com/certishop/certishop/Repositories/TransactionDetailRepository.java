package com.certishop.certishop.Repositories;

import com.certishop.certishop.Entities.TransactionDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true, rollbackFor = Exception.class)
public interface TransactionDetailRepository extends JpaRepository<TransactionDetail, Integer> {
    
    @Transactional
    @Override
    public <S extends TransactionDetail> S save(S entity);

    @Transactional
    @Override
    public <S extends TransactionDetail> java.util.List<S> saveAll(java.lang.Iterable<S> entities);
}
