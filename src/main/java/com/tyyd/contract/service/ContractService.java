package com.tyyd.contract.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.tyyd.crps.scf.contract.service.dto.ContractInDto;
import com.tyyd.crps.scf.contract.service.dto.ContractOutDto;

@Service
public interface ContractService {

	/**
	 * 根据合同编号获取获权合同基本信息
	 * 
	 * @param contractCd
	 * @return
	 */
	public ContractInDto getContractInInfoByContractCd(String contractCd);
	
	/**
	 * 判断收入合同编号是否存在
	 * @param params
	 * @return
	 */
	public Boolean contractOutExistsChk(String contractCd);
	
	/**
	 * 判断获权合同编号是否存在
	 * @param params
	 * @return
	 */
	public Boolean contractInExistsChk(String contractCd);
	
	/**
	 * 获权合同列表查询
	 * @param params
	 * @param startRow
	 * @param endRow
	 * @return
	 */
	public List<ContractInDto> selectContractInList(Map<String, Object> params, String startRow, String endRow);
	
	/**
	 * 获权合同列表条数查询
	 * @param params
	 * @return
	 */
	public int selectContractInListCount(Map<String, Object> params);
	
	/**
	 * 保存获权合同
	 * @param params
	 * @param userId
	 * @return
	 */
	public Map<String, Object> addContractIn(Map<String, Object> params, Long userId);
	
	/**
	 * 保存获权合同
	 * @param params
	 * @param userId
	 * @return
	 */
	public Map<String, Object> editContractIn(Map<String, Object> params, Long userId);
	
	/**
	 * 查看获权合同
	 * @param params
	 * @param userId
	 * @return
	 */
	public Map<String, Object> viewContractIn(Map<String, Object> params);
	
	/**
	 * 授权合同列表查询
	 * @param params
	 * @param startRow
	 * @param endRow
	 * @return
	 */
	public List<ContractOutDto> selectContractOutList(Map<String, Object> params, String startRow, String endRow);
	
	/**
	 * 授权合同列表条数查询
	 * @param params
	 * @return
	 */
	public int selectContractOutListCount(Map<String, Object> params);
	
	/**
	 * 查看授权合同
	 * @param params
	 * @param userId
	 * @return
	 */
	public Map<String, Object> viewContractOut(Map<String, Object> params);
}
