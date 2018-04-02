<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>菜单管理</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
</head>

<body class="easyui-layout acws_noborder_top" data-options="fit:true,border:false">
	<div region="center" title="您现在的位置:系统设置>菜单管理" data-options="border:false" toolbar="#mytoolbar"	style="overflow:hidden" >
		<div id="mytoolbar" class="acws-toolbar" enablebtn="btnAdd,btnEdit,btnDel,btnView,btnSetting,btnFabu,btnTingyong,btnExport,btnImport">
			<a id="btnAdd"  iconCls="icon-add"   menu="#menuAdd">新增</a>
			<a id="btnEdit" iconCls="icon-edit" onclick="onEditClick(2)">修改</a>
			<a id="btnDel"  iconCls="icon-del"  onclick="onDelClick()" >删除</a>
			<a id="btnView"  iconCls="icon-view"  onclick="onViewClick()">查看</a>
			<a id="btnSetting"  iconCls="icon-setting"  onclick="onSetResourceClick()">关联资源</a>
			<a id="btnFabu"  iconCls="icon-fabu"  onclick="onStatusClick(1)">启用</a>
			<a id="btnTingyong"  iconCls="icon-tingyong"  onclick="onStatusClick()">停用</a>
			<a id="btnExport"  iconCls="icon-export"  onclick="onMoveUp()">上移</a>
			<a id="btnImport"  iconCls="icon-import"  onclick="onMoveDown()">下移</a>
		</div>
		<div id="menuAdd" style="display:none;width:150px;">
			<div onclick="onEditClick(11)">新增一级菜单</div>
			<div onclick="onEditClick(12)">新增子菜单</div>
		</div>
		<div id="grdMenu" class="acws-grid" fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>菜单名称</td>
						<td>菜单编号</td>
						<td>是否启用</td>
						<td>备注</td>
						<td></td>
						<td></td>
					</tr>
					<tr idField=MENU_ID widthunit='%' treeField="MENU_ID,PARENT_MENU_ID">
						<td colField=MENU_NAME 	width=20 	align=left 		celltype=tree></td>
						<td colField=MENU_ID 	width=10 	align=left 		celltype=ro></td>
						<td colField=STATUS_SHOW 	width=5 	align=center celltype=ro></td>
						<td colField=MEMO 	width=* 	align=left 		celltype=ro></td>
						<td colField=PARENT_MENU_ID 	width=0 	align=left 	celltype=ro></td>
						<td colField=STATUS 	width=0 	align=left 		celltype=ro></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 查询页面 结束-->
		
	<!-- 新增、修改页面 开始-->
	<div id="dlgMenuEdit" title="编辑" style="display:none;width:500px" modal=true buttons='#add-buttons'>
		<input type="hidden" data-field="OP_TYPE"></input>
		<input type="hidden" data-field="STATUS"></input>
		<table class="acws-layout">
		<tr style='height:0px'>
			<td width=25%></td>
			<td width=75%></td>
		</tr>
		<tr>
			<td class="t">父菜单编号</td>
			<td class="ts">
				<span class="acws-span" data-field="PARENT_MENU_ID">(无)</span>
			</td>
		</tr>
		<tr>
			<td class="t">菜单编号<span class="bitian">*</span></td>
			<td class="ts">
				<span class="acws-span" data-field="MENU_ID">(系统自动生成)</span>
			</td>
		</tr>
		<tr>
			<td class="t">菜单名称<span class="bitian">*</span></td>
			<td class="ts">
				<input type="text" data-field="MENU_NAME" valid="required" maxlength=256></input>
			</td>
		</tr>
		<tr>
			<td class="t">菜单图标</td>
			<td class="ts">
				<input type="text" data-field="ICON1" maxlength=50></input>
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
			<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="Acws.closeDialog('#dlgMenuEdit')">取消</a>
		</div>
	</div>
	<!-- 新增、修改页面面 结束-->
	
	<!-- 查看页面 开始-->
	<div id="dlgView" title="查看" style="display:none;height:300px;width:500px" modal=true buttons='#view-buttons'>
		<table class="acws-layout">
			<tr style='height:0px'>
				<td width=25%></td>
				<td width=75%></td>
			</tr>
			<tr>
				<td class="t">父菜单编号</td>
				<td class="ts">
					<span class="acws-span" data-field="PARENT_MENU_ID">(无)</span>
				</td>
			</tr>
			<tr>
				<td class="t">菜单编号<span class="bitian">*</span></td>
				<td class="ts">
					<span class="acws-span" data-field="MENU_ID">(系统自动生成)</span>
				</td>
			</tr>
			<tr>
				<td class="t">菜单名称<span class="bitian">*</span></td>
				<td class="ts">
					<span class="acws-span" data-field="MENU_NAME"></span>
				</td>
			</tr>
			<tr>
				<td class="t">菜单图标</td>
				<td class="ts">
					<span class="acws-span" data-field="ICON1"></span>
				</td>
			</tr>
			<tr>
				<td class="t">备注</td>
				<td class="ts">
					<span class="acws-span" data-field="MEMO"></span>
				</td>
			</tr>
		</table>	
		<div id="view-buttons" style="display:none">
			<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="Acws.closeDialog('#dlgView')">关闭</a>
		</div>
	</div>
