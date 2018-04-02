package com.tyyd.partner.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.tyyd.framework.core.BusinessException;
import com.tyyd.crps.scf.partner.dto.PartnerDto;

@Service
public interface PartnerService {
	
	/**
	 * 获取合作商列表
	 * @param params 查询条件
	 * @return
	 */
	public List<PartnerDto> searchPartnerList(Map<String, Object> params, String startRow, String endRow);
	
	/**
	 * 获取合作商总记录数
	 * @param params 查询条件
	 * @return
	 */
	public int searchPartnerListCount(Map<String, Object> params);
	
	/**
	 * 新增、修改保存合作商
	 * @param params
	 * @return
	 */
	public Integer savePartner(Map<String, Object> params);
	
	/**
	 * 查询单个合作商详情
	 * @author qintao
	 */
	public PartnerDto getPartnerById(Long partnerId) throws BusinessException;
	
	/**
	 * 删除合作商
	 * @param partnerId
	 * @return
	 * @throws BusinessException
	 */
	public Integer deletePartner(Long partnerId) throws BusinessException;
	
}
