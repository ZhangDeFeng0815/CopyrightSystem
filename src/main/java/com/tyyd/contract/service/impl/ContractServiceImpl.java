package com.tyyd.contract.service.impl;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.DecimalFormat;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.tyyd.common.service.impl.CopyrightSystemBaseServiceImpl;
import com.tyyd.contract.service.ContractService;
import com.tyyd.crps.scf.contract.service.ScfContractEditService;
import com.tyyd.crps.scf.contract.service.ScfContractSearchService;
import com.tyyd.crps.scf.contract.service.dto.ContractInDto;
import com.tyyd.crps.scf.contract.service.dto.ContractOutDto;
import com.tyyd.framework.core.soa.ScfAdapter;

/**
 * @author QinTao
 *
 */
@Service
public class ContractServiceImpl extends CopyrightSystemBaseServiceImpl implements ContractService {

	@Override
	public ContractInDto getContractInInfoByContractCd(String contractCd) {
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		return scfContractSearchService.getContractInInfoByContractCd(contractCd);
	}

	/**
	 * 判断收入合同编号是否存在
	 */
	@Override
	public Boolean contractOutExistsChk(String contractCd) {
		if (StringUtils.isBlank(contractCd)) {
			return false;
		}
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		Integer ret = scfContractSearchService.existsContractOutInfoByContractCd(contractCd);
		return ret > 0 ? true : false;
	}

	/**
	 * 判断获权合同编号是否存在
	 */
	@Override
	public Boolean contractInExistsChk(String contractCd) {
		if (StringUtils.isBlank(contractCd)) {
			return false;
		}
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		Integer ret = scfContractSearchService.existsContractInInfoByContractCd(contractCd);
		return ret > 0 ? true : false;
	}

	/**
	 * 授权合同列表查询
	 */
	@Override
	public List<ContractInDto> selectContractInList(Map<String, Object> params, String startRow, String endRow) {
		ContractInDto dto = new ContractInDto();
		dto.setContractCd(StringUtils.trim(MapUtils.getString(params, "CONTRACT_CD", "")));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "PARTNER_NAME", "")));
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		List<ContractInDto> list = scfContractSearchService.selectContractInList(dto, startRow, endRow);
		if (list == null || list.size() == 0) {
			return list;
		}
		return list.stream().map(inDto -> {
			inDto.setCreateUserName(getUserNameByUserId(inDto.getCreateUserId()));
			return inDto;
		}).collect(Collectors.toList());
	}

	/**
	 * 授权合同列表条数查询
	 */
	@Override
	public int selectContractInListCount(Map<String, Object> params) {
		ContractInDto dto = new ContractInDto();
		dto.setContractCd(StringUtils.trim(MapUtils.getString(params, "CONTRACT_CD", "")));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "PARTNER_NAME", "")));
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		return scfContractSearchService.selectContractInListCount(dto);
	}

	/**
	 * 保存获权合同
	 */
	@Override
	public Map<String, Object> addContractIn(Map<String, Object> params, Long userId) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "success", false);
		// 1.校验合同编号是否已经存在
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		Integer count = scfContractSearchService
				.existsContractInInfoByContractCd(StringUtils.trim(MapUtils.getString(params, "contractCd")));
		if (count>0) {
			MapUtils.safeAddToMap(retMap, "msg", "该合同编号已存在，请修改后再提交。");
			return retMap;
		}
		// 2.不存在，新增获权合同
		ContractInDto dto = new ContractInDto();
		dto.setContractCd(StringUtils.trim(MapUtils.getString(params, "contractCd")));
		dto.setPartnerId(MapUtils.getLong(params, "partnerId"));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "partnerName")));
		dto.setIsDeleted(0);
