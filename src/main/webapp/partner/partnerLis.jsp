<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>合作商列表</title>
</head>
<body style="overflow:hidden">
<div class="easyui-layout" data-options="border:false" fit=true>  
	<div region="north" title="查询区" data-options="collapsible:true,singleSelect:true,border:false" style="height:55px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout">
			<colgroup>
				<col style="width: 8%">
				<col style="width: 20%">
				<col style="width: 8%">
				<col style="width: 20%">
				<col style="width: 8%">
				<col style="width: 20%">
				<col style="width: 16%">
			</colgroup>
			<tr>
				<td class="t">编号</td>
				<td class="ts">
					<input data-field="PARTNER_ID" value=""/>
				</td>
				<td class="t">名称</td>
				<td class="ts">
					<input data-field="PARTNER_NAME" value="" />
				</td>
				<td class="t">类型</td>
				<td class="ts">
					<select class="easyui-combobox" data-field="PARTNER_TYPE" valid="required" style="width:150px;">
						<option value="">(全部)</option>
						<option value="1">机构</option>
						<option value="2">个人</option>
					</select>
				</td>
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
		
	<div id="aa" region="center" title="您现在的位置:合作商管理>合作商列表"  data-options="border:false" toolbar="#gridToolbar">
		<div id="gridToolbar" class="acws-toolbar" enablebtn="btnAdd,btnEdit,btnDel,btnView,btnExport" disablebtn="">
			<a id="btnAdd" class="acws_auth" authids="20000216" iconCls="icon-add" onclick="onAddClick()">新增</a>
			<a id="btnEdit" class="acws_auth" authids="20000216" iconCls="icon-edit"  onclick="onEditClick()">修改</a>
			<a id="btnDel" class="acws_auth" authids="20000216" iconCls="icon-del"  onclick="onDelClick()">删除</a>
			<a id="btnView"  iconCls="icon-view"  onclick="onViewClick()">查看</a>
			<a id="btnExport" class="acws_auth" authids="20000217" class="easyui-linkbutton acws-exceldownload" 
					data-options="iconCls:'icon-excel'" 
					data-service="$partnerExport"
					data-filename="合作商列表.xlsx"
					data-contextType=""
					data-confirmmsg="批量导出开始后无法结束并且导出时间偏长，确定导出？"
					onClickBefore="onExcelDownloadClickBefore()">导出</a>
		</div>
		<div id="gridDiv" class="acws-grid" 
			url="./partner/getPartnerList.ajax"
			data-options="multiline:false,showPagebar:true,pageList:[50,100,200]" fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td></td>
						<td>#master_checkbox</td>
						<td>编号</td>
						<td>名称</td>
						<td>类型</td>
						<td>备注</td>
						<td></td>
					</tr>
					<tr idField=partnerId widthunit='%'>
						<td colField=null 		width=2 	align=center 	celltype=cntr></td>
						<td colField=null 		width=3 	align=center 	celltype=ch></td>
						<td colField=partnerId 	width=10 	align=left 		celltype=ro sort=str></td>
						<td colField=partnerName 	width=20 	align=left 	celltype=ro sort=str></td>
						<td colField=partnerType_SHOW	width=6 	align=left 		celltype=abd(1) sort=str></td>
						<td colField=memo width=* align=left celltype=ro sort=str></td>
						<td colField=partnerType 		width=0 	align=center 	celltype=ro sort=str></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<!-- 新增、修改页面 开始-->
<div id="dlgEdit" title="编辑" style="display:none;width:500px;height:250px;overflow:hidden" modal=true buttons='#add-buttons'>
	<input type="hidden" data-field="OP_TYPE"></input>
	<table class="acws-layout">
		<tr style='height:0px'>
			<td width=25%></td>
			<td width=75%></td>
		</tr>
		<tr>
			<td class="t">编号<span class="bitian">*</span></td>
			<td class="ts">
				<span class="acws-span" data-field="PARTNER_ID">(系统自动生成)</span>
			</td>
		</tr>
		<tr>
			<td class="t">名称<span class="bitian">*</span></td>
			<td class="ts">
				<input type="text" data-field="PARTNER_NAME" valid="required" maxlength=255></input>
			</td>
		</tr>
		<tr>
			<td class="t">类型<span class="bitian">*</span></td>
			<td class="ts">
				<div class="acws-radio" data-field='PARTNER_TYPE' valid="required">
					<input type='radio' value='1'/>机构　	
					<input type='radio' value='2'/>个人
				</div>
			</td>
		</tr>
		<tr>
			<td class="t">备注</td>
			<td class="ts">
				<textarea data-field="MEMO" maxlength=1024  valid="length[0,1024]"></textarea>
			</td>
		</tr>
	</table>	
	<div id="add-buttons" style="display:none">
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="onEditSaveClick()">保存</a>
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="Acws.closeDialog('#dlgEdit')">取消</a>
	</div>
</div>
<!-- 新增、修改页面面 结束-->

