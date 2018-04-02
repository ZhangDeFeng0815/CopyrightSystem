/**
 * 版权所有：天翼阅读
 * 项目名称:系统框架
 * 创建者: Wangdf
 * 创建日期: 2014-07-22
 * 文件说明: 用户权限类
 */
package com.tyyd.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import com.read.haetaeCAS.common.lang.MD5;
import com.tyyd.framework.core.soa.EjbAdapter;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.HttpUtils;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.core.util.SecurityBase;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;
import com.tyyd.util.MyReadPlatformLogUtils;
import com.yutian.common.CodeConstants.OperationType;

import ejbModule.common.PageControlInfo;
import ejbModule.common.PageInfo;
import ejbModule.domain.userAdmin.TUser;
import ejbModule.domain.userAdmin.UserInfo;
import ejbModule.userAdmin.user.QueryUserMgr;
import ejbModule.userAdmin.user.UserManagerMgr;

/**
 * 用户权限类.
 * 该spring bean的scope必须是request的（含有成员变量）
 * 
 * 由于含有私有成员变量、所以该bean的scope必须是request
 *
 * @author wangdf
 */
public class MySecurity extends SecurityBase {
	private static final Logger logger = LoggerFactory.getLogger(MySecurity.class);
	public static String notExsit_msg="用户名不存在!";
	public static String stop_msg="用户已暂停!";
	public static String logout_msg="用户已注销!";
	public static String lock_msg="用户已锁定!";
	public static String denyDel_msg="不可删除!";
	public static String pwdDiff_msg="旧密码错误!";
	public static String onLine_msg="该用户已登陆!";
	public static String user_state_1="1";//状态:1-正常，2-暂停，3-注销，4-已锁定
	public static String user_state_2="2";
	public static String user_state_3="3";
	public static String user_state_4="4";

	/**
	 * 登录处理
	 */
	@Override
	public Object doLogin(String loginName, String pwd) {
		UserBean ubean = null;
		
		try{
			UserManagerMgr userManagerMgr = (UserManagerMgr) EjbAdapter.getInstance("ejbModule.userAdmin.user.UserManagerMgr");
			if(userManagerMgr==null){
				logger.error("EJB UserManagerMgr取得失败！");
				throw new RuntimeException("EJB UserManagerMgr取得失败！");
			}
			TUser user = userManagerMgr.getTUserByUserUid(loginName);
			ubean = getUserBean(user);
			if(null==ubean){
				//用户名不存在
				ExceptionUtils.throwAcwsException(notExsit_msg);
			}
			
			//角色权限控制关键步骤：设置用户的角色ids
			Long userId = ubean.getUserId();
			if(userId == null || userId == 0){
				//用户名不存在
				ExceptionUtils.throwAcwsException(notExsit_msg);
			}
			
			String pwdDb = user.getUserPwd();
			if(!StringUtils.equals(pwdDb, pwd)){
				ExceptionUtils.throwAcwsException("密码不正确!");
			}
			String userState = user.getState();
			if (user_state_2.equals(userState)) {
				//用户已暂停
				ExceptionUtils.throwAcwsException(stop_msg);
			}
			if (user_state_3.equals(userState)) {
				//用户已注销
				ExceptionUtils.throwAcwsException(logout_msg);
			}
			if (user_state_4.equals(userState)) {
				//用户已锁定
				ExceptionUtils.throwAcwsException(lock_msg);
			} 
			
			ubean.setLoginIp(HttpUtils.getRemortIP(this.getRequest()));
			List<Long> roleIds = Security.getRoleIdsByUserId(userId);
			ubean.setRoleIds(roleIds);
		}catch(Throwable e){
			ExceptionUtils.throwAcwsException(e);
		}
		
		return ubean;
	}

	/**
	 * 登录成功事件
	 */
	@Override
	public void onLogin(Object userBean) {
		MyReadPlatformLogUtils.createOperationLog((UserBean)userBean, this.getRequest().getSession(),OperationType.LOGIN, "登录日志", "登录成功！");
	}

	/**
	 * 登出成功事件
	 */
	@Override
	public void onLogout(HttpSession session, Object userBean) {
		MyReadPlatformLogUtils.createOperationLog((UserBean)userBean, session, OperationType.LOGIN_OUT, "登录日志", "登出成功！");
	}
	
	/**
	 * 主页初始化
	 * @param params
	 * @return
	 */
	public Map<String, Object> doHomeInit(Map<String, Object> params){
		return null;
	}
	
