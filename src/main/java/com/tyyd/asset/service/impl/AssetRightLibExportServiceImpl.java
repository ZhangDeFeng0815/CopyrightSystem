/**
 * 版权所有： 天翼阅读
 * 项目名称: 文字版权平台
 * 创建者: qintao
 * 创建日期: 2018-1-16
 * 文件说明: 资产权利导出
 */
package com.tyyd.asset.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.MyBatisSystemException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.dto.AssetRightDDto;
import com.tyyd.crps.scf.asset.service.ScfAssetSearchService;
import com.tyyd.framework.core.IteratorBean;
import com.tyyd.framework.core.ListIterator;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.BaseDataUtils;
import com.tyyd.framework.core.util.DateUtil;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.PathUtil;
import com.tyyd.framework.download.DownloadOutputStream;
import com.tyyd.framework.download.DownloadResponse;
import com.tyyd.framework.download.DownloadStatus;
import com.tyyd.framework.excel.DownloadExcelService;
import com.tyyd.framework.excel.ExcelUtils;

@Service("assetRightLibExportService")
public class AssetRightLibExportServiceImpl implements DownloadExcelService {
	
	public static Logger logger = LoggerFactory.getLogger(AssetRightLibExportServiceImpl.class);
	
	/**
	 * Excel导入模板
	 * 
	 * 继承DownloadBaseService类时的实现方法
	 */
	@Override
	public void doDownloadExcel(HttpServletRequest request,DownloadResponse reponse, DownloadOutputStream out,final Map<String, Object> params, DownloadStatus downloadStatus) {
		String opType = MapUtils.getString(params, "opType", "");
		List<String> assetCdList = new ArrayList<String>();
		String assetCds = "";
		String contractCd = "";
		if(StringUtils.isBlank(opType)) {
			ExceptionUtils.throwAcwsException("非法导出资产版权信息");
		}
		String templateFile="";
		if (StringUtils.equals("1", opType)) {
			templateFile = PathUtil.getAbsolutePath("./template/assetRightBatchAdd.xlsx");
			assetCds = MapUtils.getString(params, "ASSET_CDS", "");
			if (StringUtils.isBlank(assetCds)) {
				ExceptionUtils.throwAcwsException("按资产编号导出时、资产编号不能为空");
			}
			assetCdList.addAll(Arrays.asList(assetCds.split(",")));
			MapUtils.safeAddToMap(params, "assetCdList", assetCdList);
		} else if (StringUtils.equals("2", opType)) {
			templateFile = PathUtil.getAbsolutePath("./template/assetRightBatchEdit.xlsx");
			contractCd = MapUtils.getString(params, "CONTRACT_CD", "");
			if (StringUtils.isBlank(contractCd)) {
				ExceptionUtils.throwAcwsException("按合同编号导出时、合同编号不能为空");
			}
			ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter.getInstance("scfAssetSearchService");
			List<Long> assetIdList = scfAssetSearchService.selectAssetIdsByContractCd(contractCd);
			if(assetIdList==null||assetIdList.size()<1) {
				ExceptionUtils.throwAcwsException("没有找到该同编号："+contractCd+"所对应的资产信息");
			}
			MapUtils.safeAddToMap(params, "assetIdList", assetIdList);
		}
		
		MapUtils.safeAddToMap(params, "hasNext", true);
		ListIterator soaIterator = new ListIterator() {
			@SuppressWarnings("static-access")
			@Override
			public IteratorBean nextList() {
				int index=0;
				while(true) {
					try{
						index++;
						return callSoa(params);
					}catch(MyBatisSystemException e){
						//重试10次
						if(index>10){
							ExceptionUtils.throwAcwsException("SCF接口中断了、请重试!");
							break;
						} else {
							logger.warn("SCF接口连接中断后、第{}次重试。", index);
						}
						try {
							//暂停1秒后再重试
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
	 * @param params
	 * @param index
	 * @return
	 */
	private IteratorBean callSoa(Map<String, Object> params){
		IteratorBean iteratorBean = new IteratorBean();
		List<AssetRightDDto> dataList =  new ArrayList<AssetRightDDto>();
		if(StringUtils.equals("1", MapUtils.getString(params, "opType", ""))){
			dataList = getDataForAssetRightBatchAdd(params);
		} else if (StringUtils.equals("2", MapUtils.getString(params, "opType", ""))) {
			dataList = getDataForAssetRightBatchEdit(params);
		}
		if(dataList != null && dataList.size()>0){
			iteratorBean.setNextData(getExcelDataList(dataList, MapUtils.getString(params, "opType", "")));
			iteratorBean.setHasNext(MapUtils.getBoolean(params, "hasNext",false));
		}else {
			iteratorBean.setNextData(null);
			iteratorBean.setHasNext(false);
		}
		return iteratorBean;

	}
	
	@SuppressWarnings("unchecked")
	private List<AssetRightDDto> getDataForAssetRightBatchAdd(Map<String, Object> params){
		List<String> assetCdList = (List<String>) MapUtils.getObject(params, "assetCdList");
		List<String> assetCdListBack = new ArrayList<String>();
		assetCdListBack.addAll(assetCdList);
		if (assetCdList == null || assetCdList.size() < 1) {
			return new ArrayList<AssetRightDDto>();
		}
		List<String> dataListSearch =  new ArrayList<String>();
		int assetCdSize = assetCdList.size() > 200 ? 200 : assetCdList.size();
		//每次查询两百条数据
		for (int i = 0; i < assetCdSize; i++) {
			if(StringUtils.isNotBlank(assetCdList.get(i))) {
				dataListSearch.add(assetCdList.get(i));
			}
			assetCdListBack.remove(0);
		}
		
		if(dataListSearch.size()<1) {
			return new ArrayList<AssetRightDDto>();
		}
		AssetDto assetSearchParams = new AssetDto();
		assetSearchParams.setAssetCdList(dataListSearch);
		assetSearchParams.setStartRow("1");
		assetSearchParams.setEndRow("210");
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter.getInstance("scfAssetSearchService");
		List<AssetDto> assetList = scfAssetSearchService.searchAssetList(assetSearchParams);
		
		if (assetList == null || assetList.size() < 1) {
			return new ArrayList<AssetRightDDto>();
		}
		List<AssetRightDDto> AssetRightDList = new ArrayList<AssetRightDDto>();
		
		for (AssetDto asset : assetList) {
			AssetRightDDto assetRightDDto = new AssetRightDDto();
			assetRightDDto.setAssetCd(asset.getAssetCd());
			assetRightDDto.setWkName(asset.getWkName());
			assetRightDDto.setAuNameS(asset.getAuNameS());
			assetRightDDto.setAuNameB(asset.getAuNameB());
			assetRightDDto.setMediaTypeId(asset.getMediaTypeId());
			AssetRightDList.add(assetRightDDto);
		}
		
		MapUtils.safeAddToMap(params, "assetCdList", assetCdListBack);
		if(assetCdListBack.size()<1) {
			MapUtils.safeAddToMap(params, "hasNext", false);
		}
		return AssetRightDList;
	}
	
	@SuppressWarnings("unchecked")
	private List<AssetRightDDto> getDataForAssetRightBatchEdit(Map<String, Object> params){
		List<Long> assetIdList = (List<Long>) MapUtils.getObject(params, "assetIdList");
		String contractCd = MapUtils.getString(params, "CONTRACT_CD", "");
		if (assetIdList == null || assetIdList.size() < 1) {
			return new ArrayList<AssetRightDDto>();
		}
		ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter.getInstance("scfAssetSearchService");
		List<AssetRightDDto> AssetRightDList = scfAssetSearchService.selectAssetRightDsByAssetIdAndContractCd(assetIdList.get(0), contractCd);
		assetIdList.remove(0);
		if(assetIdList.size()<1) {
			MapUtils.safeAddToMap(params, "hasNext", false);
		}
		return AssetRightDList;
	}
	
	private List<Map<String, Object>> getExcelDataList(List<AssetRightDDto> dataList,String opType){
		List<Map<String, Object>> dataList_ = new ArrayList<Map<String,Object>>();
		for (AssetRightDDto assetRightD : dataList) {
			Map<String, Object> map = new HashMap<String, Object>();
			MapUtils.safeAddToMap(map, "assetCd", assetRightD.getAssetCd());
			MapUtils.safeAddToMap(map, "wkName", assetRightD.getWkName());
			MapUtils.safeAddToMap(map, "auNameS", assetRightD.getAuNameS());
			MapUtils.safeAddToMap(map, "auNameB", assetRightD.getAuNameB());
			MapUtils.safeAddToMap(map, "mediaTypeId_SHOW", BaseDataUtils.getText("2",String.valueOf(assetRightD.getMediaTypeId())));
			if (StringUtils.equals("2", opType)) {
				MapUtils.safeAddToMap(map, "rightName", assetRightD.getRightName());
				MapUtils.safeAddToMap(map, "dateFrom", DateUtil.formatYYYYMMDD_(assetRightD.getDateFrom()));
				MapUtils.safeAddToMap(map, "dateTo", DateUtil.formatYYYYMMDD_(assetRightD.getDateTo()));
				MapUtils.safeAddToMap(map, "canResale_SHOW", BaseDataUtils.getText("4",String.valueOf(assetRightD.getCanResale())));
				MapUtils.safeAddToMap(map, "atType_SHOW", BaseDataUtils.getText("5",String.valueOf(assetRightD.getAtType())));
				MapUtils.safeAddToMap(map, "region_SHOW", BaseDataUtils.getText("6",String.valueOf(assetRightD.getRegion())));
			}
			dataList_.add(map);
		}
		return dataList_;
	}
}
