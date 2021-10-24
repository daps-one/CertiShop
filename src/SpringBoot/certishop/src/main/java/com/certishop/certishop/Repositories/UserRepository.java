package com.certishop.certishop.Repositories;

import java.util.Optional;

import com.certishop.certishop.Entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true, rollbackFor = Exception.class)
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByIdentificationNumber(String identificationNumber);

    @Transactional
    @Override
    public <S extends User> S save(S entity);

    @Transactional
    @Override
    public <S extends User> java.util.List<S> saveAll(java.lang.Iterable<S> entities);
}
