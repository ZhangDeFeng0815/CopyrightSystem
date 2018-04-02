package com.tyyd.util;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.ThreadPoolExecutor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.tyyd.framework.core.soa.EjbAdapter;
import com.tyyd.framework.core.thread.AcwsExecutors;
import com.yutian.common.CodeConstants.OperationType;

import ejbModule.operation.operation_log.OperationsLogMgr;

public class ReadPlatformLogUtils {
	public static ExecutorService pool = null;
	
	private static final Logger logger = LoggerFactory.getLogger(ReadPlatformLogUtils.class);

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
	public static int createOperationLog(String application, Long userId, String loginName, String userName, String ip, OperationType type, String title, String operationText){
		if(pool == null){
			logger.info("日志线程池未启动:"+application+":"+userId+":"+loginName+":"+userName+":"+ip+":"+String.valueOf(type)+":"+title+":"+operationText);
			return -1;//日志线程池未启动
		}
		if(((ThreadPoolExecutor)pool).getQueue().size()>=999){
			logger.info("日志线程池超限:"+application+":"+userId+":"+loginName+":"+userName+":"+ip+":"+String.valueOf(type)+":"+title+":"+operationText);
			return -2;//日志线程池未启动
		}
		final String app = application;
		final Long uid = userId;
		final String lName = loginName;
		final String luName = userName;
		final String lip = ip;
		final OperationType otype = type;
		final String t = title;
		final String ot = operationText;
		try{
		pool.execute(new Runnable() {
			@Override
			public void run() {
				OperationsLogMgr mgr = (OperationsLogMgr)EjbAdapter.getInstance("ejbModule.operation.operation_log.OperationsLogMgr");
				try{
					mgr.createOperationLog(uid, lName, luName, t, ot, otype, lip, app);
					logger.info(app+":"+uid+":"+lName+":"+luName+":"+lip+":"+String.valueOf(otype)+":"+t+":"+ot);
				}catch(Throwable e){
					//日志线程池未启动
					logger.info("日志接口异常:"+app+":"+uid+":"+lName+":"+luName+":"+lip+":"+String.valueOf(otype)+":"+t+":"+ot);
					e.printStackTrace();
				}
			}
		});
		}catch(Throwable e){
			e.printStackTrace();
			logger.info("日志接口异常:"+app+":"+uid+":"+lName+":"+luName+":"+lip+":"+String.valueOf(otype)+":"+t+":"+ot);
		}
		return 0;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		pool = AcwsExecutors.newFixedThreadPool(2, 1000);
		
		for(int i=0; i<100; i++){
			createOperationLog("SYSTEM_NAME", 1001l, "wangdf", "王德封", "127.0.0.1", OperationType.LOGIN,"登录登出","登录");
		}
		pool.shutdown();
	}

}
