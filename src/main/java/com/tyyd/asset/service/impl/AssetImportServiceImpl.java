package com.tyyd.asset.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tyyd.crps.scf.asset.dto.AssetDto;
import com.tyyd.crps.scf.asset.dto.AssetImportResultDto;
import com.tyyd.crps.scf.asset.service.ScfAssetEditService;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.BaseDataUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.download.service.DownloadSimpleService;
import com.tyyd.framework.excelimport.ErrorMsg;
import com.tyyd.framework.excelimport.ExcelDataBean;
import com.tyyd.framework.excelimport.ExcelRowBean;
import com.tyyd.framework.excelimport.ExcelSheetBean;
import com.tyyd.framework.excelimport.model.ColTemplate;
import com.tyyd.framework.excelimport.model.SheetTemplate;
import com.tyyd.framework.excelimport.service.impl.ExcelImport2BaseService;
import com.tyyd.framework.upload.common.UploadStatus;

@Service("assetImportService")
public class AssetImportServiceImpl extends ExcelImport2BaseService implements DownloadSimpleService {

	@Override
	public String getTempletePath() {
		return "classpath:template/assetImportParseRule.xlsx";
	}

	@Override
	public ErrorMsg doCellValidate(MultipartHttpServletRequest request, HttpServletResponse reponse,
			SheetTemplate sheetTemplate, ColTemplate colTemplete, ArrayList<ExcelRowBean> allRowDatas,
			ExcelRowBean rowBean, String val, Map<String, String> params) throws Throwable {
		String colName = colTemplete.getName();
		
		if ("MEDIA_TYPE_ID".equals(colName)) {
			String mediaId = BaseDataUtils.getValue("2",String.valueOf(StringUtils.trim(val)));
			if (StringUtils.isBlank(mediaId)) {
				return new ErrorMsg(colTemplete, rowBean, "媒体类型填写有误！");
			}
		}
		if (StringUtils.isBlank(val)) {
			return null;
		}
		if ("WK_CLASS".equals(colName)) {
			String wkClassId = BaseDataUtils.getValue("3",String.valueOf(StringUtils.trim(val)));
			if (StringUtils.isBlank(wkClassId)) {
				return new ErrorMsg(colTemplete, rowBean, "作品等级填写有误！");
			}
		}
		if ("WORD_COUNT".equals(colName)) {
			try {
	            Integer.parseInt(val);
	        } catch (final NumberFormatException nfe) {
	            return new ErrorMsg(colTemplete, rowBean, "作品总字数填写有误！");
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
		Map<String, Object> ret = new HashMap<String, Object>();
		String infoMsg = "已导入%s条记录,以下记录有误,请修改后重新导入!";
		String infoAllInMsg = "已导入%s条记录,请确认!";
		MapUtils.safeAddToMap(ret, "SUCC_ROWCNT", 0);
		MapUtils.safeAddToMap(ret, "INFO_MSG", String.format(infoMsg, 0));
		
		int dataCnt = excelData.getTotalRowCount();
		if (dataCnt > 0) {
			ColTemplate wkNameTmp = templeteList.get(0).getColTemplates().get(0);
			// DB或者表内个重复的数据合并到错误列表，并返回新的没有错误的列表
			Map<String, List<ExcelRowBean>> retMap = dataExistsFilter(excelData.getNoerrData(0), wkNameTmp);
			List<ExcelRowBean> errList = excelData.getErrorData(0);
			errList.addAll((Collection<? extends ExcelRowBean>) MapUtils.getObject(retMap, "ERRLIST"));
			List<ExcelRowBean> noErrList =  (List<ExcelRowBean>) MapUtils.getObject(retMap, "NOERRLIST");
					
			status.setTotalStep(noErrList.size());
			// 1.数据转换
			List<AssetDto> dtoList = noErrList.stream().map(rowBean->{
				super.doProcessing(status);
				return getImportAssetDto(rowBean);
			}).collect(Collectors.toList());
			
			// 2.批量导入
			if (dtoList!=null && dtoList.size()>0) {
				ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter
						.getInstance("scfAssetEditService");
				AssetImportResultDto retDto = scfAssetEditService.batchImportAsset(Security.getCurrentUserID(), dtoList);
				// 3.返回值处理，是否有数据保存失败
				List<String> saveErrorData = retDto.getErrorList();
				if (saveErrorData != null && saveErrorData.size() > 0) {
					// Server端保存失败的数据添加到错误列表
					errList.addAll(getSaveErrorData(saveErrorData, noErrList, wkNameTmp));
				}
				MapUtils.safeAddToMap(ret, "SUCC_ROWCNT", retDto.getSuccessCnt());
				MapUtils.safeAddToMap(ret, "INFO_MSG",
						String.format(dataCnt == retDto.getSuccessCnt() ? infoAllInMsg : infoMsg, retDto.getSuccessCnt()));
			}
			// 4.重新设置错误列表
			ExcelSheetBean sheetBean = excelData.getSheet(0);
			sheetBean.setRows(errList);
			List<ExcelSheetBean> errorDatas = new ArrayList<ExcelSheetBean>();
			errorDatas.add(sheetBean);
			excelData.setErrorDatas(errorDatas);
		}
		return ret;
	}
	
	private AssetDto getImportAssetDto(ExcelRowBean rowBean) {
		AssetDto dto = new AssetDto();
		dto.setWkName(rowBean.getValue("WK_NAME"));
		dto.setAuNameS(rowBean.getValue("AU_NAME_S"));
		dto.setAuNameB(rowBean.getValue("AU_NAME_B"));
		String mediaTypeId = BaseDataUtils.getValue("2",
				String.valueOf(StringUtils.trim(rowBean.getValue("MEDIA_TYPE_ID"))));
		dto.setMediaTypeId(Integer.valueOf(mediaTypeId));
		String wkClassId = BaseDataUtils.getValue("3",
				String.valueOf(StringUtils.trim(rowBean.getValue("WK_CLASS"))));
		dto.setWkClass(Integer.valueOf(wkClassId));
		if (StringUtils.isNotBlank(rowBean.getValue("WORD_COUNT"))) {
			dto.setWordCount(Integer.valueOf(StringUtils.trim(rowBean.getValue("WORD_COUNT"))));
		}
		dto.setIsbnNum(StringUtils.trim(rowBean.getValue("ISBN_NUM")));
		return dto;
	}
	
	/**
	 * 对后台保存时，发生错误的数据提取
	 * @param saveErrorData：server端保存失败的数据键值
	 * @param noErrList：之前没有错误的列表
	 * @param wkNameTmp：作品名称列模板
	 * @return
	 */
	private List<ExcelRowBean> getSaveErrorData(List<String> saveErrorData, List<ExcelRowBean> noErrList,
			ColTemplate wkNameTmp) {
		return noErrList.stream().filter(rowBean->{
			String mediaTypeId = BaseDataUtils.getValue("2",
					String.valueOf(StringUtils.trim(rowBean.getValue("MEDIA_TYPE_ID"))));
			String key = getAssetKey(rowBean.getValue("WK_NAME"), rowBean.getValue("AU_NAME_S"),
					rowBean.getValue("AU_NAME_B"), mediaTypeId);
			return saveErrorData.contains(key) ? true : false;
		}).map(rowBean->{
			List<ErrorMsg> errList = new ArrayList<ErrorMsg>();
			errList.add(new ErrorMsg(wkNameTmp, rowBean, "已存在作品名称、作者实名、作者署名、媒体类型相同的资产"));
			rowBean.setErrList(errList);
			return rowBean;
		}).collect(Collectors.toList());
	}
	
	/**
	 * 对基本校验通过的的数据进行二次过滤
	 * 1.若表格内的数据和数据库内的数据出现作品名称、作者实名、作者署名、媒体类型相同的，视为重复资产，该条资产导入失败
	 * 2.若同一个表格内，出现两条作品名称、作者实名、作者署名、媒体类型相同的数据，默认取第一条，第二条不做导入
	 * @param noErrList
	 * @return
	 */
	private Map<String, List<ExcelRowBean>> dataExistsFilter(List<ExcelRowBean> noErrList, ColTemplate wkNameTmp) {
		Map<String, List<ExcelRowBean>> retMap = new HashMap<String, List<ExcelRowBean>>();
		MapUtils.safeAddToMap(retMap, "ERRLIST", new ArrayList<ExcelRowBean>());
		MapUtils.safeAddToMap(retMap, "NOERRLIST", new ArrayList<ExcelRowBean>());
		if (noErrList == null || noErrList.size()==0) {
			return retMap;
		}
		List<ExcelRowBean> newNoErrList = new ArrayList<ExcelRowBean>();
		List<ExcelRowBean> errDataList = new ArrayList<ExcelRowBean>(noErrList.size());
		Set<String> keySet = new HashSet<String>();
		for (ExcelRowBean rowBean : noErrList) {
			String mediaTypeId = BaseDataUtils.getValue("2",
					String.valueOf(StringUtils.trim(rowBean.getValue("MEDIA_TYPE_ID"))));
			String key = getAssetKey(rowBean.getValue("WK_NAME"), rowBean.getValue("AU_NAME_S"),
					rowBean.getValue("AU_NAME_B"), mediaTypeId);
			// 数据库中不存在，且在表格内第一次出现
			if (notExistsCheck(rowBean, Integer.valueOf(mediaTypeId)) 
					&& keySet.contains(key) == false) {
				keySet.add(key);
				newNoErrList.add(rowBean);
			} else {
				List<ErrorMsg> errList = new ArrayList<ErrorMsg>();
				errList.add(new ErrorMsg(wkNameTmp, rowBean, "已存在作品名称、作者实名、作者署名、媒体类型相同的资产"));
				rowBean.setErrList(errList);
				errDataList.add(rowBean);
			}
		}
		MapUtils.safeAddToMap(retMap, "ERRLIST", errDataList);
		MapUtils.safeAddToMap(retMap, "NOERRLIST", newNoErrList);
		return retMap;
	}
	
	/**
	 * 返回资产唯一性key
	 * @param wkName
	 * @param auNameS
	 * @param auNameB
	 * @param mediaTypeId
	 * @return
	 */
	private String getAssetKey(String wkName, String auNameS, String auNameB, String mediaTypeId) {
		return wkName + "_" + auNameS + "_"
				+ auNameB + "_" + mediaTypeId;
	}
	
	/**
	 * 如果数据库不存在对应的资产，则可以导入
	 * @param rowBean
	 * @return
	 */
	private boolean notExistsCheck(ExcelRowBean rowBean, Integer mediaTypeId) {
		// 重复性校验
		ScfAssetEditService scfAssetEditService = (ScfAssetEditService) ScfAdapter.getInstance("scfAssetEditService");
		Integer ret = scfAssetEditService.assetExistsCheck(rowBean.getValue("WK_NAME"), rowBean.getValue("AU_NAME_S"),
				rowBean.getValue("AU_NAME_B"), mediaTypeId);
		return ret == 0;
	}
	
	@Override
	public String getUri() {
		return "/template/assetImportTmp.xlsx";
	}

}
