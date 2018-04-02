<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
<%@ include file="/acwsui/acws.jsp"%>
<title>角色用户管理</title>
<%@ include file="/common/myapp.jsp"%>
<script>
//初始化显示Grid
function onAcwsDialogInit(params){
	Acws.setJson("#divRoleInfo",params);

	onSearchAllClick();

	onSearchMyClick();
}

//添加角色用户
function onMyUserAddClick(){
	var mygridAll=Acws.getTargetObj("#userAllGrid");
	var ids = mygridAll.getCheckedIds();
	if(!ids){
		_alert("请选择用户再执行添加操作!");
		return;
	}
	var userNames="";
	var idArr = ids.split(",");
	userNames = mygridAll.getCellValue(idArr[0],"USER_NAME");
	for(var i=1; i<idArr.length; i++){
		userNames += ","+mygridAll.getCellValue(idArr[i],"USER_NAME");
	}

	_confirm("您确定要添加这些用户的角色关联么？",function(r){
		if(!r)return;
		Acws.ajax("./acws/security/role/addRoleUsers.ajax",{userIds:ids,
			userNames:userNames,
			roleId:$A("roleId").getAcwsValue()},
		function(o){
			_alert(o.msg);
			if(o.success){
				onSearchMyClick();
			}
		});
	});
}

//删除角色用户
function onMyUserDelClick(){
	var mygridMy=Acws.getTargetObj("#userMyGrid");
	var ids = mygridMy.getCheckedIds();
	if(!ids){
		_alert("请选择用户再执行添加操作!");
		return;
	}
	_confirm('您确定要解除这些用户的角色关联么？',function(r){
		if(!r)return;
		Acws.ajax("./acws/security/role/delRoleUsers.ajax",{userIds:ids,roleId:$A("roleId").getAcwsValue()},function(o){
			_alert(o.msg);
			if(o.success){
				onSearchMyClick();
			}
		});
	});
}

//搜索所有用户
function onSearchAllClick(){
	//取得grid对象和grid参数（包括id和列的字段名等）
	var mygridAll=Acws.getTargetObj("#userAllGrid");
	var inputData = Acws.getJson("#divAllUser");
	mygridAll.loadPagedData(inputData);
}
//搜索所有用户
function onSearchMyClick(){
	//取得grid对象和grid参数（包括id和列的字段名等）
	var mygridMy=Acws.getTargetObj("#userMyGrid");
	var inputData = Acws.getJson("#divMyUser");
	inputData.ROLE_ID=$A("roleId").getAcwsValue();
	mygridMy.loadPagedData(inputData);
}

