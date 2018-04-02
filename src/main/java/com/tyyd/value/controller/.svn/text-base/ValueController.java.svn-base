/**
 * 版权所有：天翼文化
 * 项目名称: 文字资产平台
 * 文件说明: 价值管理
 */
package com.tyyd.value.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.tyyd.asset.service.AssetService;
import com.tyyd.contract.service.ContractService;
import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.value.dto.AssetIncomeDetailDto;
import com.tyyd.crps.scf.value.dto.AssetIncomeTotalDto;
import com.tyyd.crps.scf.value.dto.AssetPayDetailDto;
import com.tyyd.crps.scf.value.dto.AssetPayTotalDto;
import com.tyyd.framework.core.ajax.AjaxParam;
import com.tyyd.framework.core.ajax.AjaxParams;
import com.tyyd.framework.core.ajax.GridSettings;
import com.tyyd.framework.core.util.DateUtil;
import com.tyyd.framework.core.util.WebUtil;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;
import com.tyyd.framework.web.grid.IPageCount;
import com.tyyd.framework.web.grid.PageGridData;
import com.tyyd.value.service.ValueService;

@RestController
@RequestMapping("/value")
public class ValueController {

	private static final Logger log = LoggerFactory.getLogger(ValueController.class);

	@Resource
	private AssetService assetService;

	@Resource
	private ContractService contractService;

	@Resource
	private ValueService valueService;

	/**
	 * 判断授权合同编号是否有效
	 */
	@RequestMapping(value = "/getAssetValueList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doGetAssetValueList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
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
	 * 判断收入合同是否存在
	 */
	@RequestMapping(value = "/outContractCdExistsChk.ajax", method = RequestMethod.POST)
	public Map<String, Object> doOutContractCdExistsChk(@AjaxParam final AjaxParams inputData,
			HttpServletRequest request) throws Exception {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "success",
				contractService.contractOutExistsChk(inputData.getParamString("CONTRACT_CD")));
		return retMap;
	}

