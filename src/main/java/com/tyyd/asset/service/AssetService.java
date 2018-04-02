package com.tyyd.asset.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.dto.AssetRightDDto;
import com.tyyd.crps.scf.asset.dto.AssetRightTDto;
import com.tyyd.crps.scf.asset.dto.ConfigDto;

@Service
public interface AssetService {

	/**
	 * 获取资产列表
	 * 
	 * @param params
	 *            查询条件
	 * @return
	 */
	public List<AssetDto> searchReleaseList(Map<String, Object> params, String startRow, String endRow);

	/**
	 * 获取资产列表总记录数
	 * 
	 * @param params
	 *            查询条件
	 * @return
	 */
	public int searchReleaseListCount(Map<String, Object> params);

	/**
	 * 新增保存资产
	 * 
	 * @param params
	 * @return
	 */
	public Integer saveAssetForAdd(Map<String, Object> params);

	/**
	 * 获取版权权利项
	 * 
	 * @return
	 */
	public List<ConfigDto> getRightList();

	/**
	 * 获取资产基本信息
	 * 
	 * @return
	 */
	public AssetDto getAssetInfo(Long assetId);

	/**
	 * 获取资产权利项汇总信息
	 * 
	 * @return
	 */
	public List<AssetRightTDto> getAssetRightTList(Long assetId);

	/**
	 * 获取资产权利详情
	 * 
	 * @return
	 */
	public List<AssetRightDDto> getAssetRightDList(Long assetId, String rightCd, String rightName, String contractCd);

	/**
	 * 更新资产信息
	 * 
	 * @param params
	 * @return
	 */
	public Map<String, Object> editAssetInfo(Map<String, Object> params);

	/**
	 * 批量删除资产
	 * 
	 * @param params
	 * @return
	 */
	public Map<String, Object> deleteAssetInfos(Map<String, Object> params);

	/**
	 * 根据合同编号获取资产ID
	 * 
	 * @return
	 */
	public List<Long> selectAssetIdsByContractCd(String contractCd);
	
	/**
	 * 批量删除资产权利明细
	 * 删除完成后重新汇总资产汇总信息
	 * 
	 * @param params
	 * @return
	 */
	public Integer deleteAssetRightDs(List<Long> assetRightDIdList, Long assetId);
}
