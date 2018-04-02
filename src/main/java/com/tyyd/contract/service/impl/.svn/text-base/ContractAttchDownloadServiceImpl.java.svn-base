package com.tyyd.contract.service.impl;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.tyyd.crps.scf.contract.service.ScfContractSearchService;
import com.tyyd.crps.scf.contract.service.dto.ContractInDto;
import com.tyyd.framework.core.soa.ScfAdapter;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.download.DownloadOutputStream;
import com.tyyd.framework.download.DownloadResponse;
import com.tyyd.framework.download.service.DownloadCustomService;
import com.tyyd.util.CrpsFileUtils;

@Service("contractAttchDownloadService")
public class ContractAttchDownloadServiceImpl implements DownloadCustomService {

	/**
	 * 下载合同附件
	 */
	@Override
	public void doDownload(HttpServletRequest request, DownloadResponse reponse, DownloadOutputStream out, Map params) {
		String contractCd = MapUtils.getString(params, "contractCd");
		String type = MapUtils.getString(params, "type");
		ScfContractSearchService scfContractSearchService = (ScfContractSearchService) ScfAdapter
				.getInstance("scfContractSearchService");
		String fileName =  null;
		String path = null;
		if ("IN".equals(type)) {
			ContractInDto dto = scfContractSearchService.selectContractInByCdWithFile(contractCd);
			fileName = dto.getFileName();
			path = dto.getFilePath();
		} else {
			
		}
		try {
			if (StringUtils.isBlank(path)) {
				return;
			}
			fileName = CrpsFileUtils.encodeOutputFileName(fileName);
			reponse.setHeader("Content-Disposition", "attachment; filename=" + fileName);
			CrpsFileUtils.outputSingleFile(out, path);
		} catch (IOException e) {
			e.printStackTrace();
			ExceptionUtils.throwAcwsException(e);
		}
	}

}
