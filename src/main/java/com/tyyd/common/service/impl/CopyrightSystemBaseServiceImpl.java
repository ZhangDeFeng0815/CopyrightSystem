/**
 * 版权所有：天翼文化
 * 项目名称: 编审平台
 * 创建者: wangdf
 * 创建日期: 2018-3-21
 */
package com.tyyd.common.service.impl;

import java.util.HashMap;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.tyyd.common.po.PoBaseInfo;
import com.tyyd.common.service.CopyrightSystemBaseService;
import com.tyyd.framework.core.soa.EjbAdapter;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.MapUtils;

import ejbModule.domain.userAdmin.TUser;
import ejbModule.userAdmin.user.QueryUserMgr;

public abstract class CopyrightSystemBaseServiceImpl implements CopyrightSystemBaseService {

	private ThreadLocal<Map<Long, String>> userIdAndNameLocal = new ThreadLocal<Map<Long, String>>();
	
	public Map<String, Object> setBaseInfoUserName(Map<String, Object> userIdAndName, PoBaseInfo baseInfo) {
		if (StringUtils.isNotBlank(MapUtils.getString(userIdAndName, String.valueOf(baseInfo.getCreateUserId())))) {
			baseInfo.setCreateUserName(MapUtils.getString(userIdAndName, String.valueOf(baseInfo.getCreateUserId())));
		} else {
			String userName = getUserNameById(String.valueOf(baseInfo.getCreateUserId()));
			if (userName == null) {
				baseInfo.setCreateUserName(String.valueOf(baseInfo.getCreateUserId()));
			} else {
				baseInfo.setCreateUserName(userName);
				MapUtils.safeAddToMap(userIdAndName, String.valueOf(baseInfo.getCreateUserId()), userName);
			}
		}
		return userIdAndName;
	}
	
	/**
	 * 根据userId，返回用户名
	 * @param userId
	 * @return
	 */
	public String getUserNameByUserId(Long userId) {
		if (userId == null) {
			return null;
		}
		Map<Long, String> map = userIdAndNameLocal.get();
		if (map == null) {
			map = new HashMap<Long, String>();
		}
		if (map.containsKey(userId)) {
			return map.get(userId);
		}
		String userName = getUserNameById(String.valueOf(userId));
		if (StringUtils.isBlank(userName)) {
			return String.valueOf(userId);
		}
		MapUtils.safeAddToMap(map, userId, userName);
		userIdAndNameLocal.set(map);
		return userName;
	}

	/**
	 * 通过userId取得userName
	 * 
	 * @param userId
	 * @return
	 */
	public String getUserNameById(String userId) {
		try {
			QueryUserMgr queryUserMgr = (QueryUserMgr) EjbAdapter.getInstance("ejbModule.userAdmin.user.QueryUserMgr");
			TUser user = queryUserMgr.queryUserById(userId);
			if (user != null && StringUtils.isNotBlank(user.getUserName())) {
				return user.getUserName();
			}
			return userId;
		} catch (Exception e) {
			ExceptionUtils.throwAcwsException(e);
			return null;
		}
	}

	/**
	 * 数值转换
	 * 
	 * @param bigNum
	 * @param divNum
	 * @param num
	 * @return
	 */
	public String convertNumber(String bigNum, int divNum, int num) {
		if (StringUtils.isBlank(bigNum)) {
			bigNum = "0";
		}
		double a = Double.valueOf(bigNum).doubleValue();
		a = a / divNum;
		String numString = "0.";
		for (int i = 0; i < num; i++) {
			numString += "0";
		}
		DecimalFormat df = new DecimalFormat(numString);
		return df.format(a).toString();
	}

	/**
	 * 用String的BigDecimal构造器 求和计算
	 * 
	 * @param numList
	 * @return
	 */
	public String bigDecimalAdd(List<String> numList) {
		String numTotal = "0";
		if (numList == null || numList.size() < 1) {
			return null;
		}
		for (String num : numList) {
			numTotal = bigDecimalAdd(numTotal, num);
		}
		return numTotal;
	}

	/**
	 * 用String的BigDecimal构造器 求和计算
	 * 
	 * @param numA
	 * @param numB
	 * @return
	 */
	public String bigDecimalAdd(String numA, String numB) {
		if (StringUtils.isBlank(numA) || StringUtils.isBlank(numB)) {
			return null;
		}
		BigDecimal a = new BigDecimal(numA);
		BigDecimal b = new BigDecimal(numB);
		return a.add(b).toString();
	}
}
