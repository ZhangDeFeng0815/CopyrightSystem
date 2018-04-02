<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>角色管理</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
</head>

<body class="easyui-layout acws_noborder_top" data-options="fit:true,border:false" style="overflow:hidden">
	<div region="center" data-options="border:false"  title="您现在的位置:系统设置>角色管理" toolbar="#mytoolbar"	>
		<div id="mytoolbar" class="acws-toolbar" enablebtn="btnAdd,btnCopy,btnExport,btnImport,btnCleanUp" disablebtn="btnEdit,btnDel">
			<a id="btnAdd"  iconCls="icon-add"  onclick="onEditClick(1)">新增</a>
			<a id="btnCopy"  iconCls="icon-copy"  onclick="onEditClick(3)">复制</a>
			<a id="btnEdit" iconCls="icon-edit" onclick="onEditClick(2)">修改</a>
			<a id="btnDel"  iconCls="icon-del"  onclick="onDelClick()" >删除</a>
			<a id="btnExport"  iconCls="icon-export"  onclick="onMoveUp()">上移</a>
			<a id="btnImport"  iconCls="icon-import"  onclick="onMoveDown()">下移</a>
			<a id="btnCleanUp"  iconCls="icon-del"  onclick="onCleanUpClick()" >垃圾数据清理</a>
		</div>
		<div id="gridDiv" class="acws-grid" data-options="multiline:false" fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>角色名称</td>
						<td>角色编号</td>
						<td>备注</td>
						<td>预留</td>
						<td>操作</td>
						<td></td>
						<td></td>
					</tr>
					<tr idField=ROLE_ID widthunit='%'>
						<td colField=ROLE_NAME 	width=25 	align=left 		celltype=ro ></td>
						<td colField=ROLE_ID 	width=10 	align=left 		celltype=ro ></td>
						<td colField=MEMO 	width=* 	align=left 		celltype=ro ></td>
						<td colField=TYPE_CH    width=5 align=center celltype=ch></td>
						<td colField=OPERATE 	width=15 	align=center 		celltype=ro ></td>
						<td colField=TYPE 	width=0 	align=left 		celltype=ro ></td>
						<td colField=STATUS 	width=0 	align=left 		celltype=ro ></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
<!-- 新增、修改页面 开始-->
<div id="dlgEdit" title="编辑" style="display:none;width:500px" modal=true buttons='#add-buttons'>
	<table class="acws-layout">
	<tr style='height:0px'>
		<td width=25%></td>
		<td width=75%></td>
	</tr>
	<tr>
		<td class="t">角色ID<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="ROLE_ID">(系统自动生成)</span>
		</td>
	</tr>
	<tr>
		<td class="t">角色名称<span class="bitian">*</span></td>
		<td class="ts">
			<input type="text" data-field="ROLE_NAME" valid="required" maxlength=256></input>
		</td>
	</tr>
	<tr>
		<td class="t">备注</td>
		<td class="ts">
			<textarea data-field="MEMO" maxlength=512  valid="length[0,512]"></textarea>
		</td>
	</tr>
	</table>	
	<div id="add-buttons" style="display:none">
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="onEditSaveClick()">保存</a>
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="Acws.closeDialog('#dlgEdit')">取消</a>
	</div>
</div>
<!-- 新增、修改页面面 结束-->
		
