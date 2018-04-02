package com.tyyd.web;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.tyyd.framework.core.thread.AcwsExecutors;
import com.tyyd.util.ReadPlatformLogUtils;

public class MyContextListener implements ServletContextListener {
	private static final Logger logger = LoggerFactory.getLogger(MyContextListener.class);
	

	@Override
	public void contextInitialized(ServletContextEvent event) {
		//启动日志线程
		ReadPlatformLogUtils.pool = AcwsExecutors.newFixedThreadPool(2, 1000);
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		ReadPlatformLogUtils.pool.shutdown();
	}
	
}