package com.tyyd.util;

import java.util.concurrent.ExecutorService;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.tyyd.common.UserBean;
import com.tyyd.framework.core.util.StringUtil;
import com.yutian.common.CodeConstants.OperationType;

public class MyReadPlatformLogUtils {
	private static final Logger logger = LoggerFactory.getLogger(MyReadPlatformLogUtils.class);
	private static final String SYSTEM_NAME="文字版权管理系统";
	
	public static ExecutorService pool = null;
	
	/**
	 * 操作日志输出
	 * @param application 日志来源：图文主平台、渠道门户、版权管理平台、CP门户后台管理
	 * @param userId
	 * @param loginName
	 * @param userName
	 * @param ip
	 * @param type
	 * @param title
	 * @param operationText
	 * @return
	 */
	public static int createOperationLog(UserBean ubean,HttpSession session, OperationType type, String title, String operationText){
		if(session==null){
			logger.info("Session取得异常:"+String.valueOf(type)+":"+title+":"+operationText);
			return -2;//非SpringMVC框架日志
		}
		
		if(ubean == null){
			return -3;//当前用户早已退出
		}
		if(StringUtils.isBlank(title)){
			title="";
		}
		if(StringUtils.isBlank(operationText)){
			operationText = "";
		}
		
		operationText=StringUtil.addString(operationText,"(SESSIONID=", session.getId(),")");
		
		String ip = ubean.getLoginIp();
		Long userId = ubean.getUserId();
		String loginName= ubean.getLoginName();
		String userName = ubean.getUserName();
				
		return ReadPlatformLogUtils.createOperationLog(SYSTEM_NAME,
				userId, loginName, userName, ip, type, title, operationText);
	}
	
	public static void main(String[] args) {
	}

}
