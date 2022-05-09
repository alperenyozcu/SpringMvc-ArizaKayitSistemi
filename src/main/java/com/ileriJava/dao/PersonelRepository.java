package com.ileriJava.dao;

import com.ileriJava.model.Category;
import com.ileriJava.model.Personel;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @author furkancelik
 **/

@Repository
public class PersonelRepository {

    @Autowired
    SessionFactory sessionFactory;

    public List<Personel> findAll() {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

        CriteriaQuery<Personel> cq = criteriaBuilder.createQuery(Personel.class);

        Root<Personel> personelRoot = cq.from(Personel.class);
        cq.select(personelRoot);

        Query<Personel> query = session.createQuery(cq);
        return query.getResultList();
    }

    public List<Personel> findAllPagination(Integer start, Integer limit) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

        CriteriaQuery<Personel> cq = criteriaBuilder.createQuery(Personel.class);

        Root<Personel> personelRoot = cq.from(Personel.class);
        cq.select(personelRoot);

        Query<Personel> query = session.createQuery(cq);
        query.setFirstResult(start);
        query.setMaxResults(limit);

        return query.getResultList();
    }

    public Personel getByUserID(Long userID) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

        CriteriaQuery<Personel> cq = criteriaBuilder.createQuery(Personel.class);

        Root<Personel> personelRoot = cq.from(Personel.class);

        Predicate userIDPredicate = criteriaBuilder.equal(personelRoot.get("user").get("id"), userID);

        cq.where(userIDPredicate);

        Query<Personel> query = session.createQuery(cq);
        return query.getSingleResult();
    }
}