//		dto.setAttachmentId(attachmentId);
		dto.setCostP(MapUtils.getInteger(params, "costP"));
		dto.setCreateUserId(userId);
		dto.setUpdateUserId(userId);
		Instant now = Instant.now();
		dto.setCreateDate(Date.from(now));
		dto.setUpdateDate(Date.from(now));
		ScfContractEditService scfContractEditService = (ScfContractEditService) ScfAdapter
				.getInstance("scfContractEditService");
		Integer addRet = scfContractEditService.addContractIn(dto);
		if (addRet > 0) {
			MapUtils.safeAddToMap(retMap, "success", true);
		} else {
			MapUtils.safeAddToMap(retMap, "msg", "新增合同时发生未知异常，新增失败。");
		}
		return retMap;
	}

	/**
	 * 修改获权合同
	 */
	@Override
	public Map<String, Object> editContractIn(Map<String, Object> params, Long userId) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "success", false);
		// 1.修改获权合同
		ContractInDto dto = new ContractInDto();
		dto.setContractId(MapUtils.getLong(params, "contractId"));
		dto.setPartnerId(MapUtils.getLong(params, "partnerId"));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "partnerName")));
//		dto.setAttachmentId(attachmentId);
		dto.setCostP(MapUtils.getInteger(params, "costP"));
		dto.setUpdateUserId(userId);
		Instant now = Instant.now();
		dto.setUpdateDate(Date.from(now));
		ScfContractEditService scfContractEditService = (ScfContractEditService) ScfAdapter
				.getInstance("scfContractEditService");
		Integer addRet = scfContractEditService.editContractIn(dto);
		if (addRet > 0) {
			MapUtils.safeAddToMap(retMap, "success", true);
		} else {
			MapUtils.safeAddToMap(retMap, "msg", "修改合同时发生未知异常，修改失败。");
		}
		return retMap;
	}

	/**
	 * 查看获权合同信息
	 */
	@Override
	public Map<String, Object> viewContractIn(Map<String, Object> params) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		String cd = MapUtils.getString(params, "contractCd");
		if (StringUtils.isBlank(cd)) {
			return retMap;
		}
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		ContractInDto dto = scfContractSearchService.selectContractInByCdWithFile(cd);
		Integer costP = dto.getCostP();
		if (costP != null) {
			BigDecimal costpDec = (new BigDecimal(costP)).divide(new BigDecimal(100), 2, BigDecimal.ROUND_HALF_UP);
			dto.setCostpStr(new DecimalFormat(",###.##").format(costpDec));
		}
		MapUtils.safeAddToMap(params, "contract", dto);
		return params;
	}

	/**
	 * 授权合同列表查询
	 */
	@Override
	public List<ContractOutDto> selectContractOutList(Map<String, Object> params, String startRow, String endRow) {
		ContractOutDto dto = new ContractOutDto();
		dto.setContractCd(StringUtils.trim(MapUtils.getString(params, "CONTRACT_CD", "")));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "PARTNER_NAME", "")));
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		List<ContractOutDto> list = scfContractSearchService.selectContractOutList(dto, startRow, endRow);
		if (list == null || list.size() == 0) {
			return list;
		}
		return list.stream().map(outDto -> {
			outDto.setCreateUserName(getUserNameByUserId(outDto.getCreateUserId()));
			return outDto;
		}).collect(Collectors.toList());
	}

	/**
	 * 授权合同列表条数查询
	 */
	@Override
	public int selectContractOutListCount(Map<String, Object> params) {
		ContractOutDto dto = new ContractOutDto();
		dto.setContractCd(StringUtils.trim(MapUtils.getString(params, "CONTRACT_CD", "")));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "PARTNER_NAME", "")));
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		return scfContractSearchService.selectContractOutListCount(dto);
	}

	/**
	 * 查看授权合同
	 */
	@Override
	public Map<String, Object> viewContractOut(Map<String, Object> params) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		String cd = MapUtils.getString(params, "contractCd");
		if (StringUtils.isBlank(cd)) {
			return retMap;
		}
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		ContractOutDto dto = scfContractSearchService.selectContractOutByCdWithFile(cd);
		MapUtils.safeAddToMap(params, "contract", dto);
		return params;
	}

}
