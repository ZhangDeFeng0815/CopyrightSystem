/**
 * 版权所有：天翼文化
 * 项目名称: 编审平台
 * 创建者: wangdf
 * 创建日期: 2018-3-21
 * 文件说明: 归集表Service
 */
package com.tyyd.common.service;

import java.util.List;
import java.util.Map;

import com.tyyd.common.po.PoBaseInfo;

public interface CopyrightSystemBaseService {

	/**
	 * 列表转换用户名
	 * 
	 * @param userIdAndName
	 * @param baseInfo
	 * @return
	 */
	public Map<String, Object> setBaseInfoUserName(Map<String, Object> userIdAndName, PoBaseInfo baseInfo);

	/**
	 * 根据用户ID获取用户名称
	 * 
	 * @param userId
	 * @return
	 */
	public String getUserNameById(String userId);

	/**
	 * 数值转换
	 * 
	 * @param bigNum
	 * @param divNum
	 * @param num
	 * @return
	 */
	public String convertNumber(String bigNum, int divNum, int num);

	/**
	 * 用String的BigDecimal构造器 求和计算
	 * 
	 * @param numList
	 * @return
	 */
	public String bigDecimalAdd(List<String> numList);

	/**
	 * 用String的BigDecimal构造器 求和计算
	 * 
	 * @param numA
	 * @param numB
	 * @return
	 */
	public String bigDecimalAdd(String numA, String numB);

}
