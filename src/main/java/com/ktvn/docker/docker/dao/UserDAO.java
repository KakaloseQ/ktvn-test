package com.ktvn.docker.docker.dao;

import com.ktvn.docker.docker.entities.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

@Repository
@Transactional
public class UserDAO {

    @Autowired
    private EntityManager entityManager;

    public UserEntity findUserAccount(String userName) {
        try {
            String sql = "SELECT e from " + UserEntity.class.getName() + " e " //
                    + " WHERE e.userName = :userName ";

            Query query = entityManager.createQuery(sql, UserEntity.class);
            query.setParameter("userName", userName);

            return (UserEntity) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
