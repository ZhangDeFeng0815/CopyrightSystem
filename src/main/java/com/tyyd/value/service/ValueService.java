package com.tyyd.value.service;

import java.util.List;

import com.tyyd.common.service.CopyrightSystemBaseService;
import com.tyyd.crps.scf.value.dto.AssetIncomeDetailDto;
import com.tyyd.crps.scf.value.dto.AssetIncomeTotalDto;
import com.tyyd.crps.scf.value.dto.AssetPayDetailDto;
import com.tyyd.crps.scf.value.dto.AssetPayTotalDto;
import com.tyyd.framework.core.BusinessException;

public interface ValueService extends CopyrightSystemBaseService {
	/**
	 * 根据资产ID查询成本明细
	 * 
	 * @param assetId
	 * @param payItemCd
	 * @param contractCd
	 * @return
	 * @throws BusinessException
	 */
	public List<AssetPayDetailDto> selectAssetPayDs(Long assetId, String payItemCd, String contractCd)
			throws BusinessException;

	/**
	 * 根据资产ID查询成本合计
	 * 
	 * @param assetId
	 * @param payItemCd
	 * @return
	 * @throws BusinessException
	 */
	public List<AssetPayTotalDto> selectAssetPayTs(Long assetId, String payItemCd) throws BusinessException;

	/**
	 * 根据资产ID查询收入明细
	 * 
	 * @param assetId
	 * @param incomeItemCd
	 * @param contractCd
	 * @return
	 * @throws BusinessException
	 */
	public List<AssetIncomeDetailDto> selectAssetIncomeDs(Long assetId, String incomeItemCd, String contractCd)
			throws BusinessException;

	/**
	 * 根据资产ID查询收入合计
	 * 
	 * @param assetId
	 * @param incomeItemCd
	 * @return
	 * @throws BusinessException
	 */
	public List<AssetIncomeTotalDto> selectAssetIncomeTs(Long assetId, String incomeItemCd) throws BusinessException;
}
