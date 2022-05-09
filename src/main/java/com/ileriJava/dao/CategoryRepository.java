package com.ileriJava.dao;

import com.ileriJava.model.Category;
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

/**
 * @author furkancelik
 **/

@Repository
public class CategoryRepository {

    @Autowired
    SessionFactory sessionFactory;

    public List<Category> findAll() {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

        CriteriaQuery<Category> cq = criteriaBuilder.createQuery(Category.class);

        Root<Category> categoryRoot = cq.from(Category.class);
        cq.select(categoryRoot);

        Query<Category> query = session.createQuery(cq);
        return query.getResultList();
    }

    public List<Category> findAllPagination(Integer start, Integer limit) {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();

        CriteriaQuery<Category> cq = criteriaBuilder.createQuery(Category.class);

        Root<Category> categoryRoot = cq.from(Category.class);
        cq.select(categoryRoot);

        Query<Category> query = session.createQuery(cq);
        query.setFirstResult(start);
        query.setMaxResults(limit);

        return query.getResultList();
    }
}
