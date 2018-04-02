/**
 * 版权所有：天翼文化
 * 项目名称: 文字资产平台
 * 文件说明: 资产管理
 */
package com.tyyd.asset.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tyyd.asset.service.AssetService;
import com.tyyd.contract.service.ContractService;
import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.dto.AssetRightDDto;
import com.tyyd.crps.scf.asset.dto.AssetRightTDto;
import com.tyyd.crps.scf.asset.dto.ConfigDto;
import com.tyyd.crps.scf.contract.service.dto.ContractInDto;
import com.tyyd.framework.core.ajax.AjaxParam;
import com.tyyd.framework.core.ajax.AjaxParams;
import com.tyyd.framework.core.ajax.GridSettings;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.WebUtil;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;
import com.tyyd.framework.web.grid.IPageCount;
import com.tyyd.framework.web.grid.PageGridData;
import com.tyyd.partner.service.PartnerService;

@Controller
@RequestMapping("/asset")
public class AssetController {

	private static final Logger log = LoggerFactory.getLogger(AssetController.class);

	@Resource
	private AssetService assetService;

	@Resource
	private PartnerService partnerService;

	@Resource
	private ContractService contractService;

	/**
	 * 获取资产列表
	 */
	@RequestMapping(value = "/getReleaseList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doGetReleaseList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		HashMap<String, Object> params = inputData.getParams();
		GridSettings gs = inputData.getPagedGridSettings();
		List<AssetDto> list = assetService.searchReleaseList(params, String.valueOf(gs.getStartRow()),
				String.valueOf(gs.getEndRow()));
		PageGridData outputData = new PageGridData();
		outputData.setPageData(inputData, list, new IPageCount() {
			@Override
			public int getPageCount() {
				// 取得总记录条数
				return assetService.searchReleaseListCount(params);
			}
		});
		return outputData;
	}

