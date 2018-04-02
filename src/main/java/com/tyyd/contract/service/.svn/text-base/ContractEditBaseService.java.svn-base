package com.tyyd.contract.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tyyd.common.CrpsCommonConstant;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.UUID;
import com.tyyd.util.CrpsFileUtils;

public interface ContractEditBaseService {

	/**
	 * 校验文件大小，获得文件路径信息
	 * @param file
	 * @param fileMaxSize
	 * @return
	 * @throws IOException
	 */
	default Map<String, String> checkAndGetFilePath(CommonsMultipartFile file, Long fileMaxSize) throws IOException {
		Map<String, String> retMap = new HashMap<String, String>();
		if (file == null) {
			return retMap;
		}
		if (file.getSize() > fileMaxSize) {
			retMap.put("INFO_MSG", "选择的文件超过文件大小的限制！<br>文件大小限制为：5MB。");
			return retMap;
		}
		String basePath = CrpsCommonConstant.getRfileContractPathWithYMD();// 上传文件夹
		String newFileName = UUID.getUUID() + FilenameUtils.EXTENSION_SEPARATOR
				+ FilenameUtils.getExtension(file.getFileItem().getName());
		String filePath = basePath + newFileName;
		if (CrpsFileUtils.mkdirIfNotExists(basePath)) {
			FileUtils.copyInputStreamToFile(file.getInputStream(), new File(filePath));
		} else {
			retMap.put("INFO_MSG", "文件上传发生时，创建文件目录失败。");
			return retMap;
		}
		MapUtils.safeAddToMap(retMap, "PATH", filePath);
		return retMap;
	}
	
	/**
	 * 返回附件ID、文件名、路径等信息
	 * @param params
	 * @param file
	 * @param filePath
	 * @return
	 */
	default Map<String, Object> getUplloadFileParams(Map<String, String> params, CommonsMultipartFile file,
			String filePath) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		MapUtils.safeAddToMap(retMap, "ATTACHMENT_ID", null);
		MapUtils.safeAddToMap(retMap, "FILE_PATH", filePath);// 附件路径
		MapUtils.safeAddToMap(retMap, "FILE_NAME", null);
		Long contractId = MapUtils.getLong(params, "contractId", null);
		if (contractId == null) {// 新增
			if (file != null) {
				MapUtils.safeAddToMap(retMap, "FILE_NAME", file.getOriginalFilename());
			}
		} else {// 修改
			Long attachmentId = MapUtils.getLong(params, "attachmentId", null);
			MapUtils.safeAddToMap(retMap, "ATTACHMENT_ID", attachmentId);
			if (file != null) {// 覆盖附件，无论之前有无附件，SCF后端需要删除原文件
				MapUtils.safeAddToMap(retMap, "ATTACHMENT_ID", null);// 原附件清除
				MapUtils.safeAddToMap(retMap, "FILE_NAME", file.getOriginalFilename());// 新的附件名
			} else {
				// 3种情况，1：本来就没有，2.原来有，现在删除了，3.原来就有
				// if (attachmentId == null) {// 1：本来就没有
				// // do nothing
				// }
				if (attachmentId != null && StringUtils.isBlank(MapUtils.getString(params, "fileName"))) {// 2.原来有，现在删除了
					MapUtils.safeAddToMap(retMap, "ATTACHMENT_ID", null);// 置为null代表清除
				}
			}
		}
		return retMap;
	}
}
