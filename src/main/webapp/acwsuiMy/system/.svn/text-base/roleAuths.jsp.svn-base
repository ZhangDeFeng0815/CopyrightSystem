<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
<%@ include file="/acwsui/acws.jsp"%>
<title>角色权限管理</title>
<%@ include file="/common/myapp.jsp"%>
<style>
.layout-panel-center .panel-header, .layout-panel-center .panel-body{border-right:none;boder-bottom:none;}
div.myborder1{border-left:none;border-right:1px solid #95B8E7!important;border-top:none;border-right:none}

</style>
</head>
<body>
	<div class="easyui-panel acws_noborder_top" data-options="iconCls: 'icon-setting',footer: '#dlg-buttons',border:false" fit=true>
		<div class="easyui-layout" data-options="border:false" fit=true>
			<div data-options="region:'west',title:'菜单',collapsible:false,split:false,border:false,headerCls:'myborder1',bodyCls:'myborder1'" style="width:300px;">
				<div id="menuTree" class="acws-tree" data-field='MENU_RES_TREE' 
					data-options="itemtype:'checkbox',checkTypeFlag:true,listField:'AUTH_LIST',valueField:'id',pvalueField:'pid',textField:'name',callback:{onClick:onTreeClick,onCheck:onTreeNodeCheck}" 
					valid="required">
				</div>
			</div>
			<div data-options="region:'center',border:false,title:'权限'">
				<div class="easyui-layout" data-options="fit:true,border:false">
					<div id='oprAuthDiv' region="north" title="操作权限" style="height:30%;overflow:hidden" data-options="border:false">
						<div id="gridOprAuthDiv" class="acws-grid" style="width:100%;height:99%;" data-options="autoExpand:true,border:false,multiline:false">
							<table class="acwsgrid">
								<thead>
									<tr>
										<td></td>
										<td>权限名称</td>
										<td>备注</td>
										<td></td>
									</tr>
									<tr idField=AUTH_ID widthunit='%'>
										<td colField=IS_HAVE_CH  		width=7 	align=center 	celltype=ch></td>
										<td colField=AUTH_NAME 	width=20 	align=left 		celltype=ro></td>
										<td colField=MEMO 	width=* 	align=left 		celltype=ro></td>
										<td colField=AUTH_ID 	width=0 	align=left 		celltype=ro></td>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div id='dataAuthDiv' region="center" title="数据权限" style="height:30%;overflow:hidden" data-options="border:false">
						<div id="gridDataAuthDiv" class="acws-grid" style="width:100%;height:99%;" data-options="autoExpand:true,border:false,multiline:false">
							<table class="acwsgrid">
								<thead>
									<tr>
										<td></td>
										<td>权限名称</td>
										<td>分组</td>
										<td>备注</td>
										<td></td>
										<td></td>
									</tr>
									<tr idField=AUTH_ID widthunit='%'>
										<td colField=IS_HAVE_CH  width=7 	align=center 	celltype=ch></td>
										<td colField=AUTH_NAME 	width=20 	align=left 		celltype=ro></td>
										<td colField=GROUPS_SHOW 	width=20 	align=left celltype=ro></td>
										<td colField=MEMO 	width=* 	align=left 		celltype=ro></td>
										<td colField=AUTH_ID 	width=0 	align=left 		celltype=ro></td>
										<td colField=GROUPS_COLOR 	width=0 	align=left 		celltype=ro></td>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div region="south" title="配置说明" style="height:40%;" data-options="border:false">
						&nbsp;<span class="acws-span" data-field="AUTH_MEMO"></span><br>
						<br>
						&nbsp;<span style='color:red'>※警告：</span><br>
						<p>
							&nbsp;&nbsp;&nbsp;&nbsp;该配置一般系统开发好后就配置完成。如果由于业务发生变化、确实需要修改权限。<br>
							&nbsp;&nbsp;&nbsp;&nbsp;需由产品经理充分考虑操作权限和数据权限的逻辑关系。<br>
							&nbsp;&nbsp;&nbsp;&nbsp;确保没有逻辑性错误的前提下再进行合理配置。<br>
							&nbsp;&nbsp;&nbsp;&nbsp;如果配置的操作权限和数据权限存在矛盾、可能导致不可挽回的结果。<br>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dlg-buttons" class="buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
	</div>
<script>
var dlgParams={};
//初始化显示Grid
function onAcwsDialogInit(params){
	dlgParams = params || {};
	initRoleMenuTree();
	var gridOprAuth=Acws.getTargetObj("#gridOprAuthDiv");
	gridOprAuth.attachEvent("onCheck", function(rId,cInd,state){
		   updateRoleAuth(rId,state);
		}); 
	var gridDataAuth=Acws.getTargetObj("#gridDataAuthDiv");
	gridDataAuth.attachEvent("onCheck", function(rId,cInd,state){
		   updateRoleAuth(rId,state);
		}); 
	gridDataAuth.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var color = gridDataAuth.getCellValue(rId,"GROUPS_COLOR");
		if(color){
			gridDataAuth.setRowColor(rId,color);
		}
	});
}