<!-- 查看页面 结束-->
<script>
var isOrNo={1:'是',0:'否'};
//首页初始化
$(function(){
	var mygrid=Acws.getTargetObj("#grdMenu");
	
	mygrid.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var cellStatus = this.getCell(rId,'STATUS');
		var status = cellStatus.getValue();
		var status_SHOW = this.getCell(rId,'STATUS_SHOW');
		status_SHOW.setValue(isOrNo[status]);
	});
	
	mygrid.attachEvent("onRowSelect",function(rId,rObj,rXml){
		var status = mygrid.getCellValue(rId,"STATUS");
		if(status==1){
			$("#mytoolbar").acwstoolbar('disable','btnFabu');
			$("#mytoolbar").acwstoolbar('enable','btnTingyong');
		} else {
			$("#mytoolbar").acwstoolbar('enable','btnFabu');
			$("#mytoolbar").acwstoolbar('disable','btnTingyong');
		}
	});
	searchData(); 
});

//查询数据
function searchData(){
	var mygrid=Acws.getTargetObj("#grdMenu");
	var inputData = {};
	inputData.gridSettings=mygrid.getGridSettings();
	//调用后台获取Grid数据
	Acws.ajax("./framework/system/menu/menuList.ajax",inputData,function(outputData){
		mygrid.loadData(outputData.dataList)
	});
}

//工具栏：新增、修改按钮事件  type=11 新增一级菜单 type=12 新增子菜单  type=2 修改
function onEditClick(type){
	//1、打开新增修改对话框
	Acws.resetJson("#dlgMenuEdit",{PARENT_MENU_ID:"(无)",MENU_ID:"(系统自动生成)"});
	$A("OP_TYPE").setAcwsValue(type);
	if(type==11){
		Acws.showDialog("#dlgMenuEdit");
		$("#dlgMenuEdit").dialog("setTitle","新建");
		$A("STATUS").val("1");//启用
	}else if(type==12){
		var mygrid=Acws.getTargetObj("#grdMenu");
		var menuId = mygrid.getSelectedId();
		if(!menuId){
			_warn("请先选择父级菜单");
		}
		Acws.showDialog("#dlgMenuEdit");
		$("#dlgMenuEdit").dialog("setTitle","新建");
		$A("PARENT_MENU_ID").setAcwsValue(menuId);
		$A("STATUS").val("1");//启用
	}else{
		var mygrid=Acws.getTargetObj("#grdMenu");
		var menuId = mygrid.getSelectedId();
		if(!menuId){
			_warn("请先选择要修改的记录");
			return false;
		}
		Acws.ajax("./framework/system/menu/getMenuById.ajax", {menuId:menuId},function(outputData){
			 if(outputData.success==true){
				 var menuData=outputData.menu;
				 Acws.showDialog("#dlgMenuEdit");
				 $("#dlgMenuEdit").dialog("setTitle","修改");
				 Acws.setJson("#dlgMenuEdit", menuData);
			}else{
				_err("找不到菜单ID为["+resId+"]的菜单");
				return false;
			}
		},{showMask:false});
	}
}