<!-- 查看页面 开始-->
<div id="dlgView" title="查看" style="display:none;width:500px;height:250px;overflow:hidden" modal=true buttons='#view-buttons'>
	<table class="acws-layout">
	<tr style='height:0px'>
		<td width=25%></td>
		<td width=75%></td>
	</tr>
	<tr>
		<td class="t">编号<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="partnerId">(系统自动生成)</span>
		</td>
	</tr>
	<tr>
		<td class="t">名称<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="partnerName"></span>
		</td>
	</tr>
	<tr>
		<td class="t">类型<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="partnerType_SHOW"></span>
		</td>
	</tr>
	<tr>
		<td class="t">备注</td>
		<td class="ts">
			<span class="acws-span" data-field="memo"></span>
		</td>
	</tr>
	</table>	
	<div id="view-buttons" style="display:none">
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="Acws.closeDialog('#dlgView')">关闭</a>
	</div>
</div>
<!-- 查看页面 结束-->

<script>
//页面初始化
$(function(){
	onSearchClick();
});
//查询事件       
function onSearchClick(){
	var inputData = Acws.getJson("#conditionDiv");
	var mygrid = Acws.getTargetObj("#gridDiv");
	//根据不同的页面设置不同的条件
	mygrid.loadPagedData(inputData);
}

//清除事件
function onClearClick(){
	Acws.resetJson("#conditionDiv",{});
}

//新增
function onAddClick(){
	//1、打开新增修改对话框
	Acws.resetJson("#dlgEdit",{PARTNER_ID:"(系统自动生成)",OP_TYPE:'add'});
	Acws.showDialog("#dlgEdit");
	$("#dlgEdit").dialog("setTitle","新建");
}

//新增、修改对话框：保存按钮事件
function onEditSaveClick(){
	//1、校验
	if(!Acws.valid("#dlgEdit")){
		return;
	}
	//2、保存
	var inputData = Acws.getJson("#dlgEdit");
	Acws.ajax("./partner/savePartner.ajax", inputData, function(outputData){
		_alert(outputData.msg);
		if(outputData.success){
			//2.2、关闭对话框
			Acws.closeDialog("#dlgEdit");
			//2.3、刷新列表
			onSearchClick();
		} 
	});
}

//修改
function onEditClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var checkIds = mygrid.getCheckedIds();
	if(!checkIds){
		_warn("请先选择要修改的合作商");
		return;
	}else {
		var checkArr = checkIds.split(",");
		if(checkArr.length > 1){
			_alert("只能选择单个合作商，请重新选择");
			return false;
		}
	}
	Acws.ajax("./partner/getPartnerById.ajax", {partnerId:checkIds},function(outputData){
		 if(outputData.success==true){
			 var partner=outputData.partner;
			 var partnerData={};
			 partnerData.OP_TYPE="edit";
			 partnerData.PARTNER_ID=partner.partnerId;
			 partnerData.PARTNER_NAME=partner.partnerName;
			 partnerData.PARTNER_TYPE=partner.partnerType;
			 partnerData.MEMO=partner.memo;
			 Acws.showDialog("#dlgEdit");
			 $("#dlgEdit").dialog("setTitle","修改");
			 Acws.setJson("#dlgEdit", partnerData);
		}else{
			_err("找不到合作商ID为["+checkIds+"]的合作商");
			return false;
		}
	},{showMask:false});
}

//查看
function onViewClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var checkIds = mygrid.getCheckedIds();
	if(!checkIds){
		_warn("请先选择要查看的合作商");
		return;
	}else {
		var checkArr = checkIds.split(",");
		if(checkArr.length > 1){
			_alert("只能选择单个合作商，请重新选择");
			return false;
		}
	}
	var partnerType_SHOW=mygrid.getCellValue(checkIds,"partnerType_SHOW");
	Acws.ajax("./partner/getPartnerById.ajax", {partnerId:checkIds},function(outputData){
		 if(outputData.success==true){
			 var partnerData=outputData.partner;
			 partnerData.partnerType_SHOW=partnerType_SHOW;
			 Acws.showDialog("#dlgView");
			 Acws.setJson("#dlgView", partnerData);
		}else{
			_err("找不到合作商ID为["+checkIds+"]的合作商");
			return false;
		}
	},{showMask:false});
}

//删除事件
function onDelClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要删除的记录");
		return;
	}
	var checkIds = mygrid.getCheckedIds();
	if(!checkIds){
		_warn("请先选择要删除的记录");
		return;
	}
	doDelPartnerId(checkIds);
	/* //校验是否已关联菜单
	Acws.ajax("./framework/system/res/checkForDeleteResource.ajax",{RES_ID:selectedId},function(outputData){
		if(outputData.success==true){
			doDelRes(selectedId);
		}else{
			_err("已关联菜单的资源不能删除");
			return false;
		}
	},{showMask:false}); */
}
function doDelPartnerId(partnerIds){
	_confirm("您确认要删除所选合作商吗？",function(q){
		if(!q){
			return;
		}
		Acws.ajax("./partner/deletePartner.ajax",{partnerIds:partnerIds},
			function(outputData){
				var msg=outputData.msg ?outputData.msg:   outputData.failureMsg;
				_alert(msg);
				onSearchClick();
			});
	});
}

//导出前事件
function onExcelDownloadClickBefore(){
	var data=Acws.getJson("#conditionDiv");
	var mygrid=Acws.getTargetObj("#gridDiv");
	var checkIds=mygrid.getCheckedIds();
	data.partnerIds=checkIds;
	return data;
}
</script>
</body>
</html>