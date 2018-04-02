<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产权利查看</title>
</head>
<body>
<input type="hidden" data-field="RIGHT_CD"></input> 
<div class="easyui-layout" data-options="footer: '#dlg-buttons',border:false" fit=true>
<div data-options="region:'north',border:false" title="版权资产基本信息" style="height:95px;overflow:hidden">
	<table id="conditionDiv" class="acws-layout">
		<colgroup>
			<col style="width: 6%">
			<col style="width: 16%">
			<col style="width: 6%">
			<col style="width: 16%">
			<col style="width: 6%">
			<col style="width: 16%">
			<col style="width: 6%">
			<col style="width: 16%">
		</colgroup>
		<tr>
			<td class="t">资产编号</td>
			<td class="ts">
				<span class='acws-span' data-field="assetCd"></span>
			</td>
			<td class="t">作品名称</td>
			<td class="ts" colspan=3>
				<span class='acws-span' data-field="wkName"></span>
			</td>
			<td class="t">媒体类型</td>
			<td class="ts">
				<span class='acws-span' data-field="mediaTypeName"></span>
			</td>
		</tr>
		<tr>
			<td class="t">作者实名</td>
			<td class="ts">
				<span class='acws-span' data-field="auNameS"></span>
			</td>
			<td class="t">作者署名</td>
			<td class="ts">
				<span class='acws-span' data-field="auNameB"></span>
			</td>
			<td class="t">作品级别</td>
			<td class="ts">
				<span class='acws-span' data-field="wkClassName"></span>
			</td>
			<td class="t">ISBN号</td>
			<td class="ts">
				<span class='acws-span' data-field="isbnNum"></span>
			</td>
		</tr>
		<tr>
			<td class="t">作品总字数</td>
			<td class="ts">
				<span class='acws-span' data-field="wordCount"></span>
			</td>
			<td class="t">创建人</td>
			<td class="ts">
				<span class='acws-span' data-field="createUserName"></span>
			</td>
			<td class="t">入库时间</td>
			<td class="ts" colspan=3>
				<span class='acws-span' data-field="createDate" data-options="clazz:'date', dateFmt:'yyyy-MM-dd HH:mm:ss'"></span>
			</td>
		</tr>
	</table>
</div>
		
<div data-options="region:'center',border:false,footer: '#dlg-buttons'" 
	title="版权资产权利信息 : <span class='bitian' data-field='RIGHT_NAME'></span>">  
	<div id="gridDiv" class="acws-grid"
		style="width:100%;min-height:200px;height:200px;" autoHeight=false fit=true>
		<table class="acwsgrid">
			<thead>
				<tr>
					<td>序号</td>
					<td>权利开始日期</td>
					<td>权利结束日期</td>
					<td>是否可转授</td>
					<td>授权方式</td>
					<td>权利范围</td>
					<td>相关合同编号</td>
					<td>创建时间</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr idField=assetRightDId widthunit='%'>
					<td colField=null 		width=3 	align=center 	celltype=cntr></td>
					<td colField=dateFrom 	width=10 	align=center 	celltype=ad 	sort=str></td>
					<td colField=dateTo 	width=10	align=center 	celltype=ad 	sort=str></td>
					<td colField=canResale_SHOW width=7 	align=center	celltype=abd(4) 	sort=str></td>
					<td colField=atType_SHOW 	width=10		align=left 		celltype=abd(5) 	sort=str></td>
					<td colField=region_SHOW 	width=8 	align=left	 	celltype=abd(6) sort=str></td>
					<td colField=contractCd 	width=10 align=left 		celltype=ro 	sort=str></td>
					<td colField=createDate width=* 	align=center 		celltype=at 	sort=str></td>
					<td colField=canResale width=0 	align=left 		celltype=ro 	sort=str></td>
					<td colField=atType width=0 	align=left 		celltype=ro 	sort=str></td>
					<td colField=region width=0 	align=left 		celltype=ro 	sort=str></td>
				</tr>
			</thead>
		</table>
	</div>
</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>
var dlgParams={};
//弹出窗口初始化事件
function onAcwsDialogInit(params){
	$A("RIGHT_NAME").setAcwsValue(params.name);
	$A("RIGHT_CD").setAcwsValue(params.cd);
	dlgParams = params || {};
	initAssetInfo();
	initRightTGride();
}

function initAssetInfo(){
	Acws.ajax("./asset/getAssetInfo.ajax",{assetId:dlgParams.assetId},function(outputData){
		//alert(JSON.stringify(outputData.asset));
		Acws.setJson("#conditionDiv", outputData.asset);
	},{showMask:false});
}

//查询数据
function initRightTGride(){
	var myGrid=Acws.getTargetObj("#gridDiv");
	var inputData = {};
	inputData.assetId=dlgParams.assetId;
	inputData.rightCd=dlgParams.cd;
	inputData.gridSettings=myGrid.getGridSettings();
	//调用后台获取Grid数据
	Acws.ajax("./asset/right/getAssetRightDList.ajax",inputData,function(outputData){
		myGrid.loadData(outputData.dataList);
	});
}
</script>
</body>
</html>