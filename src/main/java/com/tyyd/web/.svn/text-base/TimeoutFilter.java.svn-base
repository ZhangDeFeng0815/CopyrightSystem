package com.tyyd.web;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.web.AcwsTimeoutBaseFilter;

public class TimeoutFilter extends AcwsTimeoutBaseFilter {
	private static final long serialVersionUID = 1L;
	public static final Logger logger = Logger.getLogger(TimeoutFilter.class);

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// 将请求转换成HttpServletRequest,HttpServletResponse请求
		HttpServletRequest hrequest = (HttpServletRequest) request;

		// 记录日志
		String uri = StringUtils.removeStart(hrequest.getRequestURI(), hrequest.getContextPath());
		String uriL = StringUtils.lowerCase(uri);
		if(StringUtils.endsWithAny(uriL, "/acwsui/default/main.jsp")){
			Object ubean = Security.getUserObject();
			if(ubean==null){
				Security.redirectToLogin();
				return;
			} else {
				chain.doFilter(request, response);
			}
		} else if(canDirectAccessUri(uriL)){
			chain.doFilter(request, response);
			return;
		} else {
			Object ubean = Security.getUserObject();
			if(ubean==null){
				Security.redirectToLogin();
				return;
			} else {
				chain.doFilter(request, response);
			}
		} 
	}

	public void init(FilterConfig filterConfig) throws ServletException {

	}

}