	/**
	 * 获取权利项
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/right/getRightList.ajax")
	@ResponseBody
	public Map<String, Object> doGetRightList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("getRightList Start");
		List<ConfigDto> rightList = assetService.getRightList();
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		for (ConfigDto config : rightList) {
			Map<String, Object> configMap = new HashMap<String, Object>();
			MapUtils.safeAddToMap(configMap, "value", config.getCd());
			MapUtils.safeAddToMap(configMap, "label", config.getName());
			dataList.add(configMap);
		}
		HashMap<String, Object> outputData = new HashMap<String, Object>();
		MapUtils.safeAddToMap(outputData, "dataList", dataList);
		log.debug("getRightList End");
		return outputData;
	}

	/**
	 * 获取资产基本信息
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getAssetInfo.ajax")
	@ResponseBody
	public Map<String, Object> doGetAssetInfo(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("getAssetInfo Start");
		HashMap<String, Object> params = inputData.getParams();
		AssetDto asset = assetService.getAssetInfo(MapUtils.getLong(params, "assetId", null));
		HashMap<String, Object> outputData = new HashMap<String, Object>();
		MapUtils.safeAddToMap(outputData, "asset", asset);
		log.debug("getAssetInfo End");
		return outputData;
	}

	/**
	 * 根据资产ID获取权利项汇总信息
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/right/getAssetRightTList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doGetAssetRightTList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("getAssetRightTList Start");
		HashMap<String, Object> params = inputData.getParams();

		List<AssetRightTDto> list = assetService.getAssetRightTList(MapUtils.getLong(params, "assetId", null));
		// 列表数据格式化
		String dataList = WebUtil.toGridXml(list, inputData.getGridSettings("gridSettings"));

		HashMap<String, Object> outputData = new HashMap<String, Object>();
		MapUtils.safeAddToMap(outputData, "dataList", dataList);
		log.debug("getAssetRightTList End");
		return outputData;
	}

	/**
	 * 根据资产ID获取权利详情
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/right/getAssetRightDList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doGetAssetRightDList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("getAssetRightDList Start");
		HashMap<String, Object> params = inputData.getParams();

		List<AssetRightDDto> list = assetService.getAssetRightDList(MapUtils.getLong(params, "assetId", null),
				MapUtils.getString(params, "rightCd", null), MapUtils.getString(params, "rightName", null),
				MapUtils.getString(params, "contractCd", null));
		// 列表数据格式化
		String dataList = WebUtil.toGridXml(list, inputData.getGridSettings("gridSettings"));

		HashMap<String, Object> outputData = new HashMap<String, Object>();
		MapUtils.safeAddToMap(outputData, "dataList", dataList);
		log.debug("getAssetRightDList End");
		return outputData;
	}

	/**
	 * 批量删除资产权利明细
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/right/deleteAssetRightDs.ajax")
	@ResponseBody
	public Map<String, Object> doDeleteAssetRightDs(@AjaxParam final AjaxParams inputData, HttpServletRequest request)throws Exception {
		log.debug("deleteAssetRightDs Start");
		HashMap<String, Object> params = inputData.getParams();
		String[] assetRightDIdArr = StringUtils.split(MapUtils.getString(params, "assetRightDIds"), ",");
		List<Long> assetRightDIdList = new ArrayList<Long>();
		for (String assetRightDId : assetRightDIdArr) {
			assetRightDIdList.add(Long.valueOf(assetRightDId));
		}
		int totalNum = assetRightDIdArr.length;
		Map<String, Object> outputData = new HashMap<String, Object>();
		int successNum = assetService.deleteAssetRightDs(assetRightDIdList, MapUtils.getLong(params, "assetId"));
		int failNum = totalNum-successNum;
		String msg = "";
		if(totalNum>0){
			msg += "共删除"+totalNum+"条权利明细";
		}
		if(successNum>0){
			msg += "，删除成功"+successNum+"条权利明细";
		}
		if(failNum>0){
			msg += "，删除失败"+failNum+"条权利明细";
		}
		MapUtils.safeAddToMap(outputData, "success", true);
		MapUtils.safeAddToMap(outputData, "msg", msg);
		log.debug("deleteAssetRightDs End");
		return outputData;
	}
	
	/**
	 * 获取资产基本信息
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editAssetInfo.ajax")
	@ResponseBody
	public Map<String, Object> doEditAssetInfo(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("editAssetInfo Start");
		Map<String, Object> outputData = assetService.editAssetInfo(inputData.getParams());
		log.debug("editAssetInfo End");
		return outputData;
	}

	/**
	 * 批量删除资产
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteAssetInfos.ajax")
	@ResponseBody
	public Map<String, Object> doDeleteAssetInfos(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("deleteAssetInfos Start");
		Map<String, Object> outputData = assetService.deleteAssetInfos(inputData.getParams());
		log.debug("deleteAssetInfos End");
		return outputData;
	}

	/**
	 * 第一步校验合同编号的有效性 校验合同编号是否已经导入过权利
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkContractCdOfAsset.ajax")
	@ResponseBody
	public Map<String, Object> doCheckContractCdOfAsset(@AjaxParam final AjaxParams inputData,
			HttpServletRequest request) throws Exception {
		log.debug("checkContractCdOfAsset Start");
		HashMap<String, Object> outputData = new HashMap<String, Object>();
		MapUtils.safeAddToMap(outputData, "success", false);
		HashMap<String, Object> params = inputData.getParams();
		// 第一步校验合同的有效性
		ContractInDto contractIn = contractService
				.getContractInInfoByContractCd(MapUtils.getString(params, "contractCd", ""));
		if (contractIn != null && contractIn.getContractId() != null) {
			MapUtils.safeAddToMap(outputData, "success", true);
		} else {
			return outputData;
		}
		List<Long> assetIds = assetService.selectAssetIdsByContractCd(MapUtils.getString(params, "contractCd", ""));
		if (assetIds != null && assetIds.size() > 0) {
			MapUtils.safeAddToMap(outputData, "assetIds", assetIds);
		}
		log.debug("checkContractCdOfAsset End");
		return outputData;
	}
}