<script>
var dlgParams={};
//首页初始化
$(function(){
	//1、初始化按钮：Grid行选中时可以修改、查看、删除
	var mygrid=Acws.getTargetObj("#gridDiv");
	
	mygrid.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var type=this.getCellValue(rId,'TYPE');//类型 1：预留 2：自定义
		var TYPE_CH = this.getCell(rId,'TYPE_CH');
		TYPE_CH.setDisabled(true);
		if(type==1){
			TYPE_CH.setChecked(true);
			//TYPE_CH.setValue(1);
		}else{
			TYPE_CH.setChecked(false);
			//TYPE_CH.setValue(0);
		}
		var status = this.getCellValue(rId,'STATUS');//类型 1：启用 2：停用
		var cellOperation = this.getCell(rId,'OPERATE');
		var btnValid = "";
		//启用
		if(status==1){
			if(type==1){
				btnValid = "<a href='javascript:void(0)' onclick=\"onStatusClick('"+rId+"',0)\">停用</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<a href='javascript:void(0)' onclick=\"onUserAssignClick('"+rId+"')\">分配用户</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<a href='javascript:void(0)' onclick=\"onAuthAssignClick('"+rId+"','true')\">查看权限</a>"
			}else{
				btnValid = "<a href='javascript:void(0)' onclick=\"onStatusClick('"+rId+"',0)\">停用</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<a href='javascript:void(0)' onclick=\"onUserAssignClick('"+rId+"')\">分配用户</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<a href='javascript:void(0)' onclick=\"onAuthAssignClick('"+rId+"','false')\">分配权限</a>"
			}
		} else {
			btnValid = "<a href='javascript:void(0)' onclick=\"onStatusClick('"+rId+"',1)\">启用</a>";
		}
		cellOperation.setValue(btnValid);

	});

	mygrid.attachEvent("onRowSelect",function(id,ind){
		var type = this.getCellValue(id,'TYPE');//类型 1：预留 2：自定义
		if(type==2){
			$("#mytoolbar").acwstoolbar('enable','btnEdit,btnDel');
		}else{
			$("#mytoolbar").acwstoolbar('disable','btnEdit,btnDel');
		}
	});
	
	searchData();
});

//查询数据
function searchData(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	//调用后台获取Grid数据
	var inputData = {};
	inputData.gridSettings=mygrid.getGridSettings();
	Acws.ajax("./framework/system/role/roleList.ajax",inputData,function(outputData){
		mygrid.loadData(outputData.dataList);
	});
}

//工具栏：新增、修改按钮事件  type=1 新增  type=2 修改
function onEditClick(type){
	//1、打开新增修改对话框
	Acws.showDialog("#dlgEdit");
	if(type==1){
		Acws.resetJson("#dlgEdit",{ROLE_ID:"(系统自动生成)"});
		$("#dlgEdit").dialog("setTitle","新建");
	}else if(type==2){
		$("#dlgEdit").dialog("setTitle","修改");
		var mygrid=Acws.getTargetObj("#gridDiv");
		var roleId = mygrid.getSelectedId();
		var roleName = mygrid.getCellValue(roleId,"ROLE_NAME");
		var memo = mygrid.getCellValue(roleId,"MEMO");
		var roleData={ROLE_ID:roleId,
				ROLE_NAME:roleName,
				MEMO:memo};
		Acws.setJson("#dlgEdit", roleData);
		$A("ROLE_ID").numberbox("disable");
	}else if(type==3){
		$("#dlgEdit").dialog("setTitle","复制");
		var mygrid=Acws.getTargetObj("#gridDiv");
		var roleId = mygrid.getSelectedId();
		dlgParams.copyRoleId=roleId;
		var roleName = mygrid.getCellValue(roleId,"ROLE_NAME");
		dlgParams.copyRoleName=roleName;
		var memo = mygrid.getCellValue(roleId,"MEMO");
		var roleData={ROLE_ID:"(系统自动生成)",
				ROLE_NAME:roleName,
				MEMO:memo};
		Acws.setJson("#dlgEdit", roleData);
		//$A("ROLE_ID").numberbox("disable");
	}
	
}

//新增、修改对话框：保存按钮事件
function onEditSaveClick(){
	//1、校验
	if(!Acws.valid("#dlgEdit")){
		return;
	}
	
	//2、保存
	var mygrid=Acws.getTargetObj("#gridDiv");
	var inputData = Acws.getJson("#dlgEdit");
	if(inputData.ROLE_ID=='(系统自动生成)'){
		inputData.ROLE_ID='';
	}
	if(dlgParams.copyRoleId){
		inputData.copyRoleId=dlgParams.copyRoleId;
		if(inputData.ROLE_NAME==dlgParams.copyRoleName){
			//$("#role_name_ip").focus();
			_warn("请修改角色名");
			return false;
		}
	}
	inputData.roleGridSettings=mygrid.getGridSettings()
	Acws.ajax("./framework/system/role/saveRole.ajax", inputData, function(outputData){
		_alert(outputData.msg);
		if(outputData.success){
			//2.2、关闭对话框
			Acws.closeDialog("#dlgEdit");
			//2.3、刷新列表
			searchData();
		} 
	});
}

