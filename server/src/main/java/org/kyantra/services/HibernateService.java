package org.kyantra.services;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.kyantra.beans.*;

import java.util.Properties;

/**
 *  In this class we provide classes to hibernet of
 *  which we want tables to be created in database
 *  
 */
public class HibernateService {

    private static HibernateService mService = new HibernateService();
    private static SessionFactory sessionFactory ;

    private HibernateService() {

        Configuration configuration = new Configuration().configure();
        configuration.addAnnotatedClass(UserBean.class)
                .addAnnotatedClass(RightsBean.class)
                .addAnnotatedClass(UnitBean.class)
                .addAnnotatedClass(DeviceAttributeBean.class)
                .addAnnotatedClass(DeviceBean.class)
                .addAnnotatedClass(ThingBean.class)
                .addAnnotatedClass(SessionBean.class)
                .addAnnotatedClass(ConfigBean.class)
                .addAnnotatedClass(CronBean.class)
                .addAnnotatedClass(RuleBean.class)
                .addAnnotatedClass(SnsBean.class)
                .addAnnotatedClass(SnsSubscriptionBean.class);

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