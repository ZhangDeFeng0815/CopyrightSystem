/**
 * 版权所有： 天翼阅读
 * 项目名称: 文字版权管理平台
 * 创建者: qintao
 * 创建日期: 2018-3-11
 * 文件说明: 合作商导出
 */
package com.tyyd.partner.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.MyBatisSystemException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.tyyd.crps.scf.partner.dto.PartnerDto;
import com.tyyd.crps.scf.partner.service.ScfPartnerSearchService;
import com.tyyd.framework.core.IteratorBean;
import com.tyyd.framework.core.ListIterator;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.BaseDataUtils;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.PathUtil;
import com.tyyd.framework.download.DownloadOutputStream;
import com.tyyd.framework.download.DownloadResponse;
import com.tyyd.framework.download.DownloadStatus;
import com.tyyd.framework.excel.DownloadExcelService;
import com.tyyd.framework.excel.ExcelUtils;

@Service("partnerExportService")
public class PartnerExportServiceImpl implements DownloadExcelService {
	
	public static Logger logger = LoggerFactory.getLogger(PartnerExportServiceImpl.class);
	
	/**
	 * Excel导入模板
	 * 
	 * 继承DownloadBaseService类时的实现方法
	 */
	@Override
	public void doDownloadExcel(HttpServletRequest request,DownloadResponse reponse, DownloadOutputStream out,final Map<String, Object> params, DownloadStatus downloadStatus) {
		String templateFile=PathUtil.getAbsolutePath("./template/exportPartners.xlsx");
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
		final int MAX_COUNT_LIST=1000;//一个次最多获取1000条记录
		IteratorBean iteratorBean = new IteratorBean();
		// 读取下一批数据
		ScfPartnerSearchService scfPartnerSearchService = (ScfPartnerSearchService)ScfAdapter.getInstance("scfPartnerSearchService");
		List<PartnerDto> dataList =  scfPartnerSearchService.searchPartnersExport(getSearchParams(params));
		if(dataList != null && dataList.size()>0){
			MapUtils.safeAddToMap(params, "LASTPARTNERID", dataList.get(dataList.size()-1).getPartnerId());
			iteratorBean.setNextData(getExcelDataList(dataList));
			if(dataList.size() < MAX_COUNT_LIST){
				//数据未读满MAX_COUNT_LIST、提前结束
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
	
	private PartnerDto getSearchParams(Map<String, Object> params) {
		PartnerDto partnerDto = new PartnerDto();
		if (StringUtils.isNotBlank(MapUtils.getString(params, "partnerIds", ""))) {
			List<Long> partnerIdList = new ArrayList<Long>();
			String[] partnerIdArr = MapUtils.getString(params, "partnerIds").split(",");
			for (String partnerId : partnerIdArr) {
				if (StringUtils.isNotBlank(partnerId)) {
					partnerIdList.add(Long.valueOf(partnerId));
				}
			}
			if (partnerIdList.size() > 0) {
				partnerDto.setPartnerIdList(partnerIdList);
			}
		}
		if (StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_ID", ""))) {
			partnerDto.setPartnerId(MapUtils.getLong(params, "PARTNER_ID"));
		}
		if (StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_NAME", ""))) {
			partnerDto.setPartnerName(MapUtils.getString(params, "PARTNER_NAME"));
		}
		if (StringUtils.isNotBlank(MapUtils.getString(params, "PARTNER_TYPE", ""))) {
			partnerDto.setPartnerType(MapUtils.getInteger(params, "PARTNER_TYPE"));
		}
		if (StringUtils.isNotBlank(MapUtils.getString(params, "LASTPARTNERID", ""))) {
			partnerDto.setLastPartnerId(MapUtils.getLong(params, "LASTPARTNERID"));
		}
		return partnerDto;
	}
	
	private List<Map<String, Object>> getExcelDataList(List<PartnerDto> dataList){
		List<Map<String, Object>> dataList_ = new ArrayList<Map<String,Object>>();
		for (PartnerDto partnerDto : dataList) {
			Map<String, Object> map = new HashMap<String, Object>();
			MapUtils.safeAddToMap(map, "partnerId", partnerDto.getPartnerId());
			MapUtils.safeAddToMap(map, "partnerName", partnerDto.getPartnerName());
			MapUtils.safeAddToMap(map, "partnerType_SHOW", BaseDataUtils.getText("1",String.valueOf(partnerDto.getPartnerType())));
			MapUtils.safeAddToMap(map, "memo", partnerDto.getMemo());
			dataList_.add(map);
		}
		return dataList_;
	}
}