//工具栏：删除按钮事件
function onDelClick(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var roleId = mygrid.getSelectedId();
	if(!roleId){
		_warn("请选择需要删除的记录!");
		return false;
	}
	
	Acws.ajax("./framework/system/role/checkBeforDeleteRole.ajax", {roleId:roleId},function(outputData){
		var confirmMsg="";
		if(outputData.success==true){
			confirmMsg="该角色已经配置了用户和权限、您确认需要删除该角色吗？";
			doDelClick(confirmMsg,roleId);
		}else{
			confirmMsg="您确认需要删除该角色吗？";
			doDelClick(confirmMsg,roleId);
		}
	}); 
}

function doDelClick(confirmMsg,roleId){
	_confirm(confirmMsg,function(r){
		if(!r){
			return;
		}
		Acws.ajax("./framework/system/role/deleteRole.ajax", {roleId:roleId},function(outputData){
			_alert(outputData.msg);
			//2.1、输出操作结果信息
			if(outputData.success){
				//2.2、刷新列表
				searchData();
			}
		}); 
	});
}

//工具栏：垃圾清理
function onCleanUpClick(){
	Acws.ajax("./framework/system/role/cleanUp.ajax", {},function(outputData){
		_alert(outputData.msg);
	}); 
}

//上移
function onMoveUp(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var roleId = mygrid.getSelectedId();
	if(!roleId){
		_warn("请选择需要上移的记录!");
		return false;
	}
	mygrid.moveRow(roleId,"up");
	sortRole(mygrid);
}

//下移
function onMoveDown(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var roleId = mygrid.getSelectedId();
	if(!roleId){
		_warn("请选择需要下移的记录!");
		return false;
	}
	mygrid.moveRow(roleId,"down");
	sortRole(mygrid);
}

function sortRole(mygrid){
	var roleIds=mygrid.getAllRowIds();
	Acws.ajax("./framework/system/role/sortRole.ajax", {roleIds:roleIds},function(outputData){
		 if(outputData.success==true){
			_err(outputData.msg);
			//保存后台失败刷新列表
			searchData();
		}
	},{showMask:false});
}

//工具栏：停用/启用按钮事件
function onStatusClick(id, status){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var inputData = {};
	inputData.ROLE_ID = id;
	inputData.STATUS = status;
	Acws.ajax("./framework/system/role/saveRole.ajax", inputData,function(outputData){
		//输出操作结果信息
		var msg;
		if(status==1){
			msg="启用";
		}else{
			msg="停用";
		}
		if(outputData.success==true){
			//_alert(msg+"成功");
			//保存后台失败刷新列表
			searchData();
		}else{
			_err(msg+"失败");
		}
		
	});
}

//分配用户
function onUserAssignClick(roleId){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var roleName = mygrid.getCellValue(roleId,"ROLE_NAME");
	Acws.showDialog({url:"./acwsui/system/roleUserList.jsp",
		title:"角色管理-分配用户",
		width:1200,height:600,
		modal:true,
		maximizable:false,
		dialogParams:{roleId:roleId,roleName:roleName},
		onClose:function(){}});
}

//分配权限
function onAuthAssignClick(roleId, isReadonly){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var roleName = mygrid.getCellValue(roleId,"ROLE_NAME");
	var titleMsg = "权限";
	if(isReadonly=='true'){
		titleMsg = "查看"+titleMsg;
	}else{
		titleMsg = "分配"+titleMsg;
	}
	Acws.showDialog({url:'./acwsui/system/roleAuths.jsp',
		title:"角色 [<span style='color:red'>"+roleName+"</span>]-"+titleMsg,
		width:650,height:600,
		modal:true,
		maximizable:false,
		dialogParams:{roleId:roleId,roleName:roleName,isReadonly:isReadonly},
		onClose:function(){}});
}

</script>
</body>
</html>
