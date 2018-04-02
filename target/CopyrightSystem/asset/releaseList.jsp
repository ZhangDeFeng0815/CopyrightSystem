<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产库</title>
</head>
<body style="overflow:hidden">
<div class="easyui-layout" data-options="border:false" fit=true>  
	<div region="north" title="查询区" data-options="collapsible:true,singleSelect:true,border:false" style="height:85px;overflow:hidden" >
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
				<col style="width: 12%">
			</colgroup>
			<tr>
				<td class="t">资产编号</td>
				<td class="ts">
					<input class='easyui-textbox' acwstype="textarea" data-field="ASSET_CDS" value=""/>
				</td>
				<td class="t">作品名称</td>
				<td class="ts">
					<input class='easyui-textbox' acwstype="textarea" data-field="WK_NAMES" value=""/>
				</td>
				<td class="t">作者实名</td>
				<td class="ts">
					<input type='text' data-field="AU_NAME_S" value=""/>
				</td>
				<td class="t">作者署名</td>
				<td class="ts">
					<input type='text' data-field="AU_NAME_B" value=""/>
				</td>
				
				<td class="ts" rowspan=4 style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a><br>
					<a class="easyui-linkbutton" iconCls="icon-cancel" style="margin-top:4px" onclick="onClearClick()">重置</a>
				</td>
			</tr>
			<tr>
				<td class="t">媒体类型</td>
				<td class="ts">
					<select class="easyui-combobox"  data-field="MEDIA_TYPE_ID" value="">
						<option value="">(全部)</option>
						<option value="1">电子图书</option>
						<option value="2">纸质图书</option>
						<option value="3">有声产品</option>
						<option value="4">动漫产品</option>
						<option value="5">影视产品</option>
						<option value="6">游戏产品</option>
						<option value="7">演出产品</option>
						<option value="8">其他（衍生产品）</option>
					</select>
				</td>
				<td class="t">权利项</td>
				<td class="ts">
				<select class="easyui-combobox" 
					data-field="RIGHTS" 
					data-options="valueField:'value',textField:'label',multiple:true"></select>
				</td>
				<td class="t">入库日期</td>
				<td class="ts" colspan=3>
					<input class="acws-date"  data-field="CREATE_DATE_FROM" value="" style="width:95px"/>
						&nbsp;至&nbsp;
					<input class="acws-date" data-field="CREATE_DATE_TO" value="" style="width:95px"/>
				</td>
			</tr>
		</table>
	</div>
		
	<div id="aa" region="center" title="您现在的位置:资产管理>版权资产库" data-options="border:false" toolbar="#gridToolbar">
		<div id="gridToolbar" class="acws-toolbar" enablebtn="btnAssetManage,btnRightManage,btnAssetExport,btnAssetRightExport,btnView" disablebtn="">
			<a id="btnAssetManage" class="acws_auth" authids="20000204,20000205" iconCls="icon-monitor"   menu="#menuAssetManage">资产管理</a>
			<div id="menuAssetManage" style="display:none;width:150px;">
				<div class="acws_auth" authids="20000204" onclick="onAssetAddClick()" iconCls="icon-excel">新增资产</div>
				<div class="acws_auth" authids="20000204" onclick="onAssetUpdClick()" iconCls="icon-edit">修改资产</div>
				<div class="acws_auth" authids="20000205" onclick="onAssetDelClick()" iconCls="icon-del">删除资产</div>
			</div>
			<a id="btnRightManage" class="acws_auth" authids="20000204,20000205" iconCls="icon-monitor"  menu="#menuRightManage">权利管理</a>
			<div id="menuRightManage" style="display:none;width:150px;">
				<div class="acws_auth" authids="20000204" onclick="onRightAddClick()"  iconCls="icon-excel">导入权利</div>
				<div class="acws_auth" authids="20000205" onclick="onRightDelClick()"  iconCls="icon-del">删除权利</div>
			</div>
			<a id="btnView" iconCls="icon-view" onclick="onAssetViewClick()">查看</a>
			<a id="btnAssetExport"  class="acws_auth" authids="20000206" class="easyui-linkbutton acws-exceldownload" 
				data-options="iconCls:'icon-excel'" 
				data-service="$assetLibExport"
				data-filename="资产库.xlsx"
				data-contextType=""
				data-confirmmsg="批量导出开始后无法结束并且导出时间偏长，确定导出？"
				onClickBefore="onAssetDownloadClickBefore()">导出资产信息</a>
			<a id="btnAssetRightExport" class="acws_auth" authids="20000204" iconCls="icon-excel"  onclick="onRightExportClick()">导出权利信息</a>
		</div>
		<div id="gridDiv" class="acws-grid"
			style="width:100%;min-height:200px;height:200px;" 
			url="./asset/getReleaseList.ajax"
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
						<td>作品级别</td>
						<td>作品总字数</td>
						<td>ISBN号</td>
						<td>创建人</td>
						<td>入库时间</td>
					</tr>
					<tr idField=assetId widthunit='%'>
						<td colField=null 		width=3 	align=center 	celltype=cntr></td>
						<td colField=null 		width=3 	align=center 	celltype=ch></td>
						<td colField=assetCd 	width=9 	align=center 	celltype=ro 	sort=str></td>
						<td colField=wkName 	width=26 	align=left 		celltype=ro 	sort=str></td>
						<td colField=auNameS 	width=5 	align=left 		celltype=ro 	sort=str></td>
						<td colField=auNameB 	width=5 	align=left 		celltype=ro 	sort=str></td>
						<td colField=mediaTypeId width=9 	align=left	 	celltype=abd(2) sort=str></td>
						<td colField=wkClass 	width=5 	align=left 		celltype=abd(3) sort=str></td>
						<td colField=wordCount width=6 	align=right		celltype=ro 	sort=str></td>
						<td colField=isbnNum 	width=12 	align=left 		celltype=ro 	sort=str></td>
						<td colField=createUserName width=5 	align=left 		celltype=ro 	sort=str></td>
						<td colField=createDate width=12 	align=center 	celltype=at  	sort=str></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
