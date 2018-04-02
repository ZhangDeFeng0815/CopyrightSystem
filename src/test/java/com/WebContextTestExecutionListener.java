package com;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;  
import org.springframework.beans.factory.config.Scope;  
import org.springframework.context.support.GenericApplicationContext;  
import org.springframework.context.support.SimpleThreadScope;  
import org.springframework.test.context.TestContext;  
import org.springframework.test.context.support.AbstractTestExecutionListener;  
  
public class WebContextTestExecutionListener extends AbstractTestExecutionListener {  
    @Override  
    public void prepareTestInstance(TestContext testContext) throws Exception {  
  
        if (testContext.getApplicationContext() instanceof GenericApplicationContext) {  
            GenericApplicationContext context = (GenericApplicationContext) testContext.getApplicationContext();  
            ConfigurableListableBeanFactory beanFactory = context.getBeanFactory();  
            Scope requestScope = new SimpleThreadScope();  
            beanFactory.registerScope("request", requestScope);  
            Scope sessionScope = new SimpleThreadScope();  
            beanFactory.registerScope("session", sessionScope);  
            
            /*
            #session
            user.session=sessionUser
            #context
            user.context=contextUserId

            ##config
            file.url=http://pic.tyread.com:8082/
            file.upload=/ytxt/ufile/
            file.upload.temp=/ytxt/ufileTemp/
            #file.system.appkey move to Setttings center
            #file.system.appkey=testAppKey
            serverIp=172.23.0.12
            cpPortalHost=127.0.0.1
            #cpPortalPort
            cpPortalPort=8080

            #rabbitMq.ServerIp=192.168.11.59 
            rabbitMq.ServerIp=172.23.0.15
            */
            
            System.setProperty("user.session", "sessionUser");
            System.setProperty("file.upload", "/ytxt/ufile/");
        }  
    }  
}  