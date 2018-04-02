/**
 * 版权所有： 天翼阅读
 * 项目名称: 文字版权平台
 * 创建者: zhangdf
 * 创建日期: 2018-3-20
 * 文件说明: 资产收入导入
 */
package com.tyyd.value.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tyyd.common.codebook.IncomeDItemEnum;
import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.service.ScfAssetSearchService;
import com.tyyd.crps.scf.value.dto.AssetIncomeDetailDto;
import com.tyyd.crps.scf.value.service.ScfAssetValueEditService;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.excelimport.ErrorMsg;
import com.tyyd.framework.excelimport.ExcelDataBean;
import com.tyyd.framework.excelimport.ExcelRowBean;
import com.tyyd.framework.excelimport.model.ColTemplate;
import com.tyyd.framework.excelimport.model.SheetTemplate;
import com.tyyd.framework.excelimport.service.impl.ExcelImport2BaseService;
import com.tyyd.framework.upload.common.UploadStatus;

@Service("assetIncomeImportService")
public class AssetIncomeImportServiceImpl extends ExcelImport2BaseService {
	
	private ThreadLocal<Map<String, Long>> assetIdLocalMap = new ThreadLocal<Map<String, Long>>();

	@Override
	public String getTempletePath() {
		return "classpath:template/assetImportIncDetailParseRule.xlsx";
	}

	@Override
	public ErrorMsg doCellValidate(MultipartHttpServletRequest request, HttpServletResponse reponse,
			SheetTemplate sheetTemplate, ColTemplate colTemplete, ArrayList<ExcelRowBean> allRowDatas,
			ExcelRowBean rowBean, String val, Map<String, String> params) throws Throwable {
		String colName = colTemplete.getName();
		
		// 资产编号有效性校验
		if ("ASSET_CD".equals(colName)) {
			ScfAssetSearchService scfAssetSearchService = (ScfAssetSearchService) ScfAdapter
					.getInstance("scfAssetSearchService");
			String assetCd = StringUtils.trim(val);
			AssetDto dto = scfAssetSearchService.getAssetInfoByAssetCd(assetCd);
			if (dto == null) {
				return new ErrorMsg(colTemplete, rowBean, "资产编号填写有误！");
			}
			Map<String, Long> assetMap = assetIdLocalMap.get();
			if (assetMap == null) {
				assetMap = new HashMap<String, Long>();
			}
			if (assetMap.containsKey(assetCd) == false) {
				MapUtils.safeAddToMap(assetMap, assetCd, dto.getAssetId());	
				assetIdLocalMap.set(assetMap);;
			}
		}
		return null;
	}

	@Override
	public Map<String, Object> doSaveData(MultipartHttpServletRequest request, HttpServletResponse reponse,
			CommonsMultipartFile file, ExcelDataBean excelData, ArrayList<SheetTemplate> templeteList,
			Map<String, String> params, UploadStatus status) throws Throwable {
		Map<String, Object> ret = new HashMap<String, Object>();
		MapUtils.safeAddToMap(ret, "SUCC_ROWCNT", 0);
		int dataCnt = excelData.getTotalRowCount();
		if (dataCnt == 0) {
			return ret;
		}
		String contractCd = MapUtils.getString(params, "CONTRACT_CD", "").trim();
		List<ExcelRowBean> errList = excelData.getErrorData(0);
		if (errList != null && errList.size() > 0) {
			return ret;
		}
		List<ExcelRowBean> noerrList = excelData.getNoerrData(0);
		List<ExcelRowBean> newNoerrList = distinctImportData(noerrList);
		// 1.将一条资产收入数据转换为5个收入项数据
		List<List<AssetIncomeDetailDto>> saveList = newNoerrList.stream().map(bean -> {
			Map<String, Long> assetMap = assetIdLocalMap.get();
			Long assetId = assetMap.get(StringUtils.trim(bean.getValue("ASSET_CD")));
			List<AssetIncomeDetailDto> dtoList = new ArrayList<AssetIncomeDetailDto>();
			dtoList.add(convet2AssetIncomeDetailDto(assetId, StringUtils.trim(bean.getValue("SHARED_REVENUE")),
					IncomeDItemEnum.SHARED_REVENUE.getCd(), contractCd));
			dtoList.add(convet2AssetIncomeDetailDto(assetId, StringUtils.trim(bean.getValue("MINIMUM_INC")),
					IncomeDItemEnum.MINIMUM_INC.getCd(), contractCd));
			dtoList.add(convet2AssetIncomeDetailDto(assetId, StringUtils.trim(bean.getValue("BUY_OUT_INC")),
					IncomeDItemEnum.BUY_OUT_INC.getCd(), contractCd));
			dtoList.add(convet2AssetIncomeDetailDto(assetId, StringUtils.trim(bean.getValue("STAGE_INC")),
					IncomeDItemEnum.STAGE_INC.getCd(), contractCd));
			dtoList.add(convet2AssetIncomeDetailDto(assetId, StringUtils.trim(bean.getValue("OTHER")),
					IncomeDItemEnum.OTHER.getCd(), contractCd));
			return dtoList;
		}).collect(Collectors.toList());
		List<AssetIncomeDetailDto> dataList = saveList.stream().flatMap(dtoList -> dtoList.stream().map(dto -> dto))
				.collect(Collectors.toList());
		// 2.执行导入操作
		ScfAssetValueEditService scfAssetValueEditService = (ScfAssetValueEditService) ScfAdapter
				.getInstance("scfAssetValueEditService");
		scfAssetValueEditService.batchSaveIncomeDetail(Security.getCurrentUserID(), dataList,
				contractCd);
		String msg = "已成功导入%s条记录，请确认!";
		MapUtils.safeAddToMap(ret, "INFO_MSG", String.format(msg, newNoerrList.size()));
		if (newNoerrList.size() != noerrList.size()) {
			Integer diffCnt = noerrList.size() - newNoerrList.size();
			MapUtils.safeAddToMap(ret, "INFO_MSG",
					String.format("已成功导入%s条记录，其中过滤资产编号重复的数据为%s条，请确认!", newNoerrList.size(), diffCnt));
		}
		return ret;
	}
	
	/**
	 * 过滤重复项
	 * @param noerrList
	 * @return
	 */
	private List<ExcelRowBean> distinctImportData(List<ExcelRowBean> noerrList) {
		List<ExcelRowBean> retList = new ArrayList<ExcelRowBean>();
		Set<String> keySet = new HashSet<String>();
		for (ExcelRowBean bean : noerrList) {
			String assetCd = StringUtils.trim(bean.getValue("ASSET_CD"));
			if (keySet.contains(assetCd) == false) {
				retList.add(bean);
				keySet.add(assetCd);
			}
		}
		return retList;
	}
	
	/**
	 * 将一行中某个收入项，转换为一个dtoBean
	 * @param assetId
	 * @param money
	 * @param cd
	 * @param contractCd
	 * @return
	 */
	private AssetIncomeDetailDto convet2AssetIncomeDetailDto(Long assetId, String money, String cd, String contractCd) {
		AssetIncomeDetailDto dto = new AssetIncomeDetailDto();
		dto.setAssetId(assetId);
		dto.setIncomeItemCd(cd);
		dto.setContractCd(contractCd);
		if (StringUtils.isNotBlank(money)) {
			dto.setMoney((new BigDecimal(money)).multiply(new BigDecimal(100)).longValue());
		}
		return dto;
	}

}
