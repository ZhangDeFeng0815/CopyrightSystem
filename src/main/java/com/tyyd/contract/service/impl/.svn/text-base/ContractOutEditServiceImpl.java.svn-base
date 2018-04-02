package com.tyyd.contract.service.impl;

import java.io.File;
import java.sql.Date;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tyyd.contract.service.ContractEditBaseService;
import com.tyyd.crps.scf.contract.service.ScfContractEditService;
import com.tyyd.crps.scf.contract.service.ScfContractSearchService;
import com.tyyd.crps.scf.contract.service.dto.ContractOutDto;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.upload.common.UploadStatus;
import com.tyyd.framework.upload.service.impl.UploadBaseService;

@Service("contractOutEditService")
public class ContractOutEditServiceImpl extends UploadBaseService implements ContractEditBaseService {
	
	protected static final Long FILE_LIMIT_MAX_SIZE = 5 * 1024 * 1024L;
	
	@Override
	public Map doExcute(MultipartHttpServletRequest request, HttpServletResponse reponse, CommonsMultipartFile file,
			Map<String, String> params, UploadStatus status) throws Throwable {
		doUpload(request, reponse, file, params, status);
		Map<String, Object> output = new HashMap<String, Object>();
		Long contractId = MapUtils.getLong(params, "contractId", null);
		if (contractId == null) {// 新增
			// 1.校验合同编号是否已经存在
			ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
					.getInstance("scfContractSearchService");
			Integer count = scfContractSearchService
					.existsContractOutInfoByContractCd(StringUtils.trim(MapUtils.getString(params, "contractCd")));
			if (count>0) {
				MapUtils.safeAddToMap(output, "INFO_MSG", "该合同编号已存在，请修改后再提交。");
				return output;
			}
		}
		// 2.如果有文件保存文件
		Map<String, String> retFileMap = checkAndGetFilePath(file, FILE_LIMIT_MAX_SIZE);
		if (retFileMap.containsKey("INFO_MSG")) {
			output.put("INFO_MSG", MapUtils.getString(retFileMap, "INFO_MSG"));
			return output;
		}
		// 3.取得附件信息
		Map<String, Object> fileParamsMap = getUplloadFileParams(params, file,
				MapUtils.getString(retFileMap, "PATH", null));
		// 4.保存合同信息
		if (contractId == null) {// 新增
			output = addContractOut(params, Security.getCurrentUserID(), fileParamsMap);
		} else {// 修改
			output = editContractOut(params, Security.getCurrentUserID(), fileParamsMap);
		}
		// 新增或者更新时，发生异常，删除上传文件
		if (output.containsKey("INFO_MSG")) {
			if (StringUtils.isNotBlank(MapUtils.getString(retFileMap, "PATH", null))) {
				FileUtils.deleteQuietly(new File(MapUtils.getString(retFileMap, "PATH", null)));
			}
		} else {
			output.put("success", true);
		}
		return output;
	}
	
	private Map<String, Object> addContractOut(Map<String, String> params, Long userId, Map<String, Object> fileParamsMap) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 1.不存在，新增授权合同
		Instant now = Instant.now();
		ContractOutDto dto = saveData2Dto(params, now, userId, fileParamsMap);
		dto.setContractCd(StringUtils.trim(MapUtils.getString(params, "contractCd")));
		dto.setIsDeleted(0);
		dto.setCreateUserId(userId);
		dto.setCreateDate(Date.from(now));
		ScfContractEditService scfContractEditService = (ScfContractEditService) ScfAdapter
				.getInstance("scfContractEditService");
		Integer addRet = scfContractEditService.addContractOut(dto);
		if (addRet == 0) {
			MapUtils.safeAddToMap(retMap, "INFO_MSG", "新增合同时发生未知异常，新增失败。");
		}
		return retMap;
	}
	
	/**
	 * 修改获权合同信息
	 * @param params
	 * @param userId
	 * @return
	 */
	private Map<String, Object> editContractOut(Map<String, String> params, Long userId, Map<String, Object> fileParamsMap) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		// 1.修改获权合同
		Instant now = Instant.now();
		ContractOutDto dto = saveData2Dto(params, now, userId, fileParamsMap);
		dto.setContractId(MapUtils.getLong(params, "contractId"));
		ScfContractEditService scfContractEditService = (ScfContractEditService) ScfAdapter
				.getInstance("scfContractEditService");
		Integer addRet = scfContractEditService.editContractOut(dto);
		if (addRet == 0) {
			MapUtils.safeAddToMap(retMap, "msg", "修改合同时发生未知异常，修改失败。");
		}
		return retMap;
	}
	
	private ContractOutDto saveData2Dto(Map<String, String> params, Instant now, Long userId,
			Map<String, Object> fileParamsMap) {
		ContractOutDto dto = new ContractOutDto();
		dto.setPartnerId(MapUtils.getLong(params, "partnerId"));
		dto.setPartnerName(StringUtils.trim(MapUtils.getString(params, "partnerName")));
		dto.setAttachmentId(MapUtils.getLong(fileParamsMap, "ATTACHMENT_ID", null));
		dto.setFilePath(MapUtils.getString(fileParamsMap, "FILE_PATH", null));
		dto.setFileName(MapUtils.getString(fileParamsMap, "FILE_NAME", null));
		dto.setUpdateUserId(userId);
		dto.setUpdateDate(Date.from(now));

		return dto;
	}
	
	@Override
	public void doCancel(MultipartHttpServletRequest request, HttpServletResponse reponse, CommonsMultipartFile file,
			Map<String, String> params, UploadStatus status) {
	}

}