<script>
//页面初始化
$(function(){
	//初始化查询条件
	doAutoSetRights();
	initSearchCondition();
	onSearchClick();
});


//初始化查询条件
function initSearchCondition(){
	Acws.resetJson("#conditionDiv",{});
	
}

//动态加载权利项
function doAutoSetRights(){
	Acws.ajax("./asset/right/getRightList.ajax",{},function(outputData){
		Acws.setList("[data-field=RIGHTS]", outputData.dataList);
	},{showMask:false});
}

//查询事件       
function onSearchClick(){
	var inputData = Acws.getJson("#conditionDiv");
	var mygrid = Acws.getTargetObj("#gridDiv");

	//根据不同的页面设置不同的条件
	mygrid.loadPagedData(inputData);
}

//清除事件
function onClearClick(){
	initSearchCondition();
}

//新增资产
function onAssetAddClick(){
	Acws.showDialog({url:'./asset/import.jsp',title:'版权资产',width:600,height:300,modal:true,
		iconCls:'icon-excel',dialogParams:{},dialogEvent:{onDialogClose: onSearchClick}});
}

//修改资产
function onAssetUpdClick(){
	if(!Acws.valid("#conditionDiv"))return;
	var assetId = getGridSingleSelectedId();
	if (assetId) {
		Acws.showDialog({url:'./asset/edit.jsp',title:'修改资产',width:1100,height:520,modal:true,
			iconCls:'icon-edit',dialogParams:{assetId:assetId},dialogEvent:{onDialogClose: onSearchClick}});	
	}
}

//删除资产
function onAssetDelClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
    var assetIds = mygrid.getCheckedIds();
    if(!assetIds){
        _alert("请先选择一个版权资产、再执行该操作!");
        return false;
    } 
    var inputData = {};
	if(assetIds){
		_confirm("您确定要删除选中的资产吗？", function(r) {
			if (r) {
				var assetIdArr=assetIds.split(",");
		        var assetCdArr=new Array();
		        for (var i=0;i<assetIdArr.length;i++){
		            assetCdArr.push(assetIdArr[i] + ":" + mygrid.getCellValue(assetIdArr[i],"assetCd"));
		        }
		        inputData.ASSET_ID_CDS=assetCdArr.join("|");
		        //删除资产：无收入、无成本才能删除
		        Acws.ajax("./asset/deleteAssetInfos.ajax",inputData,function(outputData){
		            if (outputData.success){
		                _alert(outputData.msg ? outputData.msg : "资产删除成功!",null,function(){
		                    onSearchClick();
		                });
		            } else {
		                _err(outputData.msg);
		            }
		        });
			}
		});
       
    }
}

//导入权利
function onRightAddClick(){
	Acws.showDialog({url:'./asset/importRight.jsp',title:'版权权利',width:500,height:370,modal:true,iconCls:'icon-excel',dialogParams:{}});
}

//导出权利
function onRightExportClick(){
	Acws.showDialog({url:'./asset/exportRight.jsp',title:'版权权利',width:440,height:500,modal:true,iconCls:'icon-excel',dialogParams:{}});
}

//删除权利
function onRightDelClick(){
	var assetId = getGridSingleSelectedId();
	if(assetId){
		Acws.showDialog({url:'./asset/editRightDetail.jsp',title:'版权权利',width:1100,height:520,modal:true,iconCls:'icon-edit',dialogParams:{assetId:assetId}});
	}
}

//查看版权资产
function onAssetViewClick(){
	var assetId = getGridSingleSelectedId();
	if(assetId){
		Acws.showDialog({url:'./asset/view.jsp',title:"版权资产",
			width:1100,height:520,modal:true,
			dialogParams:{assetId:assetId}});
	}
}

function getGridSingleSelectedId(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var assetId = mygrid.getCheckedIds();
	if(!assetId){
		_alert("请先选择一个版权资产、再执行该操作");
		return false;
	} 
	
	var checkArr = assetId.split(",");
	if(checkArr.length > 1){
		_alert("只能选择单个版权资产，请重新选择");
		return false;
	}
	return assetId;
}


//导出前事件
function onAssetDownloadClickBefore(){
	var data = Acws.getJson("#conditionDiv");
	var mygrid = Acws.getTargetObj("#gridDiv");
	var assetIds = mygrid.getCheckedIds();
	if(assetIds){
		var assetIdArr=assetIds.split(",");
		var assetCdArr=new Array();
		for (var i=0;i<assetIdArr.length;i++){
			assetCdArr.push(mygrid.getCellValue(assetIdArr[i],"assetCd"));
		}
		data.ASSET_CDS=assetCdArr.join("\\|");
	}
	return data;
}
</script>
</body>
</html>