<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产价值库</title>
</head>
<body>
<div class="easyui-layout" data-options="border:false" fit=true>  
	<div region="north" title="查询区" data-options="collapsible:true,singleSelect:true,border:false" style="height:54px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout">
			<colgroup>
				<col style="width: 10%">
				<col style="width: 30%">
				<col style="width: 10%">
				<col style="width: 30%">
				<col style="width: 20%">
			</colgroup>
			<tr>
				<td class="t">资产编号</td>
				<td class="ts">
					<input class='easyui-textbox' acwstype="textarea" data-field="ASSET_CDS" value=""/>
				</td>
				<td class="t">作品名称</td>
				<td class="ts">
					<input class='easyui-textbox' acwstype="textarea" data-field="WK_NAMES" value="" />
				</td>
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
		
		
	<div id="aa" region="center" title="您现在的位置:价值管理>资产价值库" toolbar="#gridToolbar" data-options="border:false">
		<div id="gridToolbar" class="acws-toolbar" enablebtn="btnPayManage,btnIncomeManage,btnExcel" disablebtn="">
			<a id="btnPayManage" class="acws_auth" authids="20000208,20000209" iconCls="icon-monitor"   menu="#menuPayManage">成本管理</a>
			<div id="menuPayManage" style="display:none;width:150px;">
				<div class="acws_auth" authids="20000208" onclick="onPayAddClick()" iconCls="icon-excel">导入成本</div>
				<div class="acws_auth" authids="20000209" onclick="onPayDetailClick()" iconCls="icon-view">查看成本明细</div>
			</div>
			<a id="btnIncomeManage" class="acws_auth" authids="20000211,20000212" iconCls="icon-monitor"   menu="#menuIncomeManage">收入管理</a>
			<div id="menuIncomeManage" style="display:none;width:150px;">
				<div class="acws_auth" authids="20000211" onclick="onIncomeAddClick()" iconCls="icon-excel">导入收入</div>
				<div class="acws_auth" authids="20000212" onclick="onIncomeDetailClick()" iconCls="icon-view">查看收入明细</div>
			</div>
			<a id="btnExcel"  class="acws_auth" authids="20000207,20000208,20000211" iconCls="icon-excel"   menu="#menuExcel">导出EXCEL</a>
			<div id="menuExcel" style="display:none;width:200px;">
				<div id="btnAssetExport" class="acws_auth" authids="20000207" class="easyui-linkbutton acws-exceldownload"
					data-options="iconCls:'icon-excel',plain:true" 
					data-service="$assetVaueExport"
					data-filename="资产价值库.xlsx"
					data-contextType=""
					data-confirmmsg="批量导出开始后无法结束并且导出时间偏长，确定导出？"
					onClickBefore="onAssetDownloadClickBefore()">导出资产价值信息</div>
				<div id="btnPayExport" class="acws_auth" authids="20000208" class="easyui-linkbutton acws-exceldownload" 
					data-options="iconCls:'icon-excel',plain:true" 
					data-service="$assetPayExport"
					data-filename="资产成本.xlsx"
					data-contextType=""
					data-confirmmsg="批量导出开始后无法结束并且导出时间偏长，确定导出？"
					onClickBefore="onPayDownloadClickBefore()">导出成本录入模板</div>
				<div id="btnIncomeExport" class="acws_auth" authids="20000211" class="easyui-linkbutton acws-exceldownload" 
					data-options="iconCls:'icon-excel',plain:true" 
					data-service="$assetIncomeExport"
					data-filename="资产收入.xlsx"
					data-contextType=""
					data-confirmmsg="批量导出开始后无法结束并且导出时间偏长，确定导出？"
					onClickBefore="onIncomeDownloadClickBefore()">导出收入录入模板</div>
				</div>
		</div>
		<div id="gridDiv" class="acws-grid"
			style="width:100%;min-height:200px;height:200px;" 
			url="./value/getAssetValueList.ajax"
			data-options="showPagebar:true,pageList:[50,100,200]" autoHeight=false fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>序号</td>
						<td>#master_checkbox</td>
						<td>资产编号</td>
						<td>作品名称</td>
						<td>作者实名</td>
						<td>作者署名</td>
						<td>媒体类型</td>
						<td>总成本(元)</td>
						<td>总收入(元)</td>
					</tr>
					<tr idField=assetId widthunit='%'>
						<td colField=null 		width=3 	align=center 	celltype=cntr></td>
						<td colField=null 		width=3 	align=center 	celltype=ch></td>
						<td colField=assetCd 	width=9 	align=center 	celltype=ro 	sort=str></td>
						<td colField=wkName 	width=* 	align=left 		celltype=ro 	sort=str></td>
						<td colField=auNameS 	width=5 	align=left 		celltype=ro 	sort=str></td>
						<td colField=auNameB 	width=5 	align=left 		celltype=ro 	sort=str></td>
						<td colField=mediaTypeId width=9 	align=left	 	celltype=abd(2) sort=str></td>
						<td colField=totalPayStr 	width=8 	align=left	 	celltype=ro sort=int></td>
						<td colField=totalIncomeStr width=8 	align=left 		celltype=ro sort=int></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
