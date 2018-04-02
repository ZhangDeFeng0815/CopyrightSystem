<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<title>系统设置-用户管理</title>
	<%@ include file="/common/myapp.jsp"%>
</head>
	
<body style="overflow:hidden">
<div class="easyui-layout" fit=true data-options="border:false">  
	<div region="north" title="查询区" data-options="collapsible:true,singleSelect:true,border:false" style="height:55px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout">
			<colgroup>
				<col style="width: 8%">
				<col style="width: 15%">
				<col style="width: 8%">
				<col style="width: 15%">
				<col style="width: 8%">
				<col style="width: 15%">
				<col style="width: 20%">
			</colgroup>
			<tr>
				<td class="t">姓名</td>
				<td class="ts">
					<input data-field="USER_NAME" value="" />
				</td>
				<td class="t">登录名</td>
				<td class="ts">
					<input data-field="LOGIN_NAME" value="" />
				</td>
				<td class="t">用户ID</td>
				<td class="ts">
					<input data-field="USER_ID" value="" />
				</td>
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
	<div id="aa" region="center" title="您现在的位置:系统设置>用户管理" data-options="border:false">
		<div id="gridDiv" class="acws-grid" style="width:100%;min-height:200px;height:200px" url="./acws/security/queryusers.ajax"
			data-options="showPagebar:true" autoHeight=false fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>No</td>
						<td>姓名</td>
						<td>登陆名</td>
						<td>用户ID</td>
						<td>操作</td>
					</tr>
					<tr idField=USER_ID widthunit='%'>
						<td colField=null    	width=6 	align=center 	celltype=cntr></td>
						<td colField=USER_NAME 	width=* 	align=left 		celltype=ro sort=str></td>
						<td colField=LOGIN_NAME width=20 	align=left 		celltype=ro sort=str></td>
						<td colField=USER_ID 	width=15 	align=center 		celltype=ro sort=int></td>
						<td colField=OPERATE 	width=15 	align=center 		celltype=ro ></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
</div>
<script>
//页面初始化
$(function(){
	//1、初始化按钮：Grid行选中时可以修改、查看、删除
	var mygrid=Acws.getTargetObj("#gridDiv");
	
	mygrid.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var cellOperation = this.getCell(rId,'OPERATE');
		var btnValid = "<a href='javascript:void(0)' onclick=\"onSetRoleClick('"+rId+"')\">配置角色</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
						"<a href='javascript:void(0)' onclick=\"onViewUserAuthsClick('"+rId+"','true')\">查看权限</a>"
		cellOperation.setValue(btnValid);
	});
	
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

//配置角色事件
function onSetRoleClick(userId){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var userName = mygrid.getCellValue(userId,"USER_NAME");
	Acws.showDialog({url:'./acwsui/system/userRoleList.jsp',title:"用户 [<span style='color:red'>"+userName+"</span>]-配置角色",
		width:1000,height:500,modal:true,
		dialogParams:{userId:userId},
		dialogEvent:{},onClose:function(){}, 
		iconCls:'icon-setting'});
}

//查看用户权限事件
function onViewUserAuthsClick(userId){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var userName = mygrid.getCellValue(userId,"USER_NAME");
	Acws.showDialog({url:'./acwsui/system/userAuths.jsp',
		title:"用户 [<span style='color:red'>"+userName+"</span>]-查看权限",
		width:650,height:600,
		modal:true,
		iconCls:'icon-view',
		maximizable:false,
		dialogParams:{userId:userId,isReadonly:true},
		onClose:function(){}});
}
</script>
</body>
</html>