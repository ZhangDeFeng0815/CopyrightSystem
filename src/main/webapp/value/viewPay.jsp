<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产成本查看</title>
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
		
		<div data-options="region:'center',border:false" title="成本合计(单位:元)"  style="height:95px;overflow:hidden;border-bottom:none">
			<table id="payTotalDiv" class="acws-layout">
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
					<td class="t">总成本</td>
					<td class="ts" colspan=5>
						<span class='acws-span' data-field="payTotal"></span>
					</td>
				</tr>
				<tr>
					<td class="t">不含税成本(稿酬)</td>
					<td class="ts">
						<span class='acws-span' data-field="pay1"></span>
					</td>
					<td class="t">增值税</td>
					<td class="ts">
						<span class='acws-span' data-field="pay2"></span>
					</td>
					<td class="t">附加税</td>
					<td class="ts">
						<span class='acws-span' data-field="pay3"></span>
					</td>
				</tr>
				<tr>
					<td class="t">个税</td>
					<td class="ts" >
						<span class='acws-span' data-field="pay4"></span>
					</td>
					<td class="t">其他成本</td>
					<td class="ts" colspan=3>
						<span class='acws-span' data-field="pay5"></span>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<div data-options="region:'center',border:false,footer: '#dlg-buttons'" title="版权资产成本明细(单位:元)">  
	<div id="gridDiv" class="acws-grid"
		style="width:100%;min-height:200px;height:200px;" autoHeight=false fit=true>
		<table class="acwsgrid">
			<thead>
				<tr>
					<td>序号</td>
					<td>创建时间</td>
					<td>创建人</td>
					<td>合同编号</td>
					<td>不含税成本(稿酬)</td>
					<td>增值税</td>
					<td>附加税</td>
					<td>个税</td>
					<td>其他成本</td>
					<td>总计</td>
				</tr>
				<tr idField=CREATE_DATE widthunit='%'>
					<td colField=null 	width=4 	align=center	celltype=cntr></td>
					<td colField=CREATE_DATE 	width=12 	align=center 	celltype=at 	sort=str></td>
					<td colField=CREATE_USERNAME 	width=5 	align=left 	celltype=ro 	sort=str></td>
					<td colField=CONTRACT_CD 	width=15 align=left 		celltype=ro 	sort=str></td>
					<td colField=PAY_1 width=10 	align=right 	celltype=ro 	sort=int></td>
					<td colField=PAY_2 width=7 	align=right 	celltype=ro 	sort=int></td>
					<td colField=PAY_3 width=7 	align=right 	celltype=ro 	sort=int></td>
					<td colField=PAY_4 width=7	align=right 	celltype=ro 	sort=int></td>
					<td colField=PAY_5 width=7 	align=right 	celltype=ro 	sort=int></td>
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
	var mygrid=Acws.getTargetObj("#gridDiv");
	initAssetInfo();
	initAssetPay();
}

function initAssetInfo(){
	Acws.ajax("./asset/getAssetInfo.ajax",{assetId:dlgParams.assetId},function(outputData){
		Acws.setJson("#conditionDiv", outputData.asset);
	},{showMask:false});
}

function initAssetPay(){
	var myGrid=Acws.getTargetObj("#gridDiv");
	var inputData = {};
	inputData.assetId=dlgParams.assetId;
	inputData.gridSettings=myGrid.getGridSettings();
	Acws.ajax("./value/getAssetPay.ajax",inputData,function(outputData){
		$A("pay1").setAcwsValue(outputData.pay1);
		$A("pay2").setAcwsValue(outputData.pay2);
		$A("pay3").setAcwsValue(outputData.pay3);
		$A("pay4").setAcwsValue(outputData.pay4);
		$A("pay5").setAcwsValue(outputData.pay5);
		$A("payTotal").setAcwsValue(outputData.payTotal);
		myGrid.loadData(outputData.dataList);
	},{showMask:false});
}
</script>
</body>
</html>