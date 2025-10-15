package it.si2001.demo.config;

import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
public class HibernateConfig {
  
  @Bean
  public DataSource dataSource() {
    try {
      HikariConfig config = new HikariConfig();
      config.setDriverClassName("com.mysql.cj.jdbc.Driver");
      config.setJdbcUrl("jdbc:mysql://db:3306/db");
      config.setUsername("admin");
      config.setPassword("admin");
      config.setMaximumPoolSize(10);
      config.setMinimumIdle(2);
      config.setPoolName("pool_1");
      return new HikariDataSource(config);
    } catch (Throwable e) {
      e.printStackTrace();
      throw new ExceptionInInitializerError(e);
    }
  }
  
  @Bean
  public LocalSessionFactoryBean sessionFactory(DataSource dataSource) {
    LocalSessionFactoryBean sfb = new LocalSessionFactoryBean();
    sfb.setDataSource(dataSource);
    sfb.setPackagesToScan("it.si2001.demo.models");
    
    Properties properties = new Properties();
    properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
    // Validates and auto-creates the DB schema
    // WARNING: NOT SAFE for production (use 'validate' instead)
    properties.put("hibernate.hbm2ddl.auto", "update");
    properties.put("hibernate.show_sql", "false");
    properties.put("hibernate.format_sql", "false");
    properties.put("hibernate.current_session_context_class", "org.springframework.orm.hibernate5.SpringSessionContext");
    
    sfb.setHibernateProperties(properties);
    
    return sfb;
  }
  
  @Bean
  public HibernateTransactionManager transactionManager(SessionFactory sessionFactory) {
    HibernateTransactionManager transactionManager = new HibernateTransactionManager();
    transactionManager.setSessionFactory(sessionFactory);
    return transactionManager;
  }
  
}
