package com.tyyd.asset.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.dto.AssetRightDDto;
import com.tyyd.crps.scf.asset.dto.ConfigDto;
import com.tyyd.crps.scf.asset.service.ScfAssetEditService;
import com.tyyd.crps.scf.asset.service.ScfAssetSearchService;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.BaseDataUtils;
import com.tyyd.framework.core.util.DateUtil;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.excelimport.ErrorMsg;
import com.tyyd.framework.excelimport.ExcelDataBean;
import com.tyyd.framework.excelimport.ExcelRowBean;
import com.tyyd.framework.excelimport.ExcelSheetBean;
import com.tyyd.framework.excelimport.model.ColTemplate;
import com.tyyd.framework.excelimport.model.SheetTemplate;
import com.tyyd.framework.excelimport.service.impl.ExcelImport2BaseService;
import com.tyyd.framework.upload.common.UploadStatus;

@Service("assetRightDImportService")
public class AssetRightDImportServiceImpl extends ExcelImport2BaseService {

	@Override
	public String getTempletePath() {
		return "classpath:template/assetRightDParseRule.xlsx";
	}

	@Override
	public ErrorMsg doCellValidate(MultipartHttpServletRequest request, HttpServletResponse reponse,
			SheetTemplate sheetTemplate, ColTemplate colTemplete, ArrayList<ExcelRowBean> allRowDatas,
			ExcelRowBean rowBean, String val, Map<String, String> params) throws Throwable {
		String colName = colTemplete.getName();

		// 资产编号的校验
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		if ("ASSET_CD".equals(colName)) {
			AssetDto asset = scfAssetSearchService.getAssetInfoByAssetCd(StringUtils.trim(val));
			if (asset == null || StringUtils.isBlank(asset.getWkName())) {
				return new ErrorMsg(colTemplete, rowBean, "无效的资产编号！");
			}
		}
		// 权利的名称
		if ("RIGHT_NAME".equals(colName)) {
			List<ConfigDto> configs = scfAssetSearchService.searchConfigs(1, StringUtils.trim(val));
			if (configs == null || configs.size() < 1) {
				return new ErrorMsg(colTemplete, rowBean, "权利名称填写有误！");
			}
		}

		if ("DATE_FROM".equals(colName)) {
			try {
				DateUtil.formatYYYYMMDD_(DateUtil.parseDate(StringUtils.trim(val)));
			} catch (Exception e) {
				return new ErrorMsg(colTemplete, rowBean, "权利开始日期填写有误！");
			}
		}

		if ("DATE_TO".equals(colName)) {
			try {
				DateUtil.formatYYYYMMDD_(DateUtil.parseDate(StringUtils.trim(val)));
			} catch (Exception e) {
				return new ErrorMsg(colTemplete, rowBean, "权利结束日期填写有误！");
			}
		}

		if ("CAN_RESALE_SHOW".equals(colName)) {
			String canResale = BaseDataUtils.getValue("4", String.valueOf(StringUtils.trim(val)));
			if (StringUtils.isBlank(canResale)) {
				return new ErrorMsg(colTemplete, rowBean, "是否可转述填写有误！");
			}
		}

		if ("AT_TYPE_SHOW".equals(colName)) {
			String atType = BaseDataUtils.getValue("5", String.valueOf(StringUtils.trim(val)));
			if (StringUtils.isBlank(atType)) {
				return new ErrorMsg(colTemplete, rowBean, "授权方式填写有误！");
			}
		}

		if ("REGION_SHOW".equals(colName)) {
			String region = BaseDataUtils.getValue("6", String.valueOf(StringUtils.trim(val)));
			if (StringUtils.isBlank(region)) {
				return new ErrorMsg(colTemplete, rowBean, "授权范围填写有误！");
			}
		}

		return null;
	}