	/**
	 * 修改密码
	 * @param session
	 * @param userBean
	 * @return
	 */
	@Override
	public Map<String, Object> doChangePwd(String oldpwd, String newpwd, String surpwd){
		if(StringUtils.isBlank(oldpwd) || StringUtils.isBlank(newpwd)||StringUtils.isBlank(newpwd)){
			ExceptionUtils.throwAcwsException("旧密码、新密码、确认密码都没能为空。");
		}
		UserManagerMgr userManagerMgr = (UserManagerMgr) EjbAdapter.getInstance("ejbModule.userAdmin.user.UserManagerMgr");
		if(userManagerMgr==null){
			ExceptionUtils.throwAcwsException("EJB<UserManagerMgr>取得失败.");
		}
		String loginName = Security.getUserLoginName();
		if(StringUtils.isBlank(loginName)) {
			Security.redirectToLogin();
		}
		TUser tuser = userManagerMgr.getTUserByUserUid(loginName);
		String oldpwdsrc = tuser.getUserPwd();
		if(!StringUtils.equals(newpwd, surpwd)){
			ExceptionUtils.throwAcwsException("新密码与确认密码不一致.");
		}
		if(!StringUtils.equals(MD5.MD5Encode(oldpwd), oldpwdsrc)){
			ExceptionUtils.throwAcwsException("旧密码错误.");
		}
		
		int result = userManagerMgr.updateUserPwd(String.valueOf(Security.getCurrentUserID()), oldpwd, newpwd);
		String failureMsg = "";
		if (result == 1) {
			//"修改密码成功！";
			return null;
		} else if (result == 2) {
			failureMsg = "修改密码失败，旧密码不正确！";
		} else if (result == 3) {
			failureMsg = "修改密码失败，用户不存在！";
		} else if (result == 4) {
			failureMsg = "修改密码失败，参数错误！";
		} else{
			failureMsg = "修改密码失败，参数错误！";
		}
		if(StringUtils.isNoneBlank(failureMsg)){
			ExceptionUtils.throwAcwsException(failureMsg);
		}

		return null;
	}
	
	/**
	 * 角色用户管理表单初始化
	 * 返回分页的用户列表：
	 *   返回值列表：
	 *   	dataCount：记录条数(只有当pageNum==1时需要计算dataCount)
	 *   	dataList：USER_ID\LOGIN_NAME\USER_NAME
	 * @author wangdf
	 */
	@Override
	public Map<String, Object> doSearchUsers(String loginName, String userName, Long userId, int pageNum, int pageSize){
		if(pageSize<0 || pageNum<0){
			return null;
		}
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCurPage(pageNum);
		pageInfo.setRowsPerPage(pageSize);
		
		TUser user = new TUser();
		user.setState("1");
		if(StringUtils.isNotBlank(loginName)){
			user.setUserUid(loginName);
		}
		if(StringUtils.isNoneBlank(userName)){
			user.setUserName(userName);
		}
		
		QueryUserMgr queryUserMgr = (QueryUserMgr)EjbAdapter.getInstance("ejbModule.userAdmin.user.QueryUserMgr");
		PageControlInfo<?> pageControlInfo = queryUserMgr.queryUserByMultiProperty(user,pageInfo);
		
		if(pageControlInfo==null){
			logger.warn("queryUserMgr#getUsersByMultiProperty()用户数据取得时、为null");
			return null;
		}
		
		List<?> dataList = pageControlInfo.getSearchData();
		if(dataList.size()==0){
			return null;
		}
		
		List<Map<String, Object>> userList=new ArrayList<Map<String, Object>>();
		for(Object ouser : dataList){
			Map<String, Object> userInfoTar = new HashMap<String, Object>();
			UserInfo tuser = (UserInfo )ouser;
			if(tuser==null){
				return null;
			}
			//校验用户信息
			userInfoTar.put("USER_ID", tuser.getUserId());
			userInfoTar.put("LOGIN_NAME", tuser.getUserUid());
			userInfoTar.put("USER_NAME", tuser.getUserMobilephone());
			userList.add(userInfoTar);
		}
		if(userId != null && userId != 0){
			TUser tUser = queryUserMgr.queryUserById(String.valueOf(userId));
			userList=new ArrayList<Map<String, Object>>();
			if(tUser==null){
				return null;
			}
			Map<String, Object> userInfoTar = new HashMap<String, Object>();
			userInfoTar.put("USER_ID", tUser.getUserId());
			userInfoTar.put("LOGIN_NAME", tUser.getUserUid());
			userInfoTar.put("USER_NAME", tUser.getUserName());
			userList.add(userInfoTar);
			pageControlInfo.setTotalNum(1);
		}
		HashMap<String, Object> output = new HashMap<String, Object>();
		output.put("dataList", userList);
		output.put("dataCount", pageControlInfo.getTotalNum());//只有当pageNum==1时需要计算dataCount
		return output;		
	}
	
	private UserBean getUserBean(TUser user){
		
		if(user==null){
			return null;
		}
		
		//校验用户信息
		UserBean userBean = new UserBean();
		
		userBean.setUserId(user.getUserId());
		userBean.setLoginName(user.getUserUid());
		userBean.setUserName(user.getUserName());
		userBean.setNickName(user.getUserNickname());
		
		return userBean;
	}
}
