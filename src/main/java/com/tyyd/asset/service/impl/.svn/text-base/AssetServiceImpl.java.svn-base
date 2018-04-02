package com.tyyd.asset.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.tyyd.asset.service.AssetService;
import com.tyyd.common.po.ConfigInfo;
import com.tyyd.common.service.impl.CopyrightSystemBaseServiceImpl;
import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.dto.AssetRightDDto;
import com.tyyd.crps.scf.asset.dto.AssetRightTDto;
import com.tyyd.crps.scf.asset.dto.ConfigDto;
import com.tyyd.crps.scf.asset.service.ScfAssetEditService;
import com.tyyd.crps.scf.asset.service.ScfAssetSearchService;
import com.tyyd.crps.scf.contract.service.ScfContractEditService;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.BaseDataUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;

/**
 * @author QinTao
 *
 */
@Service
public class AssetServiceImpl extends CopyrightSystemBaseServiceImpl implements AssetService {
	private static final Logger logger = LoggerFactory.getLogger(AssetServiceImpl.class);

	private AssetDto getSearchAssetsParams(Map<String, Object> params) {
		AssetDto assetSearchParams = AssetDto.copyMapToAssetInfo(params);

		List<String> assetCdList = null;
		String assetCds = MapUtils.getString(params, "ASSET_CDS", "").trim();// 资产编号
		if (StringUtils.isNotBlank(assetCds)) {
			assetCdList = new ArrayList<String>();
			assetCdList.addAll(Arrays.asList(assetCds.split("\\|")));
			assetSearchParams.setAssetCdList(assetCdList);
		}

		List<String> wkNameList = null;
		String wkNames = MapUtils.getString(params, "WK_NAMES", "").trim();// 作品名称
		if (StringUtils.isNotBlank(wkNames)) {
			wkNameList = new ArrayList<String>();
			wkNameList.addAll(Arrays.asList(wkNames.split("\\|")));
			assetSearchParams.setWkNameList(wkNameList);
		}

		List<ConfigInfo> rightBlist = new ArrayList<ConfigInfo>();
		String rights = MapUtils.getString(params, "RIGHTS", "").trim();// 权利项
		if (StringUtils.isNotBlank(rights)) {
			String[] rightArr = rights.split(",");
			for (String rightStr : rightArr) {
				if (StringUtils.isNotBlank(rightStr)) {
					ConfigInfo config = new ConfigInfo();
					config.setCd(rightStr);
					rightBlist.add(config);
				}
			}
			if (rightBlist.size() > 0) {
				assetSearchParams.setRightBlist(rightBlist);
			}
		}

		String startCreateDate = MapUtils.getString(params, "CREATE_DATE_FROM", "").trim();// 开始入库时间
		if (StringUtils.isNotBlank(startCreateDate)) {
			assetSearchParams.setStartCreateDate(startCreateDate);
		}

		String endCreateDate = MapUtils.getString(params, "CREATE_DATE_TO", "").trim();// 结束入库时间
		if (StringUtils.isNotBlank(endCreateDate)) {
			assetSearchParams.setEndCreateDate(endCreateDate);
		}
		return assetSearchParams;
	}

	@Override
	public List<AssetDto> searchReleaseList(Map<String, Object> params, String startRow, String endRow) {
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		AssetDto assetSearchParams = getSearchAssetsParams(params);
		assetSearchParams.setStartRow(startRow);
		assetSearchParams.setEndRow(endRow);
		List<AssetDto> dataList = scfAssetSearchService.searchAssetList(assetSearchParams);
		if (dataList != null && dataList.size() > 0) {
			Map<String, Object> userIdAndName = new HashMap<String, Object>();
			for (AssetDto asset : dataList) {
				asset.setTotalPayStr(convertNumber(String.valueOf(asset.getTotalPay()), 100, 2));
				asset.setTotalIncomeStr(convertNumber(String.valueOf(asset.getTotalIncome()), 100, 2));
				userIdAndName = setBaseInfoUserName(userIdAndName, asset);
			}
		}
		return dataList;
	}

	@Override
	public int searchReleaseListCount(Map<String, Object> params) {
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		return scfAssetSearchService.searchAssetListCount(getSearchAssetsParams(params));
	}