//保存事件
function onSaveClick(){
	if(Acws.valid("body")){
		var data = Acws.getJson("body");
		Acws.triggerDialogEvent("onSaveClick", data);
		Acws.closeDialog();
	}
}
</script>
</head>
<body>
	<div class="easyui-panel" data-options="iconCls: 'icon-save',footer: '#dlg-buttons',border:false" fit=true>
		<div class="easyui-layout" data-options="border:false" fit=true>    
			<div data-options="region:'west',title:'所有用户',collapsible:false,split:false,border:false" style="width:500px;">
				<div class="easyui-layout" data-options="fit:true,border:false">
					<!--所有用户  开始-->
					<div region="north" title="" data-options="collapsible:true,border:false" style="height:32px;overflow:hidden;">
						<table id="divAllUser" class="acws-layout">
							<colgroup>
								<col style="width: 10%">
								<col style="width: 30%">
								<col style="width: 10%">
								<col style="width: 30%">
								<col style="width: 20%">
							</colgroup>
							<tr>
								<td class="t">账号</td>
								<td class="ts"><input type="text" data-field="LOGIN_NAME" maxlength=20/></td>
								<td class="t">姓名</td>
								<td class="ts">
									<input type="text" data-field="USER_NAME" maxlength=20/>
								</td>
								<td class="ts"style="text-align:center">
									<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchAllClick()">查询</a>
								</td>
							</tr>
						</table>
					</div>
					
					<div region="center" data-options="border:false" title="">
						<div id="userAllGrid" class="acws-grid"
							style="width:100%;min-height:200px;height:200px" url="./acws/security/queryusers.ajax"
							data-options="showPagebar:true" autoHeight=false fit=true>
							<table class="acwsgrid">
								<thead>
									<tr>
										<td>#master_checkbox</td>
										<td>No</td>
										<td>用户ID</td>
										<td>登陆名</td>
										<td>姓名</td>
									</tr>
									<tr idField=USER_ID widthunit='%'>
										<td colField=CHECKED    width=6 align=center celltype=ch></td>
										<td colField=null    	width=6 	align=center 	celltype=cntr></td>
										<td colField=USER_ID 	width=22 	align=left 		celltype=ro sort=str></td>
										<td colField=LOGIN_NAME width=32 	align=left 		celltype=ro sort=str></td>
										<td colField=USER_NAME 	width=34 	align=left 		celltype=ro sort=str></td>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<!-- 所有用户 结束-->			
			</div>
			<div data-options="region:'east',title:'已选用户',collapsible:false,split:false" style="width:500px;">
				<div class="easyui-layout" data-options="fit:true,border:false">
					<!--已选用户  开始-->
					<div region="north" title="" data-options="collapsible:true" style="height:32px;overflow:hidden;">
						<table id="divMyUser" class="acws-layout">
							<colgroup>
								<col style="width: 10%">
								<col style="width: 70%">
								<col style="width: 20%">
							</colgroup>
							<tr>
								<td class="t">用户ID</td>
								<td class="ts"><input type="text" data-field="USER_ID" maxlength=20/></td>
								<td class="ts"style="text-align:center">
									<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchMyClick()">查询</a>
								</td>
							</tr>
						</table>
					</div>
					
					<div region="center" title="">
						<div id="userMyGrid" class="acws-grid"
							style="width:100%;min-height:200px;height:200px" url="./acws/security/role/userlist.ajax"
							data-options="showPagebar:true" autoHeight=false fit=true>
							<table class="acwsgrid">
								<thead>
									<tr>
										<td>#master_checkbox</td>
										<td>No</td>
										<td>用户ID</td>
										<td>登陆名</td>
										<td>姓名</td>
									</tr>
									<tr idField=USERID widthunit='%'>
										<td colField=CHECKED    width=6 	align=center celltype=ch></td>
										<td colField=null    	width=6 	align=center 	celltype=cntr></td>
										<td colField=USERID 	width=22 	align=left 		celltype=ro sort=str></td>
										<td colField=LOGIN_NAME width=32 	align=left 		celltype=ro sort=str></td>
										<td colField=USER_NAME 	width=34 	align=left 		celltype=ro sort=str></td>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<!-- 已选用户 结束-->				
			</div>
			<div data-options="region:'center',title:'角色信息'">
				<table id="divRoleInfo" class="acws-layout">
					<colgroup>
						<col style="width: 100%">
					</colgroup>
					<tr>
						<td class="t" style="text-align:left;height:26px">角色ID</td>
					</tr>
					<tr>
						<td class="ts" style="height:26px"><span data-field="roleId" /></td>
					</tr>
					<tr>
						<td class="t" style="text-align:left;height:26px">角色名称</td>
					</tr>
					<tr>
						<td class="ts" style="height:26px">
							<span data-field="roleName"/>
						</td>
					</tr>
				</table>
				<br><br>
				<div style="width:100%">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="onMyUserAddClick()" style="width:150px;height:40px;margin-left:20px;">&gt;&gt;</a><br><br>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-del'" onclick="onMyUserDelClick()" style="width:150px;height:40px;margin-left:20px;">&lt;&lt;</a>
				</div>
			</div>
		</div>
	</div>
	

	<div id="dlg-buttons" class="buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
	</div>
</body>
</html>