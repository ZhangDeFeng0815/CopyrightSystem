<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产收入查看</title>
</head>
<body style="overflow:hidden">
<div class="easyui-layout" data-options="border:false,split:true" fit=true>
<div data-options="region:'north',border:false,split:false" style="height:146px;overflow:hidden;">
	<div class="easyui-layout" data-options="border:false" fit=true>
		<div data-options="region:'north',border:false,collapsible:false" title="版权资产基本信息" style="height:49px;overflow:hidden">
			<table id="conditionDiv" class="acws-layout">
				<colgroup>
					<col style="width: 9%">
					<col style="width: 16%">
					<col style="width: 9%">
					<col style="width: 16%">
					<col style="width: 9%">
					<col style="width: 16%">
					<col style="width: 9%">
					<col style="width: 16%">
				</colgroup>
				<tr>
					<td class="t">资产编号</td>
					<td class="ts">
						<span class='acws-span' data-field="assetCd"></span>
					</td>
					<td class="t">媒体类型</td>
					<td class="ts">
						<span class='acws-span' data-field="mediaTypeName"></span>
					</td>
					<td class="t">作者实名</td>
					<td class="ts">
						<span class='acws-span' data-field="auNameS"></span>
					</td>
				</tr>
				<tr>
					<td class="t">作品名称</td>
					<td class="ts" colspan=3>
						<span class='acws-span' data-field="wkName"></span>
					</td>
					<td class="t">作者署名</td>
					<td class="ts">
						<span class='acws-span' data-field="auNameB"></span>
					</td>
				</tr>
			</table>
		</div>
		
		<div data-options="region:'center',border:false" title="收入合计(单位:元)"  style="height:95px;overflow:hidden;border-bottom:none">
			<table id="incomeTotalDiv" class="acws-layout">
				<colgroup>
					<col style="width: 9%">
					<col style="width: 16%">
					<col style="width: 9%">
					<col style="width: 16%">
					<col style="width: 9%">
					<col style="width: 16%">
					<col style="width: 9%">
					<col style="width: 16%">
				</colgroup>
				<tr>
					<td class="t">总收入</td>
					<td class="ts" colspan=5>
						<span class='acws-span' data-field="incomeTotal"></span>
					</td>
				</tr>
				<tr>
					<td class="t">分成收入</td>
					<td class="ts">
						<span class='acws-span' data-field="income1"></span>
					</td>
					<td class="t">保底收入</td>
					<td class="ts">
						<span class='acws-span' data-field="income2"></span>
					</td>
					<td class="t">买断收入</td>
					<td class="ts">
						<span class='acws-span' data-field="income3"></span>
					</td>
				</tr>
				<tr>
					<td class="t">分期收入</td>
					<td class="ts" >
						<span class='acws-span' data-field="income4"></span>
					</td>
					<td class="t">其他收入</td>
					<td class="ts" colspan=3>
						<span class='acws-span' data-field="income5"></span>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
		
<div data-options="region:'center',border:false,footer: '#dlg-buttons'" title="版权资产收入信息(单位:元)">  
	<div id="gridDiv" class="acws-grid"
		style="width:100%;min-height:200px;height:200px;" autoHeight=false fit=true>
		<table class="acwsgrid">
			<thead>
				<tr>
					<td>序号</td>
					<td>创建时间</td>
					<td>创建人</td>
					<td>分成收入</td>
					<td>保底收入</td>
					<td>买断收入</td>
					<td>分期收入</td>
					<td>其他收入</td>
					<td>总计(元)</td>
				</tr>
				<tr idField=CREATE_DATE widthunit='%'>
					<td colField=null 	width=4 	align=center	celltype=cntr></td>
					<td colField=CREATE_DATE 	width=12 	align=center 	celltype=at 	sort=str></td>
					<td colField=CREATE_USERNAME 	width=5 	align=left 	celltype=ro 	sort=str></td>
					<td colField=INCOME_1 width=15 	align=right 	celltype=ro 	sort=int></td>
					<td colField=INCOME_2 width=7 	align=right 	celltype=ro 	sort=int></td>
					<td colField=INCOME_3 width=7 	align=right 	celltype=ro 	sort=int></td>
					<td colField=INCOME_4 width=7 	align=right 	celltype=ro 	sort=int></td>
					<td colField=INCOME_5 width=7 	align=right 	celltype=ro 	sort=int></td>
					<td colField=TOTAL width=* 		align=right 	celltype=ro 	sort=int></td>
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
	dlgParams = params || {};
	initAssetInfo();
	initAssetIncome();
}

function initAssetInfo(){
	Acws.ajax("./asset/getAssetInfo.ajax",{assetId:dlgParams.assetId},function(outputData){
		Acws.setJson("#conditionDiv", outputData.asset);
	},{showMask:false});
}

function initAssetIncome(){
	var myGrid=Acws.getTargetObj("#gridDiv");
	var inputData = {};
	inputData.assetId=dlgParams.assetId;
	inputData.gridSettings=myGrid.getGridSettings();
	Acws.ajax("./value/getAssetIncome.ajax",inputData,function(outputData){
		$A("income1").setAcwsValue(outputData.income1);
		$A("income2").setAcwsValue(outputData.income2);
		$A("income3").setAcwsValue(outputData.income3);
		$A("income4").setAcwsValue(outputData.income4);
		$A("income5").setAcwsValue(outputData.income5);
		$A("incomeTotal").setAcwsValue(outputData.incomeTotal);
		myGrid.loadData(outputData.dataList);
	},{showMask:false});
}
</script>
</body>
</html>