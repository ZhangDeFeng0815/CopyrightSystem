/**
 * 版权所有：天翼文化
 * 项目名称: 文字资产平台
 * 文件说明: 合作商管理
 */
package com.tyyd.partner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tyyd.crps.scf.partner.dto.PartnerDto;
import com.tyyd.framework.core.ajax.AjaxParam;
import com.tyyd.framework.core.ajax.AjaxParams;
import com.tyyd.framework.core.ajax.GridSettings;
import com.tyyd.framework.core.util.DateUtil;
import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.core.util.MapUtils;
import com.tyyd.framework.core.util.Security;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;
import com.tyyd.framework.web.grid.IPageCount;
import com.tyyd.framework.web.grid.PageGridData;
import com.tyyd.partner.service.PartnerService;

@Controller
@RequestMapping("/partner")
public class PartnerController{

	private static final Logger log = LoggerFactory.getLogger(PartnerController.class);
	
	@Resource
	private PartnerService partnerService;
	
	/**
	 * 获取合作商列表
	 */
	@RequestMapping(value="/getPartnerList.ajax", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doGetPartnerList(@AjaxParam final AjaxParams inputData, HttpServletRequest request)throws Exception {
		HashMap<String, Object> params = inputData.getParams();
		GridSettings gs = inputData.getPagedGridSettings();
		Map<String, Object> params_search = new HashMap<String, Object>();
		MapUtils.safeAddToMap(params_search, "PARTNER_ID", MapUtils.getObject(params, "PARTNER_ID"));
		MapUtils.safeAddToMap(params_search, "PARTNER_NAME", MapUtils.getObject(params, "PARTNER_NAME"));
		MapUtils.safeAddToMap(params_search, "PARTNER_TYPE", MapUtils.getObject(params, "PARTNER_TYPE"));
		List<PartnerDto> list = partnerService.searchPartnerList(params_search,String.valueOf(gs.getStartRow()),String.valueOf(gs.getEndRow()));
		PageGridData outputData = new PageGridData();
		outputData.setPageData(inputData, list, new IPageCount() {
			@Override
			public int getPageCount() {
				//取得总记录条数
				return partnerService.searchPartnerListCount(params_search);
			}
		});
		return outputData;
	}
	
	/**
	 * 保存合作商
	 */
	@RequestMapping(value="/savePartner.ajax", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doSaveChapter(@AjaxParam final AjaxParams inputData, HttpServletRequest request)throws Exception {
		Map<String, Object> params = inputData.getParams();
		String opType = StringUtils.isBlank(MapUtils.getString(params, "OP_TYPE", "")) ? "edit" : MapUtils.getString(params, "OP_TYPE");
		Map<String, Object> params_save = new HashMap<String, Object>();
		MapUtils.safeAddToMap(params_save, "UPDATE_DATE", DateUtil.getCurDate());
		MapUtils.safeAddToMap(params_save, "UPDATE_USERID", Security.getCurrentUserID());
		if(StringUtils.equals("add", opType)) {
			params.remove("PARTNER_ID");
			MapUtils.safeAddToMap(params_save, "CREATE_DATE", DateUtil.getCurDate());
			MapUtils.safeAddToMap(params_save, "CREATE_USERID", Security.getCurrentUserID());
			if(StringUtils.isNotBlank(MapUtils.getString(params, "MEMO", ""))) {
				MapUtils.safeAddToMap(params_save, "MEMO", MapUtils.getString(params, "MEMO"));
			}
		}else if(StringUtils.equals("edit", opType)) {
			if (StringUtils.isBlank(MapUtils.getString(params, "PARTNER_ID", ""))
					|| StringUtils.equals("(系统自动生成)", MapUtils.getString(params, "PARTNER_ID"))) {
				ExceptionUtils.throwAcwsException("修改操作，合作商ID不能为空");
			}
			MapUtils.safeAddToMap(params_save, "PARTNER_ID", MapUtils.getObject(params, "PARTNER_ID"));
			MapUtils.safeAddToMap(params_save, "MEMO", MapUtils.getString(params, "MEMO", " "));
		}else { 
			ExceptionUtils.throwAcwsException("非法操作，请确认新增或修改操作");
		}
		MapUtils.safeAddToMap(params_save, "PARTNER_NAME", MapUtils.getObject(params, "PARTNER_NAME"));
		MapUtils.safeAddToMap(params_save, "PARTNER_TYPE", MapUtils.getObject(params, "PARTNER_TYPE"));
		Integer ret = partnerService.savePartner(params_save);
		Map<String, Object> outputData = new HashMap<String, Object>();
		if (ret > 0) {
			MapUtils.safeAddToMap(outputData, "success", true);
			MapUtils.safeAddToMap(outputData, "msg", "保存合作商成功");
		} else {
			MapUtils.safeAddToMap(outputData, "success", false);
			MapUtils.safeAddToMap(outputData, "msg", "保存合作商失败");
		}
		return outputData;
	}
	
	/**
	 * 获取合作商
	 * @param inputData
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getPartnerById.ajax")
	@ResponseBody
	public Map<String, Object> getPartnerById(@AjaxParam final AjaxParams inputData, HttpServletRequest request)throws Exception {
		log.debug("getPartnerById Start");
		HashMap<String, Object> params = inputData.getParams();
		PartnerDto partner = partnerService.getPartnerById(MapUtils.getLong(params, "partnerId"));
		HashMap<String, Object> outputData = new HashMap<String, Object>();
		if (partner != null && StringUtils.isNotBlank(partner.getPartnerName())) {
			MapUtils.safeAddToMap(outputData, "success", true);
			MapUtils.safeAddToMap(outputData, "partner", partner);
		} else {
			MapUtils.safeAddToMap(outputData, "success", false);
		}
		log.debug("getPartnerById End");
		return outputData;
	}
	
	
	/**
	 * 删除合作商
	 * @author qintao 
	 */
	@RequestMapping(value="/deletePartner.ajax",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doDeletePartner(@AjaxParam AjaxParams inputData, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> out = new HashMap<String, Object>();
		int totalNum = 0;
		int successNum = 0;
		int failNum = 0;
		Map<String, Object> params = inputData.getParams();
		String partnerIds = MapUtils.getString(params, "partnerIds","").trim();// 合作商id
		if (StringUtils.isNotBlank(partnerIds)) {
			String[] partnerIdArr = partnerIds.split(","); 
			totalNum = partnerIdArr.length;
			for (String partnerId : partnerIdArr) {
				if(StringUtils.isBlank(partnerId)) {
					failNum++;
					continue;
				}
				int cnt = partnerService.deletePartner(Long.valueOf(partnerId));
				if(cnt>0){
					successNum++;
				} else {
					failNum++;
				}
			}
		}
		String msg = "";
		if(totalNum>0){
			msg += "共选择"+totalNum+"个合作商删除";
		}
		if(successNum>0){
			msg += "，删除成功"+successNum+"个合作商";
		}
		if(failNum>0){
			msg += "，删除失败"+failNum+"个合作商";
		}
		MapUtils.safeAddToMap(out, "success", true);
		MapUtils.safeAddToMap(out, "msg", msg);
		return out;
	}
}
