package com.tyyd.common;

import java.io.Serializable;
import java.util.List;
/**
 * 用户类
 * @author wangdf
 */
public class UserBean implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 用户id
	 * 框架必须字段（字段名可自定义）
	 */
	private Long userId;
	/**
	 * 用户名
	 * 框架必须字段（字段名可自定义）
	 */
	private String userName;
	/**
	 * 用户登录名
	 * 框架必须字段（字段名可自定义）
	 */
	private String loginName;
	/**
	 * 用户昵称
	 * 框架必须字段（字段名可自定义）
	 */
	private String nickName;
	/**
	 * 用户角色
	 * 框架必须字段（字段名可自定义）
	 */
	private List<Long> roleIds;
	
	/**
	 * 用户角色
	 * 业务字段
	 */
	private String loginIp;
	
	public String getLoginIp() {
		return loginIp;
	}
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public List<Long> getRoleIds() {
		return roleIds;
	}
	public void setRoleIds(List<Long> roleIds) {
		this.roleIds = roleIds;
	}
}
