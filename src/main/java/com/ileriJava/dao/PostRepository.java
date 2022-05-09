package com.ileriJava.dao;


import com.ileriJava.model.FaultRecords;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
public class PostRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<FaultRecords> findByUserID(Long userID) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);

        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);
        Predicate idPredicate = cb.equal(faultRecordsRoot.get("user").get("id"), userID);
        cq.where(idPredicate);

        Query query = session.createQuery(cq);
        return query.getResultList();
    }

    public List<FaultRecords> getAll(Integer start, Integer limit) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);
        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);
        cq.select(faultRecordsRoot);
        Query query = session.createQuery(cq);

        query.setFirstResult(start);
        query.setMaxResults(limit);

        return query.getResultList();
    }

    public Integer getTotalCount() {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);
        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);
        cq.select(faultRecordsRoot);
        Query query = session.createQuery(cq);


        return query.getResultList().size();
    }

    public List<FaultRecords> getByCategoryID(Long categoryID) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();

        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);

        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);

        Predicate categoryPredicate = cb.equal(faultRecordsRoot.get("category").get("id"), categoryID);
        cq.where(categoryPredicate);

        Query query = session.createQuery(cq);

        return query.getResultList();
    }

    public List<FaultRecords> getByCategoryIdPagination(Long categoryID, Integer start, Integer limit) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();

        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);

        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);

        Predicate categoryPredicate = cb.equal(faultRecordsRoot.get("category").get("id"), categoryID);
        cq.where(categoryPredicate);

        Query query = session.createQuery(cq);
        query.setFirstResult(start);
        query.setMaxResults(limit);

        return query.getResultList();
    }

    public List<FaultRecords> findByUserIDPagination(Long userID, Integer start, Integer limit) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<FaultRecords> cq = cb.createQuery(FaultRecords.class);

        Root<FaultRecords> faultRecordsRoot = cq.from(FaultRecords.class);
        Predicate idPredicate = cb.equal(faultRecordsRoot.get("user").get("id"), userID);
        cq.where(idPredicate);

        Query query = session.createQuery(cq);
        query.setFirstResult(start);
        query.setMaxResults(limit);

        return query.getResultList();
    }
}
