<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>资源选择</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
</head>

<body>
	<div class="easyui-panel" data-options="footer: '#dlg-buttons',border:false" fit=true>
	<div class="easyui-layout" fit=true data-options="border:false">
	<div region="north" title="" data-options="collapsible:false,border:false" style="height:32px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout" data-options="border:false">
			<colgroup>
				<col style="width: 8%">
				<col style="width: 10%">
				<col style="width: 8%">
				<col style="width: 10%">
				<col style="width: 8%">
				<col style="width: 25%">
				<col style="width: 31%">
			</colgroup>
			<tr>
				<td class="t">资源编号</td>
				<td class="ts">
					<input data-field="RES_ID" value=""/>
				</td>
				<td class="t">资源名称</td>
				<td class="ts">
					<input data-field="RES_NAME" value="" />
				</td>
				<td class="t">菜单</td>
				<td class="ts">
					<input class="easyui-combotree" style="width:200px;"
						data-field="MENU_SELECT_TREE" 
						data-options="valueField:'id',pvalueField:'PARENT_MENU_ID',textField:'MENU_NAME'"></input>
				</td>
				
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
		
		
	<div id="aa" region="center" title="" data-options="border:false">
		<div id="gridDiv" class="acws-grid" style="width:100%;height:99%;" data-options="autoExpand:true,border:false,multiline:false">
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>#master_checkbox</td>
						<td>资源编号</td>
						<td>资源名称</td>
						<td>备注</td>
					</tr>
					<tr idField=RES_ID widthunit='%'>
						<td colField=null 		width=3 	align=center 	celltype=ch></td>
						<td colField=RES_ID 	width=10 	align=left 		celltype=ro sort=str></td>
						<td colField=RES_NAME 	width=20 	align=left 	celltype=ro sort=str></td>
						<td colField=MEMO width=* align=left celltype=ro sort=str></td>
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
	//加载菜单选择树
	Acws.ajax("./framework/system/res/menuTreeDataList.ajax",{},function(outputData){
		//alert(JSON.stringify(outputData.dataList));
		Acws.setList("[data-field=MENU_SELECT_TREE]", outputData.dataList);
		$A("MENU_SELECT_TREE").combotree('setValue',"no_0");
		onSearchClick();
	});
}

function onSearchClick(){
	var inputData = Acws.getJson("#conditionDiv");
	var mygrid = Acws.getTargetObj("#gridDiv");
	inputData.gridSettings=mygrid.getGridSettings();
	inputData.MENU_ID=$A("MENU_SELECT_TREE").combotree("getValue");
	//调用后台获取Grid数据
	Acws.ajax("./framework/system/res/resourceList.ajax",inputData,function(outputData){
		mygrid.loadData(outputData.dataList)
	});
}


function onClearClick(){
	Acws.resetJson("#conditionDiv",{});
	$A("MENU_SELECT_TREE").combotree('clear');
}

//保存事件
function onOkClick(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var ids=mygrid.getCheckedIds();
	if (!ids) {
		_warn("请选择一条资源");
		return;
	}
	Acws.triggerDialogEvent("onOkClick", ids);
	Acws.closeDialog();
}
</script>
</html>
