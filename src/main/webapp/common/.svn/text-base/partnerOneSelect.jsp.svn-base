<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>合作商选择（单个）</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
</head>

<body style="overflow:hidden">
	<div class="easyui-panel" data-options="footer: '#dlg-buttons',border:false" fit=true>
	<div class="easyui-layout"  data-options="border:false" fit=true>
	<div region="north" title="查询区" data-options="collapsible:false,border:false" style="height:55px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout">
			<colgroup>
				<col style="width: 12%">
				<col style="width: 28%">
				<col style="width: 12%">
				<col style="width: 28%">
				<col style="width: 20%">
			</colgroup>
			<tr>
				<td class="t">合作商名称</td>
				<td class="ts" colspan=3>
					<input class="easyui-textbox" data-field="PARTNER_NAME" value="" style="width:95%" maxlength=150/>
				</td>
				
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
		
	<div region="center" title="数据区"  data-options="border:false" style="border-bottom:none">
		<div id="gridDiv" class="acws-grid" 
			url="./partner/getPartnerList.ajax"
			data-options="multiline:false,showPagebar:true,pageList:[50,100,200]" fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>序号</td>
						<td>#master_checkbox</td>
						<td>编号</td>
						<td>名称</td>
						<td>类型</td>
						<td>备注</td>
						<td></td>
					</tr>
					<tr idField=partnerId widthunit='%'>
						<td colField=null 		width=4 	align=center 	celltype=cntr></td>
						<td colField=null 		width=4 	align=center 	celltype=ch></td>
						<td colField=partnerId 	width=10 	align=left 		celltype=ro sort=str></td>
						<td colField=partnerName 	width=40 	align=left 	celltype=ro sort=str></td>
						<td colField=partnerType_SHOW	width=10 	align=left 		celltype=abd(1) sort=str></td>
						<td colField=memo width=* align=left celltype=ro sort=str></td>
						<td colField=partnerType 		width=0 	align=center 	celltype=ro sort=str></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	</div>
	</div>
	<div id="dlg-buttons" class="buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="onOkClick()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">取消</a>
	</div>
</body>
<script>
var dlgParams={};
//弹出窗口初始化事件
function onAcwsDialogInit(params){
	dlgParams = params || {};
	var mygrid = Acws.getTargetObj("#gridDiv");
	mygrid.attachEvent("onRowDblClicked", function(rId,cInd){
		mygrid.selectRowById(rId);
		onOkClick();
	});
	var mygrid = Acws.getTargetObj("#gridDiv");
	mygrid.enableMultiselect(false);
	onSearchClick();
	
	$A("PARTNER_NAME").textbox("textbox").focus();
	
    $(document).keydown(function(b) {
         if ((b || window.event).keyCode === 13) {
         	onSearchClick()
         }
     }); 
}

function onSearchClick(){
	var inputData = Acws.getJson("#conditionDiv");
	var mygrid = Acws.getTargetObj("#gridDiv");
	//根据不同的页面设置不同的条件
	mygrid.loadPagedData(inputData);
}


function onClearClick(){
	Acws.resetJson("#conditionDiv");
}

//保存事件
function onOkClick(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var id=mygrid.getSelectedId();
	if (!id) {
		_warn("请选择一条记录！");
		return;
	}
	var row = {};
	row.partnerId=id;
	row.partnerType=mygrid.getCellValue(id, "partnerType");
	row.partnerName=mygrid.getCellValue(id, "partnerName");
	
	Acws.triggerDialogEvent("onOkClick", row);
	Acws.closeDialog();
}
</script>
</html>
