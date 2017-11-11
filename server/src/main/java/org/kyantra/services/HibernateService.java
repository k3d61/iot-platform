package org.kyantra.services;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.kyantra.beans.UserBean;

public class HibernateService {

    private static HibernateService mService = new HibernateService();
    private static SessionFactory sessionFactory ;

    private HibernateService() {
        org.apache.derby.jdbc.ClientDriver driver;
        Configuration configuration = new Configuration().configure();
        configuration.addAnnotatedClass(UserBean.class);
        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties());
        sessionFactory = configuration.buildSessionFactory(builder.build());
    }


    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    public static HibernateService getInstance(){
        return mService;
    }
}