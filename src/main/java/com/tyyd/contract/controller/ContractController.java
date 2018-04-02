/**
 * 版权所有：天翼文化
 * 项目名称: 文字资产平台
 * 文件说明: 合同管理
 */
package com.tyyd.contract.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.tyyd.contract.service.ContractService;
import com.tyyd.crps.scf.contract.service.dto.ContractInDto;
import com.tyyd.crps.scf.contract.service.dto.ContractOutDto;
import com.tyyd.framework.core.ajax.AjaxParam;
import com.tyyd.framework.core.ajax.AjaxParams;
import com.tyyd.framework.core.ajax.GridSettings;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.web.grid.IPageCount;
import com.tyyd.framework.web.grid.PageGridData;

@RestController
@RequestMapping("/contract")
public class ContractController {
	
//	private static final Logger log = LoggerFactory.getLogger(ContractController.class);
	
	@Resource
	private ContractService contractService;
	
	/**
	 * 判断获权合同是否有效
	 */
	@RequestMapping(value = "/getContractInList.ajax", method = RequestMethod.POST)
	public Map<String, Object> doGetContractInList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		HashMap<String, Object> params = inputData.getParams();
		GridSettings gs = inputData.getPagedGridSettings();
		List<ContractInDto> list = contractService.selectContractInList(params, String.valueOf(gs.getStartRow()),
				String.valueOf(gs.getEndRow()));
		PageGridData outputData = new PageGridData();
		outputData.setPageData(inputData, list, new IPageCount() {
			@Override
			public int getPageCount() {
				// 取得总记录条数
				return contractService.selectContractInListCount(params);
			}
		});
		return outputData;
	}
	
	/**
	 * 判断授权合同是否有效
	 */
	@RequestMapping(value = "/getContractOutList.ajax", method = RequestMethod.POST)
	public Map<String, Object> doGetContractOutList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		HashMap<String, Object> params = inputData.getParams();
		GridSettings gs = inputData.getPagedGridSettings();
		List<ContractOutDto> list = contractService.selectContractOutList(params, String.valueOf(gs.getStartRow()),
				String.valueOf(gs.getEndRow()));
		PageGridData outputData = new PageGridData();
		outputData.setPageData(inputData, list, new IPageCount() {
			@Override
			public int getPageCount() {
				// 取得总记录条数
				return contractService.selectContractOutListCount(params);
			}
		});
		return outputData;
	}
	
	/**
	 * 新增获权合同
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addContractIn.ajax", method = RequestMethod.POST)
	public Map<String, Object> doAddContractIn(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		Map<String, Object> ret = new HashMap<String, Object>();
		ret = contractService.addContractIn(inputData.getParams(), Security.getCurrentUserID());
		return ret;
	}
	
	/**
	 * 修改获权合同
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editContractIn.ajax", method = RequestMethod.POST)
	public Map<String, Object> doEditContractIn(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		Map<String, Object> ret = new HashMap<String, Object>();
		ret = contractService.editContractIn(inputData.getParams(), Security.getCurrentUserID());
		return ret;
	}
	
	/**
	 * 查看获权合同信息
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewContractIn.ajax", method = RequestMethod.POST)
	public Map<String, Object> doViewContractIn(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		return contractService.viewContractIn(inputData.getParams());
	}
	
	/**
	 * 查看授权合同信息
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewContractOut.ajax", method = RequestMethod.POST)
	public Map<String, Object> doViewContractOut(@AjaxParam final AjaxParams inputData, HttpServletRequest request)
			throws Exception {
		return contractService.viewContractOut(inputData.getParams());
	}

}