//新增、修改对话框：保存按钮事件
function onEditSaveClick(){
	//1、校验
	if(!Acws.valid("#dlgMenuEdit")){
		return;
	}
	
	//2、保存
	var mygrid=Acws.getTargetObj("#grdMenu");
	var inputData = Acws.getJson("#dlgMenuEdit");
	inputData.roleGridSettings=mygrid.getGridSettings()
	Acws.ajax("./framework/system/menu/saveMenu.ajax", inputData, function(outputData){
		_alert(outputData.msg);
		if(outputData.success){
			//2.2、关闭对话框
			Acws.closeDialog("#dlgMenuEdit");

			//2.3、刷新列表
			searchData();
		} 
	});
}

//工具栏：删除按钮事件
function onDelClick(){
	var mygrid=Acws.getTargetObj("#grdMenu");
	var menuId = mygrid.getSelectedId();
	if(!menuId){
		_warn("请选择需要删除的记录");
		return false;
	}
	var count = mygrid.hasChildren(menuId);
	if(count>0){
		_err("该菜单下有子菜单、为了安全起见、请先删除子菜单");
		return false;
	}
	doDelClick();
}

function doDelClick(){
	var mygrid=Acws.getTargetObj("#grdMenu");
	var selectedId = mygrid.getSelectedId();
	_confirm("您确认要删除该菜单吗？",function(r){
		if(!r){
			return;
		}
		var inputData = {};
		inputData.MENU_ID = selectedId;
		Acws.ajax("./framework/system/menu/deleteMenu.ajax", inputData,function(outputData){
			_alert(outputData.msg);
			//2.1、输出操作结果信息
			if(outputData.success){
				//2.2、刷新列表
				searchData();
			}
		}); 
	});
}

//查看
function onViewClick(){
	var mygrid = Acws.getTargetObj("#grdMenu");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要查看的菜单");
		return false;
	}
	Acws.ajax("./framework/system/menu/getMenuById.ajax", {menuId:selectedId},function(outputData){
		 if(outputData.success==true){
			 var menuData=outputData.menu;
			 Acws.showDialog("#dlgView");
			 Acws.setJson("#dlgView", menuData);
		}else{
			_err("找不到菜单ID为["+resId+"]的菜单");
			return false;
		}
	},{showMask:false});
}

//菜单资源管理
function onSetResourceClick(){
	var mygrid = Acws.getTargetObj("#grdMenu");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要设置的菜单");
		return false;
	}
	/*
	var count = mygrid.hasChildren(selectedId);
	if(count>0){
		_err("父级菜单不能关联资源，请重新选择");
		return false;
	}*/
	Acws.showDialog({url:'./acwsui/system/menuResourceList.jsp',title:"菜单资源关联管理（开发人员专用）",
		width:1000,height:500,modal:true,
		dialogParams:{MENU_ID:selectedId},
		dialogEvent:{},onClose:function(){}, 
		iconCls:'icon-edit'});
}

//工具栏：停用/启用按钮事件
function onStatusClick(status){
	var mygrid=Acws.getTargetObj("#grdMenu");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_alert("请选择需要操作的记录");
		return false;
	}
	var inputData = {};
	inputData.MENU_ID = selectedId;
	inputData.STATUS = status===1?1:0;
	Acws.ajax("./framework/system/menu/chgMenuStatus.ajax", inputData,function(outputData){
		//2.1、输出操作结果信息
		_alert(outputData.msg);
		//2.2、刷新列表
		searchData();
	});
}

//上移
function onMoveUp(){
	var mygrid=Acws.getTargetObj("#grdMenu");
	mygrid.moveRowUp(mygrid.getSelectedId());
	sortMenu(mygrid);
}

//下移
function onMoveDown(){
	var mygrid=Acws.getTargetObj("#grdMenu");
	mygrid.moveRowDown(mygrid.getSelectedId());
	sortMenu(mygrid);
}

function sortMenu(mygrid){
	var menuIds=mygrid.getAllRowIds();
	Acws.ajax("./framework/system/menu/sortMenu.ajax", {menuIds:menuIds},function(outputData){
		 if(outputData.success==true){
			_err(outputData.msg);
			//保存后台失败刷新列表
			searchData();
		}
	},{showMask:false});
}
</script>
</body>
</html>