<script>
	//页面初始化
	$(function() {
		//初始化查询条件
		initSearchCondition();
		onSearchClick();
	});

	//初始化查询条件
	function initSearchCondition() {
		Acws.resetJson("#conditionDiv", {});
	}

	//查询事件       
	function onSearchClick() {
		var inputData = Acws.getJson("#conditionDiv");
		var mygrid = Acws.getTargetObj("#gridDiv");

		//根据不同的页面设置不同的条件
		mygrid.loadPagedData(inputData);
	}

	//清除事件
	function onClearClick() {
		initSearchCondition();
	}

	//导入成本
	function onPayAddClick() {
		Acws.showDialog({
			url : './value/importPay.jsp',
			title : '导入成本',
			width : 600,
			height : 400,
			modal : true,
			iconCls : 'icon-excel',
			dialogParams : {}
		});
	}

	//查看成本明细
	function onPayDetailClick() {
		var assetId = getGridSingleSelectedId();
		if(assetId){
			Acws.showDialog({
				url : './value/viewPay.jsp',
				title : '资产成本',
				width : 1024,
				height : 600,
				modal : true,
				iconCls : 'icon-view',
				dialogParams : {
					assetId : assetId
				}
			});
		}
	}

	//新增收入
	function onIncomeAddClick() {
		Acws.showDialog({
			url : './value/importIncome.jsp',
			title : '导入收入',
			width : 600,
			height : 400,
			modal : true,
			iconCls : 'icon-excel',
			dialogParams : {}
		});
	}

	//查看收入明细
	function onIncomeDetailClick() {
		if (!Acws.valid("#conditionDiv"))
			return;

		var assetId = getGridSingleSelectedId();
		if(assetId){
			Acws.showDialog({
				url : './value/viewIncome.jsp',
				title : '资产收入',
				width : 1024,
				height : 600,
				modal : true,
				iconCls : 'icon-edit',
				dialogParams : {
					assetId : assetId
				}
			});
		}
	}

	//导出资产前事件
	function onAssetDownloadClickBefore() {
		var mygrid = Acws.getTargetObj("#gridDiv");
		var assetId = mygrid.getCheckedIds();
		if(assetId){
			var checkArr = assetId.split(",");
			var assetCdArr=new Array();
			for(var i=0; i<checkArr.length; i++){
		 		assetCdArr.push(mygrid.getCellValue(checkArr[i],"assetCd"));
		 	}
			return {ASSET_CDS:assetCdArr.join("|")};
		} 
		return {};
	}

	//导出成本前事件
	function onPayDownloadClickBefore() {
		var mygrid = Acws.getTargetObj("#gridDiv");
		var assetId = mygrid.getCheckedIds();
		if(!assetId){
			_alert("请先选择要操作的版权资产");
			return false;
		} 
		var checkArr = assetId.split(",");
		var assetCdArr=new Array();
		for(var i=0; i<checkArr.length; i++){
	 		assetCdArr.push(mygrid.getCellValue(checkArr[i],"assetCd"));
	 	}
		return {ASSET_CDS:assetCdArr.join(",")};
	}

	//导出收入前事件
	function onIncomeDownloadClickBefore() {
		var mygrid = Acws.getTargetObj("#gridDiv");
		var assetId = mygrid.getCheckedIds();
		if(!assetId){
			_alert("请先选择要操作的版权资产");
			return false;
		} 
		var checkArr = assetId.split(",");
		var assetCdArr=new Array();
		for(var i=0; i<checkArr.length; i++){
	 		assetCdArr.push(mygrid.getCellValue(checkArr[i],"assetCd"));
	 	}
		return {ASSET_CDS:assetCdArr.join(",")};
	}

	function getGridSingleSelectedId() {
		var mygrid = Acws.getTargetObj("#gridDiv");
		var assetId = mygrid.getCheckedIds();

		if(!assetId){
			_alert("请先选择要操作的版权资产");
			return false;
		} 
		
		var checkArr = assetId.split(",");
		if(checkArr.length > 1){
			_alert("只能选择单个版权资产，请重新选择");
			return false;
		}
		return assetId;
	}
</script>
</body>
</html>