	@Override
	public Integer saveAssetForAdd(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ConfigDto> getRightList() {
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		// 1:版权权利项
		return scfAssetSearchService.searchConfigs(1, null);
	}

	@Override
	public AssetDto getAssetInfo(Long assetId) {
		if (assetId == null) {
			return null;
		}
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		AssetDto asset = scfAssetSearchService.getAssetInfoById(assetId);
		if (asset == null) {
			return null;
		}
		asset.setMediaTypeName(BaseDataUtils.getText("2", String.valueOf(asset.getMediaTypeId())));
		asset.setWkClassName(BaseDataUtils.getText("3", String.valueOf(asset.getWkClass())));
		asset.setCreateUserName(getUserNameById(String.valueOf(asset.getCreateUserId())));
		return asset;
	}

	@Override
	public List<AssetRightTDto> getAssetRightTList(Long assetId) {
		if (assetId == null) {
			return null;
		}
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		List<AssetRightTDto> dataList = scfAssetSearchService.selectAssetRightTs(assetId);
		return dataList;
	}

	@Override
	public List<AssetRightDDto> getAssetRightDList(Long assetId, String rightCd, String rightName, String contractCd) {
		if (assetId == null) {
			return null;
		}
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		List<AssetRightDDto> dataList = scfAssetSearchService.selectAssetRightDs(assetId, rightCd, rightName,
				contractCd);
		return dataList;
	}

	/**
	 * 更新资产信息
	 */
	@Override
	public Map<String, Object> editAssetInfo(Map<String, Object> params) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "success", false);
		Long assetId = MapUtils.getLong(params, "assetId");
		Integer wordCount = MapUtils.getInteger(params, "wordCount");
		Integer wkClass = MapUtils.getInteger(params, "wkClass");
		String isbnNum = MapUtils.getString(params, "isbnNum");
		AssetDto dto = new AssetDto();
		dto.setAssetId(assetId);
		dto.setWordCount(wordCount);
		dto.setWkClass(wkClass);
		dto.setIsbnNum(isbnNum);
		ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter.getInstance("scfAssetEditService");
		Integer ret = scfAssetEditService.editAssetInfo(dto, Security.getCurrentUserID());
		if (ret > 0) {
			MapUtils.safeAddToMap(retMap, "success", true);
		}
		return retMap;
	}

	/**
	 * 批量删除资产
	 */
	@Override
	public Map<String, Object> deleteAssetInfos(Map<String, Object> params) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "success", false);
		// 1.校验删除的资产是否[无收入、无成本]合同
		String[] assetArr = StringUtils.split(MapUtils.getString(params, "ASSET_ID_CDS"), "|");
		if (assetArr.length == 0) {
			return retMap;
		}
		ScfContractEditService scfContractEditService = (ScfContractEditService) ScfAdapter
				.getInstance("scfContractEditService");
		StringBuilder sb = new StringBuilder();
		List<Long> assetIdList = new ArrayList<Long>(assetArr.length);
		for (String item : assetArr) {
			String[] codeArr = StringUtils.split(item, ":");
			Integer ret = scfContractEditService.countContractByAId(Long.valueOf(codeArr[0]));
			if (ret > 0) {
				sb.append(codeArr[1]).append(",");
			} else {
				assetIdList.add(Long.valueOf(codeArr[0]));
			}
		}
		if (sb.length() > 0) {
			sb.append("选定的部分资产存在收入或成本合同。");
			MapUtils.safeAddToMap(retMap, "msg", sb.toString());
			return retMap;
		}
		// 2.删除资产
		ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter.getInstance("scfAssetEditService");
		Integer delCnt = scfAssetEditService.deleteAssetInfos(assetIdList, Security.getCurrentUserID());
		if (delCnt > 0) {
			MapUtils.safeAddToMap(retMap, "msg", String.format("%s条资产删除成功！", delCnt));
		}
		MapUtils.safeAddToMap(retMap, "success", true);
		return retMap;
	}

	@Override
	public List<Long> selectAssetIdsByContractCd(String contractCd) {
		return ((ScfAssetSearchService) ScfAdapter.getInstance("scfAssetSearchService"))
				.selectAssetIdsByContractCd(contractCd);
	}

	@Override
	public Integer deleteAssetRightDs(List<Long> assetRightDIdList, Long assetId) {
		int ret = 0;
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		List<String> contractCdList = new ArrayList<String>();
		if (assetRightDIdList != null && assetRightDIdList.size() > 0 && assetId != null) {

			ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter
					.getInstance("scfAssetEditService");
			for (Long assetRightDId : assetRightDIdList) {
				AssetRightDDto assetRightD = scfAssetSearchService.getAssetRightDById(assetRightDId, assetId);
				if (assetRightD != null) {
					contractCdList.add(assetRightD.getContractCd());
				}
				Integer dInt = scfAssetEditService.deleteAssetRightDById(assetRightDId, assetId);
				if (dInt > 0) {
					ret++;
				}
			}
			AssetDto asset = scfAssetSearchService.getAssetInfoById(assetId);
			scfAssetEditService.syncRight(contractCdList, asset.getAssetCd(), Security.getCurrentUserID());
		}

		return ret;
	}

}