	/**
	 * 批量保存数据
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> doSaveData(MultipartHttpServletRequest request, HttpServletResponse reponse,
			CommonsMultipartFile file, ExcelDataBean excelData, ArrayList<SheetTemplate> templeteList,
			Map<String, String> params, UploadStatus status) throws Throwable {
		String importType = MapUtils.getString(params, "importType");
		String contractCd = MapUtils.getString(params, "contractCd");
		Map<String, Object> ret = new HashMap<String, Object>();
		MapUtils.safeAddToMap(ret, "SUCC_ROWCNT", 0);
		MapUtils.safeAddToMap(ret, "INFO_MSG", "已导入0条记录,以下记录有误,请修改后重新导入!请确认!");

		int succCnt = 0;
		int dataCnt = excelData.getTotalRowCount();
		if (dataCnt < 1) {
			ExceptionUtils.throwAcwsException("Excel内数据为空，无需要导入的权利");
		}
		// 第一步获取基本校验错误数据
		List<ExcelRowBean> errList = excelData.getErrorData(0);
		// 第二步校验正确的数据的有无重复数据
		ColTemplate wkNameTmp = templeteList.get(0).getColTemplates().get(0);
		Map<String, List<ExcelRowBean>> retMap = dataExistsFilter(excelData.getNoerrData(0), wkNameTmp);
		errList.addAll((Collection<? extends ExcelRowBean>) MapUtils.getObject(retMap, "ERRLIST"));
		List<ExcelRowBean> noErrList = (List<ExcelRowBean>) MapUtils.getObject(retMap, "NOERRLIST");
		// 存在校验错误数据，不执行导入数据
		if (errList.size() > 0) {
			// 4.重新设置错误列表
			ExcelSheetBean sheetBean = excelData.getSheet(0);
			sheetBean.setRows(errList);
			List<ExcelSheetBean> errorDatas = new ArrayList<ExcelSheetBean>();
			errorDatas.add(sheetBean);
			excelData.setErrorDatas(errorDatas);
			return ret;
		}
		// 如果是修改导入权利明细，先清空该合同的所有权利明细
		if (StringUtils.equals(importType, "edit")) {
			deleteAssetRightDByContractCd(contractCd);
		}
		Map<String, Object> assetCdMap = new HashMap<String, Object>();
		for (ExcelRowBean rowBean : noErrList) {
			int retInt = 0;
			try {
				retInt = getImportAssetRightD(rowBean, contractCd);
				if (!assetCdMap.containsKey(rowBean.getValue("ASSET_CD"))) {
					MapUtils.safeAddToMap(assetCdMap, rowBean.getValue("ASSET_CD"), rowBean.getValue("ASSET_CD"));
				}
			} catch (Exception e) {
				continue;
			}
			if (retInt > 0) {
				succCnt++;
			}

		}

		if (succCnt != dataCnt) {
			ExceptionUtils.throwAcwsException("资产权利数据导入错误，请稍后重试");
		}
		// 导入权利明细完成后，同步权利汇总
		doSyncRight(contractCd, assetCdMap);
		MapUtils.safeAddToMap(ret, "SUCC_ROWCNT", succCnt);
		MapUtils.safeAddToMap(ret, "INFO_MSG", "共成功导入"+succCnt+"条记录");
		return ret;
	}

	private int getImportAssetRightD(ExcelRowBean rowBean, String contractCd) {
		// 调用scf接口插入一条资产权利
		ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter.getInstance("scfAssetEditService");
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		AssetRightDDto assetRightD = new AssetRightDDto();
		assetRightD.setAssetCd(rowBean.getValue("ASSET_CD"));
		assetRightD.setContractCd(contractCd);
		List<ConfigDto> configs = scfAssetSearchService.searchConfigs(1,
				StringUtils.trim(rowBean.getValue("RIGHT_NAME")));
		assetRightD.setRightCd(configs.get(0).getCd());
		assetRightD.setDateFrom(DateUtil.parseDate(rowBean.getValue("DATE_FROM")));
		assetRightD.setDateTo(DateUtil.parseDate(rowBean.getValue("DATE_TO")));
		assetRightD.setAtType(Integer.valueOf(
				BaseDataUtils.getValue("5", String.valueOf(StringUtils.trim(rowBean.getValue("AT_TYPE_SHOW"))))));
		assetRightD.setRegion(Integer.valueOf(
				BaseDataUtils.getValue("6", String.valueOf(StringUtils.trim(rowBean.getValue("REGION_SHOW"))))));
		assetRightD.setCanResale(Integer.valueOf(
				BaseDataUtils.getValue("4", String.valueOf(StringUtils.trim(rowBean.getValue("CAN_RESALE_SHOW"))))));
		assetRightD.setUpdateUserId(Security.getCurrentUserID());
		assetRightD.setCreateUserId(Security.getCurrentUserID());
		return scfAssetEditService.saveAssetRightD(assetRightD);

	}

	// 插入权利明细完成后同步汇总表
	private void doSyncRight(String contractCd, Map<String, Object> assetCdMap) {
		if (assetCdMap == null || assetCdMap.size() < 1) {
			return;
		}
		List<String> contractCdList = new ArrayList<String>();
		contractCdList.add(contractCd);
		ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter.getInstance("scfAssetEditService");
		for (String assetCd : assetCdMap.keySet()) {
			if (StringUtils.isNotBlank(assetCd)) {
				scfAssetEditService.syncRight(contractCdList, assetCd, Security.getCurrentUserID());
			}
		}

		// 调用scf接口插入一条资产权利
	}

	/**
	 * 根据合同编号删除权利明细和汇总
	 * 
	 * @param contractCd
	 * @return
	 */
	private int deleteAssetRightDByContractCd(String contractCd) {
		return ((ScfAssetEditService) ScfAdapter.getInstance("scfAssetEditService"))
				.deleteAssetRightByContractCd(contractCd);
	}

	private Map<String, List<ExcelRowBean>> dataExistsFilter(List<ExcelRowBean> noErrList, ColTemplate wkNameTmp) {
		Map<String, List<ExcelRowBean>> retMap = new HashMap<String, List<ExcelRowBean>>();
		MapUtils.safeAddToMap(retMap, "ERRLIST", new ArrayList<ExcelRowBean>());
		MapUtils.safeAddToMap(retMap, "NOERRLIST", new ArrayList<ExcelRowBean>());
		if (noErrList == null || noErrList.size() == 0) {
			return retMap;
		}
		List<ExcelRowBean> newNoErrList = new ArrayList<ExcelRowBean>();
		List<ExcelRowBean> errDataList = new ArrayList<ExcelRowBean>(noErrList.size());
		Set<String> keySet = new HashSet<String>();
		for (ExcelRowBean rowBean : noErrList) {
			// 资产编号加权利名称 重复行校验
			String key = rowBean.getValue("ASSET_CD") + "_" + rowBean.getValue("RIGHT_NAME");
			if (keySet.contains(key) == false) {
				keySet.add(key);
				newNoErrList.add(rowBean);
			} else {
				List<ErrorMsg> errList = new ArrayList<ErrorMsg>();
				errList.add(new ErrorMsg(wkNameTmp, rowBean, "该资产已经存在相同的导入权利"));
				rowBean.setErrList(errList);
				errDataList.add(rowBean);
			}
		}
		MapUtils.safeAddToMap(retMap, "ERRLIST", errDataList);
		MapUtils.safeAddToMap(retMap, "NOERRLIST", newNoErrList);
		return retMap;
	}
}
