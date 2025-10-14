package it.si2001.demo.config;

import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
  
  // ?
  @Override
  public void onStartup(ServletContext servletContext) throws ServletException {
    AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
    context.register(AppConfig.class);
    
    ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(context));
    dispatcher.setLoadOnStartup(1);
    dispatcher.addMapping("/");
  }

  // ?
  @Override
  protected Class<?>[] getRootConfigClasses() {
    return new Class[0];
  }

  // ?
  @Override
  protected Class<?>[] getServletConfigClasses() {
    return new Class[]{ 
      AppConfig.class,
      HibernateConfig.class
    };
  }

  // ?
  @Override
  protected String[] getServletMappings() {
    return new String[]{ "/" };
  }
  
}