//初始化页面菜单树
function initRoleMenuTree(){
	 Acws.ajax("./framework/system/role/initRoleMenuTree.ajax",{ROLE_ID:dlgParams.roleId,isDisabled:dlgParams.isReadonly},
				function(outputData){
					Acws.setList("[data-field=MENU_RES_TREE]", outputData.menuTree);
					//隐藏权限
					Acws.setJson("#oprAuthDiv", {oprAuthList:[]});
					Acws.setJson("#dataAuthDiv", {dataAuthList:[]});
				},{showMask:false}); 
}

//加载权限列表
function loadAuthGrid(resId,initOprAuths,initDataAuths){
	var gridOprAuth=Acws.getTargetObj("#gridOprAuthDiv");
	var gridDataAuth=Acws.getTargetObj("#gridDataAuthDiv");
	var inputData = {};
	inputData.RES_ID=resId;
	inputData.STATUS=1;
	inputData.gridSettings=gridOprAuth.getGridSettings();
	inputData.gridDataSettings=gridDataAuth.getGridSettings();
	//调用后台获取Grid数据
	Acws.ajax("./framework/system/res/resourceAuthList.ajax",inputData,function(outputData){
		gridOprAuth.loadData(outputData.oprAuthList);
		//初始化所选菜单操作权限
		if(initOprAuths){
			var initOprAuthArr=initOprAuths.split(",");
	 		initOprAuthArr.forEach(function(value,index,array){
	 			gridOprAuth.setCellValue(value,'IS_HAVE_CH',1);
	 		});
		}
 		
		gridDataAuth.loadData(outputData.dataAuthList);
		//初始化所选菜单数据权限
		if(initDataAuths){
			var initDataAuthArr=initDataAuths.split(",");
	 		initDataAuthArr.forEach(function(value,index,array){
	 			gridDataAuth.setCellValue(value,'IS_HAVE_CH',1);
	 		});
		}
 		
 		//查看权限
		if(dlgParams.isReadonly=='true'){
			gridOprAuth.forEachRow(function(id){
				gridOprAuth.cells(id,0).setDisabled(true);
			});
			gridDataAuth.forEachRow(function(id){
				gridDataAuth.cells(id,0).setDisabled(true);
			});
		}
 		
	},{showMask:false});
}

//初始化角色选中菜单的操作权限
function initRoleAuth(){
	 Acws.ajax("./framework/system/role/initRoleMenuAuths.ajax",{roleId:dlgParams.roleId,menuResId:dlgParams.mySelectedTreeNodeId},
			function(outputData){
		 		var menuResId=dlgParams.mySelectedTreeNodeId;
		 		var menuResIdArr=menuResId.split("_");
		 		var resId=menuResIdArr[1];
		 		//加载权限列表
		 		loadAuthGrid(resId,outputData.initOprAuths,outputData.initDataAuths);
		 		$A("AUTH_MEMO").setAcwsValue(outputData.authMemo);
			},{showMask:false});
}

//设置角色权限
function updateRoleAuth(authId,isChecked){
	var inputData={};
	inputData.roleId=dlgParams.roleId;
	inputData.menuResId=dlgParams.mySelectedTreeNodeId;
	inputData.authId=authId;
	inputData.isChecked=isChecked;
	Acws.ajax("./framework/system/role/updateRoleAuth.ajax", inputData,
				function(outputData) {
					if (outputData.success == false) {
						_err(outputData.msg);
					}
					initRoleAuth();
				}, {showMask : false});
	}

	function onTreeClick(event, treeId, treeNode) {
		//_alert("您点击了【"+treeNode.name+"】")
		dlgParams.mySelectedTreeNodeId = treeNode.id;
		if (treeNode.isParent == false) {
			initRoleAuth();
		}
	}

	function onTreeNodeCheck(event, treeId, treeNode) {
		 //alert(treeNode.id + ", " + treeNode.pid + ", " +treeNode.name + "," + treeNode.checked);
		var treeObj = Acws.getTargetObj("[data-field=MENU_RES_TREE]");
		//取消兄弟节点选中状态
		var pNode = treeNode.getParentNode();
		var nodes = pNode.children;
		for (var i = 0; i < nodes.length; i++) {
			if (nodes[i].id !== treeNode.id) {
				nodes[i].checked = false;
				treeObj.updateNode(nodes[i]);
			}
		}
		//保存菜单入口页面
		var inputData = {};
		inputData.roleId = dlgParams.roleId;
		if (treeNode.checked == true) {
			inputData.menuResId = treeNode.id;
			//显示权限
			dlgParams.mySelectedTreeNodeId = treeNode.id;
			initRoleAuth();
		}
		inputData.menuId = treeNode.pid;
		Acws.ajax("./framework/system/role/settingEnterPage.ajax", inputData,
				function(outputData) {
					if (outputData.success == false) {
						_err(outputData.msg);
						initRoleMenuTree();
					}
				}, {
					showMask : false
				});
	}
</script>
</body>
</html>