package com.tyyd.value.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.tyyd.common.service.impl.CopyrightSystemBaseServiceImpl;
import com.tyyd.crps.scf.value.dto.AssetIncomeDetailDto;
import com.tyyd.crps.scf.value.dto.AssetIncomeTotalDto;
import com.tyyd.crps.scf.value.dto.AssetPayDetailDto;
import com.tyyd.crps.scf.value.dto.AssetPayTotalDto;
import com.tyyd.crps.scf.value.service.ScfAssetValueSearchService;
import com.tyyd.framework.core.BusinessException;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.value.service.ValueService;

@Service("valueService")
public class ValueServiceImpl extends CopyrightSystemBaseServiceImpl implements ValueService {

	@Override
	public List<AssetPayDetailDto> selectAssetPayDs(Long assetId, String payItemCd, String contractCd)
			throws BusinessException {
		if (assetId == null) {
			return null;
		}
		ScfAssetValueSearchService scfAssetValueSearchService = (ScfAssetValueSearchService) ScfAdapter
				.getInstance("scfAssetValueSearchService");
		List<AssetPayDetailDto> dataList = scfAssetValueSearchService.selectAssetPayDs(assetId, payItemCd, contractCd);
		if (dataList != null && dataList.size() > 0) {
			Map<String, Object> userIdAndName = new HashMap<String, Object>();
			for (AssetPayDetailDto assetPay : dataList) {
				userIdAndName = setBaseInfoUserName(userIdAndName, assetPay);
			}
		}
		return dataList;
	}

	@Override
	public List<AssetPayTotalDto> selectAssetPayTs(Long assetId, String payItemCd) throws BusinessException {
		if (assetId == null) {
			return null;
		}
		ScfAssetValueSearchService scfAssetValueSearchService = (ScfAssetValueSearchService) ScfAdapter
				.getInstance("scfAssetValueSearchService");
		List<AssetPayTotalDto> dataList = scfAssetValueSearchService.selectAssetPayTs(assetId, payItemCd);
		if (dataList != null && dataList.size() > 0) {
			Map<String, Object> userIdAndName = new HashMap<String, Object>();
			for (AssetPayTotalDto assetPay : dataList) {
				userIdAndName = setBaseInfoUserName(userIdAndName, assetPay);
			}
		}
		return dataList;
	}

	@Override
	public List<AssetIncomeDetailDto> selectAssetIncomeDs(Long assetId, String incomeItemCd, String contractCd)
			throws BusinessException {
		if (assetId == null) {
			return null;
		}
		ScfAssetValueSearchService scfAssetValueSearchService = (ScfAssetValueSearchService) ScfAdapter
				.getInstance("scfAssetValueSearchService");
		List<AssetIncomeDetailDto> dataList = scfAssetValueSearchService.selectAssetIncomeDs(assetId, incomeItemCd,
				contractCd);
		if (dataList != null && dataList.size() > 0) {
			Map<String, Object> userIdAndName = new HashMap<String, Object>();
			for (AssetIncomeDetailDto assetIncome : dataList) {
				userIdAndName = setBaseInfoUserName(userIdAndName, assetIncome);
			}
		}
		return dataList;
	}

	@Override
	public List<AssetIncomeTotalDto> selectAssetIncomeTs(Long assetId, String incomeItemCd) throws BusinessException {
		if (assetId == null) {
			return null;
		}
		ScfAssetValueSearchService scfAssetValueSearchService = (ScfAssetValueSearchService) ScfAdapter
				.getInstance("scfAssetValueSearchService");
		List<AssetIncomeTotalDto> dataList = scfAssetValueSearchService.selectAssetIncomeTs(assetId, incomeItemCd);
		if (dataList != null && dataList.size() > 0) {
			Map<String, Object> userIdAndName = new HashMap<String, Object>();
			for (AssetIncomeTotalDto assetIncome : dataList) {
				userIdAndName = setBaseInfoUserName(userIdAndName, assetIncome);
			}
		}
		return dataList;
	}

}
