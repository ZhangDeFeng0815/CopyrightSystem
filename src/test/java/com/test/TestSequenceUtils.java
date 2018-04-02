package com.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.annotation.PropertySource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;

import com.WebContextTestExecutionListener;
import com.tyyd.framework.core.util.DateUtil;
import com.tyyd.framework.core.util.SequenceUtils;

@PropertySource("classpath*:*.properties")
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:acws.xml","classpath*:acws-mvc_test.xml"})
@TestExecutionListeners({   
    WebContextTestExecutionListener.class,   
    DependencyInjectionTestExecutionListener.class,  
    DirtiesContextTestExecutionListener.class })  
public class TestSequenceUtils {
	
	public void setUp() throws Exception {
	}
	
	@Test
	public void getNextSequence() throws Exception {
		long val = SequenceUtils.getNextValue("ZL", DateUtil.getCurrentDate());
		System.out.println(val);
	}
	@Test
	public void getNextSequence2() throws Exception {
		long val = SequenceUtils.getNextValue("TEST_KEY", null);
		System.out.println(val);
	}
	

}
