package com.tyyd.partner.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.tyyd.crps.scf.partner.dto.PartnerDto;
import com.tyyd.crps.scf.partner.service.ScfPartnerEditService;
import com.tyyd.crps.scf.partner.service.ScfPartnerSearchService;
import com.tyyd.framework.core.BusinessException;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;
import com.tyyd.partner.service.PartnerService;

/**
 * @author QinTao
 *
 */
@Service
public class PartnerServiceImpl implements PartnerService {
	private static final Logger logger = LoggerFactory.getLogger(PartnerServiceImpl.class);

	/**
	 * 获取合作商列表
	 */
	@Override
	public List<PartnerDto> searchPartnerList(Map<String, Object> params, String startRow, String endRow) {
		ScfPartnerSearchService scfPartnerSearchService = (ScfPartnerSearchService)ScfAdapter.getInstance("scfPartnerSearchService");
		PartnerDto partnerDto = new PartnerDto();
		if(StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_ID", ""))) {
			partnerDto.setPartnerId(MapUtils.getLong(params, "PARTNER_ID"));
		}
		if(StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_NAME", ""))) {
			partnerDto.setPartnerName(MapUtils.getString(params, "PARTNER_NAME"));
		}
		if(StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_TYPE", ""))) {
			partnerDto.setPartnerType(MapUtils.getInteger(params, "PARTNER_TYPE"));
		}
		partnerDto.setStartRow(startRow);
		partnerDto.setEndRow(endRow);
		return scfPartnerSearchService.searchPartnerList(partnerDto);
	}

	/**
	 * 获取合作商总记录数
	 */
	@Override
	public int searchPartnerListCount(Map<String, Object> params) {
		ScfPartnerSearchService scfPartnerSearchService = (ScfPartnerSearchService)ScfAdapter.getInstance("scfPartnerSearchService");
		PartnerDto partnerDto = new PartnerDto();
		if(StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_ID", ""))) {
			partnerDto.setPartnerId(MapUtils.getLong(params, "PARTNER_ID"));
		}
		if(StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_NAME", ""))) {
			partnerDto.setPartnerName(MapUtils.getString(params, "PARTNER_NAME"));
		}
		if(StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_TYPE", ""))) {
			partnerDto.setPartnerType(MapUtils.getInteger(params, "PARTNER_TYPE"));
		}
		return scfPartnerSearchService.searchPartnerListCount(partnerDto);
	}
	
	/**
	 * 保存合作商
	 */
	@Override
	public Integer savePartner(Map<String, Object> params) {
		ScfPartnerEditService scfPartnerEditService = (ScfPartnerEditService)ScfAdapter.getInstance("scfPartnerEditService");
		PartnerDto partnerDto = PartnerDto.copyMapToPartnerInfo(params);
		if (MapUtils.getObject(params, "MEMO")!=null) {
			if(StringUtils.isBlank(MapUtils.getString(params, "MEMO"))) {
				partnerDto.setMemo(" ");
			}
		}
		return scfPartnerEditService.savePartner(partnerDto);
	}

	/**
	 * 获取单个合作商
	 */
	@Override
	public PartnerDto getPartnerById(Long partnerId) throws BusinessException {
		return ((ScfPartnerSearchService) ScfAdapter.getInstance("scfPartnerSearchService"))
				.getPartnerInfoById(partnerId);
	}

	/**
	 * 删除合作商
	 */
	@Override
	public Integer deletePartner(Long partnerId) throws BusinessException {
		return ((ScfPartnerEditService) ScfAdapter.getInstance("scfPartnerEditService")).deletedPartner(partnerId);
	}
	
}