	/**
	 * 判断获权合同是否有效
	 */
	@RequestMapping(value = "/inContractCdExistsChk.ajax", method = RequestMethod.POST)
	public Map<String, Object> doInContractCdExistsChk(@AjaxParam final AjaxParams inputData,
			HttpServletRequest request) throws Exception {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "success",
				contractService.contractInExistsChk(inputData.getParamString("CONTRACT_CD")));
		return retMap;
	}

	/**
	 * 获取资产成本信息
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getAssetPay.ajax")
	@ResponseBody
	public Map<String, Object> doGetAssetPay(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("getAssetPay Start");
		Map<String, Object> outputData = new HashMap<String, Object>();
		HashMap<String, Object> params = inputData.getParams();
		Long assetId = MapUtils.getLong(params, "assetId", null);
		if (assetId == null) {
			return outputData;
		}
		// 获取资产成本合计
		List<AssetPayTotalDto> assetPayTList = valueService.selectAssetPayTs(assetId, null);
		if (assetPayTList != null && assetPayTList.size() > 0) {
			for (AssetPayTotalDto assetPayTotalDto : assetPayTList) {
				if (StringUtils.isBlank(assetPayTotalDto.getPayItemCd())) {
					continue;
				}
				MapUtils.safeAddToMap(outputData, "pay" + assetPayTotalDto.getPayItemCd(),
						valueService.convertNumber(String.valueOf(assetPayTotalDto.getMoney()), 100, 2));
			}
		}

		// 不存在的成本项默认显示0.00
		List<String> numTList = new ArrayList<String>();
		for (int i = 0; i < 5; i++) {
			if (!outputData.containsKey("pay" + (i + 1))) {
				MapUtils.safeAddToMap(outputData, "pay" + (i + 1), "0.00");
			}
			numTList.add(MapUtils.getString(outputData, "pay" + (i + 1)));
		}
		// 计算合计
		MapUtils.safeAddToMap(outputData, "payTotal", valueService.bigDecimalAdd(numTList));
		// 获取资产成本明细
		Map<String, Map<String, Object>> createDateMap = new HashMap<String, Map<String, Object>>();
		List<AssetPayDetailDto> assetPayDList = valueService.selectAssetPayDs(assetId, null, null);
		List<Map<String, Object>> assetPayDs = new ArrayList<Map<String, Object>>();
		if (assetPayDList != null && assetPayDList.size() > 0) {
			for (AssetPayDetailDto assetPayDetailDto : assetPayDList) {
				MapUtils.safeAddToMap(createDateMap, DateUtil.formatTimeMilliSecond(assetPayDetailDto.getCreateDate()),
						new HashMap<String, Object>());
			}
		}
		if (createDateMap.size() > 0) {
			for (String createTimeMilliSecond : createDateMap.keySet()) {
				Map<String, Object> assetPayDetail = createDateMap.get(createTimeMilliSecond);
				for (AssetPayDetailDto assetPayDetailDto : assetPayDList) {
					if (StringUtils.equals(createTimeMilliSecond,
							DateUtil.formatTimeMilliSecond(assetPayDetailDto.getCreateDate()))) {
						if (StringUtils.isBlank(assetPayDetailDto.getPayItemCd())) {
							continue;
						}
						MapUtils.safeAddToMap(assetPayDetail, "PAY_" + assetPayDetailDto.getPayItemCd(),
								valueService.convertNumber(String.valueOf(assetPayDetailDto.getMoney()), 100, 2));

						// 每行相同的数据只放一次
						if (!assetPayDetail.containsKey("CONTRACT_CD"))
							MapUtils.safeAddToMap(assetPayDetail, "CONTRACT_CD", assetPayDetailDto.getContractCd());
						if (!assetPayDetail.containsKey("CREATE_DATE"))
							MapUtils.safeAddToMap(assetPayDetail, "CREATE_DATE", assetPayDetailDto.getCreateDate());
						if (!assetPayDetail.containsKey("CREATE_USERNAME"))
							MapUtils.safeAddToMap(assetPayDetail, "CREATE_USERNAME",
									assetPayDetailDto.getCreateUserName());
					}
				}
				// 不存在的成本项默认显示0.00
				List<String> numDList = new ArrayList<String>();
				for (int i = 0; i < 5; i++) {
					if (!assetPayDetail.containsKey("PAY_" + (i + 1))) {
						MapUtils.safeAddToMap(assetPayDetail, "PAY_" + (i + 1), "0.00");
					}
					numDList.add(MapUtils.getString(assetPayDetail, "PAY_" + (i + 1)));
				}
				// 计算合计
				MapUtils.safeAddToMap(assetPayDetail, "TOTAL", valueService.bigDecimalAdd(numDList));
				assetPayDs.add(assetPayDetail);
			}
		}
		if (assetPayDs.size() > 0) {
			// 列表数据格式化
			String dataList = WebUtil.toGridXml(assetPayDs, inputData.getGridSettings("gridSettings"));
			MapUtils.safeAddToMap(outputData, "dataList", dataList);
		}
		log.debug("getAssetPay End");
		return outputData;
	}

	/**
	 * 获取资产收入信息
	 * 
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getAssetIncome.ajax")
	@ResponseBody
	public Map<String, Object> doGetAssetIncome(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		log.debug("getAssetIncome Start");
		Map<String, Object> outputData = new HashMap<String, Object>();
		HashMap<String, Object> params = inputData.getParams();
		Long assetId = MapUtils.getLong(params, "assetId", null);
		if (assetId == null) {
			return outputData;
		}
		// 获取资产收入合计
		List<AssetIncomeTotalDto> assetIncomeTList = valueService.selectAssetIncomeTs(assetId, null);
		if (assetIncomeTList != null && assetIncomeTList.size() > 0) {
			for (AssetIncomeTotalDto assetIncomeTotalDto : assetIncomeTList) {
				if (StringUtils.isBlank(assetIncomeTotalDto.getIncomeItemCd())) {
					continue;
				}
				MapUtils.safeAddToMap(outputData, "income" + assetIncomeTotalDto.getIncomeItemCd(),
						valueService.convertNumber(String.valueOf(assetIncomeTotalDto.getMoney()), 100, 2));
			}
		}

		// 不存在的成本项默认显示0.00
		List<String> numTList = new ArrayList<String>();
		for (int i = 0; i < 5; i++) {
			if (!outputData.containsKey("income" + (i + 1))) {
				MapUtils.safeAddToMap(outputData, "income" + (i + 1), "0.00");
			}
			numTList.add(MapUtils.getString(outputData, "income" + (i + 1)));
		}
		// 计算合计
		MapUtils.safeAddToMap(outputData, "incomeTotal", valueService.bigDecimalAdd(numTList));
		// 获取资产成本明细
		Map<String, Map<String, Object>> createDateMap = new HashMap<String, Map<String, Object>>();
		List<AssetIncomeDetailDto> assetIncomeDList = valueService.selectAssetIncomeDs(assetId, null, null);
		List<Map<String, Object>> assetIncomeDs = new ArrayList<Map<String, Object>>();
		if (assetIncomeDList != null && assetIncomeDList.size() > 0) {
			for (AssetIncomeDetailDto assetIncomeDetailDto : assetIncomeDList) {
				MapUtils.safeAddToMap(createDateMap,
						DateUtil.formatTimeMilliSecond(assetIncomeDetailDto.getCreateDate()),
						new HashMap<String, Object>());
			}
		}
		if (createDateMap.size() > 0) {
			for (String createTimeMilliSecond : createDateMap.keySet()) {
				Map<String, Object> assetIncomeDetail = createDateMap.get(createTimeMilliSecond);
				for (AssetIncomeDetailDto assetIncomeDetailDto : assetIncomeDList) {
					if (StringUtils.equals(createTimeMilliSecond,
							DateUtil.formatTimeMilliSecond(assetIncomeDetailDto.getCreateDate()))) {
						if (StringUtils.isBlank(assetIncomeDetailDto.getIncomeItemCd())) {
							continue;
						}
						MapUtils.safeAddToMap(assetIncomeDetail, "INCOME_" + assetIncomeDetailDto.getIncomeItemCd(),
								valueService.convertNumber(String.valueOf(assetIncomeDetailDto.getMoney()), 100, 2));

						// 每行相同的数据只放一次
						if (!assetIncomeDetail.containsKey("CONTRACT_CD"))
							MapUtils.safeAddToMap(assetIncomeDetail, "CONTRACT_CD",
									assetIncomeDetailDto.getContractCd());
						if (!assetIncomeDetail.containsKey("CREATE_DATE"))
							MapUtils.safeAddToMap(assetIncomeDetail, "CREATE_DATE",
									assetIncomeDetailDto.getCreateDate());
						if (!assetIncomeDetail.containsKey("CREATE_USERNAME"))
							MapUtils.safeAddToMap(assetIncomeDetail, "CREATE_USERNAME",
									assetIncomeDetailDto.getCreateUserName());
					}
				}
				// 不存在的成本项默认显示0.00
				List<String> numDList = new ArrayList<String>();
				for (int i = 0; i < 5; i++) {
					if (!assetIncomeDetail.containsKey("INCOME_" + (i + 1))) {
						MapUtils.safeAddToMap(assetIncomeDetail, "INCOME_" + (i + 1), "0.00");
					}
					numDList.add(MapUtils.getString(assetIncomeDetail, "INCOME_" + (i + 1)));
				}
				// 计算合计
				MapUtils.safeAddToMap(assetIncomeDetail, "TOTAL", valueService.bigDecimalAdd(numDList));
				assetIncomeDs.add(assetIncomeDetail);
			}
		}
		if (assetIncomeDs.size() > 0) {
			// 列表数据格式化
			String dataList = WebUtil.toGridXml(assetIncomeDs, inputData.getGridSettings("gridSettings"));
			MapUtils.safeAddToMap(outputData, "dataList", dataList);
		}
		log.debug("getAssetPay End");
		return outputData;
	}
}
