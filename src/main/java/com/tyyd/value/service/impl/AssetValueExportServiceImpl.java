/**
 * 版权所有： 天翼阅读
 * 项目名称: 文字版权平台
 * 创建者: qintao
 * 创建日期: 2018-1-16
 * 文件说明: 资产权利导出
 */
package com.tyyd.value.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.MyBatisSystemException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.tyyd.common.po.ConfigInfo;
import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.service.ScfAssetSearchService;
import com.tyyd.framework.core.IteratorBean;
import com.tyyd.framework.core.ListIterator;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.BaseDataUtils;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.PathUtil;
import com.tyyd.framework.download.DownloadOutputStream;
import com.tyyd.framework.download.DownloadResponse;
import com.tyyd.framework.download.DownloadStatus;
import com.tyyd.framework.excel.DownloadExcelService;
import com.tyyd.framework.excel.ExcelUtils;
import com.tyyd.value.service.ValueService;

@Service("assetVaueExportService")
public class AssetValueExportServiceImpl implements DownloadExcelService {

	public static Logger logger = LoggerFactory.getLogger(AssetValueExportServiceImpl.class);

	@Resource
	private ValueService valueService;

	/**
	 * Excel导入模板
	 * 
	 * 继承DownloadBaseService类时的实现方法
	 */
	@Override
	public void doDownloadExcel(HttpServletRequest request, DownloadResponse reponse, DownloadOutputStream out,
			final Map<String, Object> params, DownloadStatus downloadStatus) {
		String templateFile = PathUtil.getAbsolutePath("./template/exportAssetValues.xlsx");
		ListIterator soaIterator = new ListIterator() {
			@SuppressWarnings("static-access")
			@Override
			public IteratorBean nextList() {
				int index = 0;
				while (true) {
					try {
						index++;
						return callSoa(params);
					} catch (MyBatisSystemException e) {
						// 重试10次
						if (index > 10) {
							ExceptionUtils.throwAcwsException("SCF接口中断了、请重试!");
							break;
						} else {
							logger.warn("SCF接口连接中断后、第{}次重试。", index);
						}
						try {
							// 暂停1秒后再重试
							Thread.currentThread().sleep(1000l);
						} catch (InterruptedException e1) {
						}
					}
				}
				return null;
			}
		};

		HashMap<String, Object> excelData = new HashMap<String, Object>();
		excelData.put("dataList", soaIterator);
		ExcelUtils.export(excelData, templateFile, out, downloadStatus);
	}

	/**
	 * 取得导出数据
	 * 
	 * @param params
	 * @param index
	 * @return
	 */
	private IteratorBean callSoa(Map<String, Object> params) {
		final int MAX_COUNT_LIST = 1000;// 一个次最多获取1000条记录
		IteratorBean iteratorBean = new IteratorBean();
		// 读取下一批数据
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
				.getInstance("scfAssetSearchService");
		List<AssetDto> dataList = scfAssetSearchService.searchAssetsExport(getSearchAssetsParams(params));
		if (dataList != null && dataList.size() > 0) {
			MapUtils.safeAddToMap(params, "lastAssetId", dataList.get(dataList.size() - 1).getAssetId());
			iteratorBean.setNextData(getExcelDataList(dataList));
			if (dataList.size() < MAX_COUNT_LIST) {
				// 数据未读满MAX_COUNT_LIST、提前结束
				iteratorBean.setHasNext(false);
			} else {
				iteratorBean.setHasNext(true);
			}

		} else {
			iteratorBean.setNextData(null);
			iteratorBean.setHasNext(false);
		}

		return iteratorBean;

	}

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

		if (StringUtils.isNotBlank(MapUtils.getString(params, "lastAssetId", ""))) {
			assetSearchParams.setLastAssetId(MapUtils.getLong(params, "lastAssetId"));
		}
		return assetSearchParams;
	}

	private List<Map<String, Object>> getExcelDataList(List<AssetDto> dataList) {
		List<Map<String, Object>> dataList_ = new ArrayList<Map<String, Object>>();
		for (AssetDto asset : dataList) {
			Map<String, Object> map = new HashMap<String, Object>();
			MapUtils.safeAddToMap(map, "assetCd", asset.getAssetCd());
			MapUtils.safeAddToMap(map, "wkName", asset.getWkName());
			MapUtils.safeAddToMap(map, "auNameS", asset.getAuNameS());
			MapUtils.safeAddToMap(map, "auNameB", asset.getAuNameB());
			MapUtils.safeAddToMap(map, "mediaTypeId_SHOW",
					BaseDataUtils.getText("2", String.valueOf(asset.getMediaTypeId())));
			MapUtils.safeAddToMap(map, "totalPay",
					valueService.convertNumber(String.valueOf(asset.getTotalPay()), 100, 2));
			MapUtils.safeAddToMap(map, "totalIncome",
					valueService.convertNumber(String.valueOf(asset.getTotalIncome()), 100, 2));
			dataList_.add(map);
		}
		return dataList_;
	}
}
