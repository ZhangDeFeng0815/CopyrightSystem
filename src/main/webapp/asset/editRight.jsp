<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产权利编辑</title>
</head>
<body>
<div class="easyui-panel" data-options="iconCls: 'icon-save',footer: '#dlg-buttons',border:false" fit=true>
<div class="easyui-panel" title="版权资产基本信息" style="height:98px;" data-options="border:false">
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
				<span class='acws-span' data-field="ASSET_CD"></span>
			</td>
			<td class="t">作品名称</td>
			<td class="ts" colspan=6>
				<span class='acws-span' data-field="WK_NAME"></span>
			</td>
		</tr>
		<tr>
			<td class="t">作者实名</td>
			<td class="ts">
				<span class='acws-span' data-field="AU_NAME_S"></span>
			</td>
			<td class="t">作者署名</td>
			<td class="ts">
				<span class='acws-span' data-field="AU_NAME_B"></span>
			</td>
			<td class="t">创建人</td>
			<td class="ts">
				<span class='acws-span' data-field="CREATE_USERNAME"></span>
			</td>
			<td class="t">入库时间</td>
			<td class="ts">
				<span class='acws-span' data-field="CREATE_DATE" data-options="clazz:'date', dateFmt:'yyyy-MM-dd hh:mm:ss'"></span>
			</td>
		</tr>
		<tr>
			<td class="t">媒体类型</td>
			<td class="ts">
				<span class='acws-span' data-field="MEDIA_TYPE_ID_SHOW"></span>
			</td>
			<td class="t">作品总字数</td>
			<td class="ts">
				<span class='acws-span' data-field="WORD_COUNT"></span>
			</td>
			<td class="t">作品级别</td>
			<td class="ts">
				<span class='acws-span' data-field="WK_CLASS_SHOW"></span>
			</td>
			<td class="t">ISBN号</td>
			<td class="ts">
				<span class='acws-span' data-field="ISBN_NUM"></span>
			</td>
		</tr>
	</table>
</div>
		
<div class="easyui-panel" title="版权资产权利信息" data-options="border:false" fit=true>  
	<div id="gridDiv" class="acws-grid"
		style="width:100%;min-height:200px;height:200px;" 
		url=""
		data-options="showPagebar:true,pageList:[50,100,200]" autoHeight=false fit=true>
		<table class="acwsgrid">
			<thead>
				<tr>
					<td>序号</td>
					<td>权利名称</td>
					<td>权利开始日期</td>
					<td>权利结束日期</td>
					<td>是否可转授</td>
					<td>授权方式</td>
					<td>权利范围</td>
					<td>相关合同编号</td>
					<td>创建时间</td>
					<td>操作</td>
				</tr>
				<tr idField=ASSET_ID widthunit='%'>
					<td colField=null 		width=3 	align=center 	celltype=cntr></td>
					<td colField=RIGHT_NAME	width=16 	align=center 	celltype=ro 	sort=str></td>
					<td colField=DATE_FROM 	width=10 	align=center 	celltype=ro 	sort=str></td>
					<td colField=DATE_TO 	width=10	align=center 	celltype=ro 	sort=str></td>
					<td colField=CAN_RESALE width=7 	align=center	celltype=ro 	sort=str></td>
					<td colField=AT_TYPE 	width=10	align=left 		celltype=ro 	sort=str></td>
					<td colField=REGION 	width=15 	align=left	 	celltype=abd(3) sort=str></td>
					<td colField=CONTRACT_CD 	width=8 align=left 		celltype=ro 	sort=str></td>
					<td colField=CREATE_DATE width=12 	align=left 		celltype=ro 	sort=str></td>
					<td colField=null 		width=12 	align=left 		celltype=ro 	sort=str></td>
				</tr>
			</thead>
		</table>
	</div>
</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-del'" onclick="onDetailClick()">删除版权权利详情（临时按钮）</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>
//弹出窗口初始化事件
function onAcwsDialogInit(params){
	$A("RIGHT_NAME").setAcwsValue(params.name);
	$A("RIGHT_CD").setAcwsValue(params.cd);
}
function onRightDeleteClick(){
	var rightCd = getGridSingleSelectedId();
	_alert("删除权利");
}
function onDetailClick(){
	var cd = getGridSingleSelectedId();
	var name = '信息网络传播权（无线）';
	Acws.showDialog({url:'./asset/editRightDetail.jsp',title:'版权权利详情',width:1100,height:1024,modal:true,	dialogParams:{cd:cd,name:name}});
}

function getGridSingleSelectedId(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var id = mygrid.getCheckedIds();
	
	/* 前后端集成时需恢复注释代码
	if(!id){
		_alert("请先选择要查看的版权资产权利!");
		return false;
	} 
	
	var checkArr = id.split(",");
	if(checkArr.length > 1){
		_alert("只能选择单个版权资产权利，请重新选择！");
		return false;
	}
	*/
	return id;
}

</script>
</body>
</html>