package com.ileriJava.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.Serializable;

@Repository
public class MainDAO {

    @Autowired
    SessionFactory sessionFactory;

    private Session getCurrentSession(){
        return sessionFactory.getCurrentSession();
    }

    public Object loadObject(Class clazz, Serializable id){
        return getCurrentSession().get(clazz, id);
    }

    public Object saveObject(Object obj){
        return getCurrentSession().save(obj);
    }

    public void updateObject(Object obj){
        getCurrentSession().saveOrUpdate(obj);
    }

    public void delete(Object obj)
    {
        getCurrentSession().delete(obj);
    }
}
