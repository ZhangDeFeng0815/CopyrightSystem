<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>资源管理</title>
</head>
	
<body style="overflow:hidden">
<div class="easyui-layout" data-options="border:false" fit=true>  
	<div region="north" title="查询区" data-options="collapsible:true,singleSelect:true,border:false" style="height:55px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout">
			<colgroup>
				<col style="width: 8%">
				<col style="width: 20%">
				<col style="width: 8%">
				<col style="width: 20%">
				<col style="width: 8%">
				<col style="width: 20%">
				<col style="width: 16%">
			</colgroup>
			<tr>
				<td class="t">资源编号</td>
				<td class="ts">
					<input data-field="RES_ID" value=""/>
				</td>
				<td class="t">资源名称</td>
				<td class="ts">
					<input data-field="RES_NAME" value="" />
				</td>
				<td class="t">菜单</td>
				<td class="ts">
					<input class="easyui-combotree" style="width:200px;"
						data-field="MENU_SELECT_TREE" 
						data-options="valueField:'id',pvalueField:'PARENT_MENU_ID',textField:'MENU_NAME'"></input>
				</td>
				
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
		
	<div id="aa" region="center" title="您现在的位置:系统设置>资源管理（开发人员专用）" data-options="border:false" toolbar="#gridToolbar">
		<div id="gridToolbar" class="acws-toolbar" enablebtn="btnAdd,btnEdit,btnDel,btnView,btnSetting,btnViewMenu" disablebtn="">
			<a id="btnAdd" iconCls="icon-add" onclick="onAddClick()">新增</a>
			<a id="btnEdit"  iconCls="icon-edit"  onclick="onEditClick()">修改</a>
			<a id="btnDel"  iconCls="icon-del"  onclick="onDelClick()">删除</a>
			<a id="btnView"  iconCls="icon-view"  onclick="onViewClick()">查看</a>
			<a id="btnSetting"  iconCls="icon-setting"  onclick="onSetResourceAuthClick()">权限管理</a>
			<a id="btnViewMenu"  iconCls="icon-view"  onclick="onViewMenuResourceClick()">查看关联菜单</a>
		</div>
		<div id="gridDiv" class="acws-grid" style="width:100%;height:99%;" data-options="autoExpand:true,multiline:false">
			<table class="acwsgrid">
				<thead>
					<tr>
						<td></td>
						<td>资源编号</td>
						<td>资源名称</td>
						<td>类型</td>
						<td>路径</td>
						<td>备注</td>
						<td></td>
						<td></td>
					</tr>
					<tr idField=RES_ID widthunit='%'>
						<td colField=null 		width=2 	align=center 	celltype=cntr></td>
						<td colField=RES_ID 	width=10 	align=left 		celltype=ro sort=str></td>
						<td colField=RES_NAME 	width=20 	align=left 	celltype=ro sort=str></td>
						<td colField=TYPE_SHOW	width=6 	align=left 		celltype=ro sort=str></td>
						<td colField=PATH 	width=30 	align=left 		celltype=ro sort=str></td>
						<td colField=MEMO width=* align=left celltype=ro sort=str></td>
						<td colField=TYPE 		width=0 	align=center 	celltype=ro sort=str></td>
						<td colField=MEMO_SETTINGS 		width=0 	align=center 	celltype=ro sort=str></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<!-- 新增、修改页面 开始-->
<div id="dlgEdit" title="编辑" style="display:none;width:500px;overflow:hidden" modal=true buttons='#add-buttons'>
	<input type="hidden" data-field="OP_TYPE"></input>
	<table class="acws-layout">
	<tr style='height:0px'>
		<td width=25%></td>
		<td width=75%></td>
	</tr>
	<tr>
		<td class="t">资源编号<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="RES_ID">(系统自动生成)</span>
		</td>
	</tr>
	<tr>
		<td class="t">资源名称<span class="bitian">*</span></td>
		<td class="ts">
			<input type="text" data-field="RES_NAME" valid="required" maxlength=256></input>
		</td>
	</tr>
	<tr>
		<td class="t">资源类型<span class="bitian">*</span></td>
		<td class="ts">
			<select class="easyui-combobox" data-field="TYPE" valid="required" style="width:150px;">
				<option value="1">页面</option>
				<option value="2">JavaScript</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="t">资源路径<span class="bitian">*</span></td>
		<td class="ts">
			<input type="text" data-field="PATH" valid="required" maxlength=512></input>
		</td>
	</tr>
	<tr>
		<td class="t">备注</td>
		<td class="ts">
			<textarea data-field="MEMO" maxlength=512  valid="length[0,512]"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan=2 class="ts bitian">
			※：资源名称命名规范：(模块名) + "-" + (页面名)
		</td>
	</tr>
	</table>	
	<div id="add-buttons" style="display:none">
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="onEditSaveClick()">保存</a>
		<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="Acws.closeDialog('#dlgEdit')">取消</a>
	</div>
</div>
<!-- 新增、修改页面面 结束-->

<!-- 查看页面 开始-->
<div id="dlgView" title="查看" style="display:none;width:500px" modal=true buttons='#view-buttons'>
	<table class="acws-layout">
	<tr style='height:0px'>
		<td width=25%></td>
		<td width=75%></td>
	</tr>
	<tr>
		<td class="t">资源编号<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="RES_ID">(系统自动生成)</span>
		</td>
	</tr>
	<tr>
		<td class="t">资源名称<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="RES_NAME"></span>
		</td>
	</tr>
	<tr>
		<td class="t">资源类型<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="TYPE_SHOW"></span>
		</td>
	</tr>
	<tr>
		<td class="t">资源路径<span class="bitian">*</span></td>
		<td class="ts">
			<span class="acws-span" data-field="PATH"></span>
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
//页面初始化
$(function(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	mygrid.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var type = this.getCellValue(rId,"TYPE");
		var typeShow = this.getCell(rId,'TYPE_SHOW');
		if(type==="1"){ 
			typeShow.setValue("页面");
		}else if(type==="2"){
			typeShow.setValue("JavaScript");
		}else{
			typeShow.setValue(type);
		}
	});
	
	//加载菜单选择树
	Acws.ajax("./framework/system/res/menuTreeDataList.ajax",{},function(outputData){
		//alert(JSON.stringify(outputData.dataList));
		Acws.setList("[data-field=MENU_SELECT_TREE]", outputData.dataList);
		$A("MENU_SELECT_TREE").combotree('setValue',"no_0");
		onSearchClick();
	});
	
});
//查询事件       
function onSearchClick(){
	var inputData = Acws.getJson("#conditionDiv");
	var mygrid = Acws.getTargetObj("#gridDiv");
	inputData.gridSettings=mygrid.getGridSettings();
	inputData.MENU_ID=$A("MENU_SELECT_TREE").combotree("getValue");
	//调用后台获取Grid数据
	Acws.ajax("./framework/system/res/resourceList.ajax",inputData,function(outputData){
		mygrid.loadData(outputData.dataList)
	});
}

//清除事件
function onClearClick(){
	Acws.resetJson("#conditionDiv",{});
	$A("MENU_SELECT_TREE").combotree('clear');
}

//新增
function onAddClick(){
	//1、打开新增修改对话框
	Acws.resetJson("#dlgEdit",{RES_ID:"(系统自动生成)",OP_TYPE:'add'});
	Acws.showDialog("#dlgEdit");
	$("#dlgEdit").dialog("setTitle","新建");
}

//新增、修改对话框：保存按钮事件
function onEditSaveClick(){
	//1、校验 Resource
	if(!Acws.valid("#dlgEdit")){
		return;
	}
	//2、保存
	var inputData = Acws.getJson("#dlgEdit");
	Acws.ajax("./framework/system/res/saveResource.ajax", inputData, function(outputData){
		_alert(outputData.msg);
		if(outputData.success){
			//2.2、关闭对话框
			Acws.closeDialog("#dlgEdit");
			//2.3、刷新列表
			onSearchClick();
		} 
	});
}

//修改
function onEditClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要修改的资源");
		return false;
	}
	Acws.ajax("./framework/system/res/getResourceById.ajax", {resId:selectedId},function(outputData){
		 if(outputData.success==true){
			 var resourceData=outputData.resource;
			 resourceData.OP_TYPE="edit";
			 Acws.showDialog("#dlgEdit");
			 $("#dlgEdit").dialog("setTitle","修改");
			 Acws.setJson("#dlgEdit", resourceData);
		}else{
			_err("找不到资源ID为["+resId+"]的资源");
			return false;
		}
	},{showMask:false});
}

//查看
function onViewClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要查看的资源");
		return false;
	}
	Acws.ajax("./framework/system/res/getResourceById.ajax", {resId:selectedId},function(outputData){
		 if(outputData.success==true){
			 var resourceData=outputData.resource;
			 
			 if(resourceData.TYPE=='1'){
				 resourceData.TYPE_SHOW="页面";
			 }else if(resourceData.TYPE=='0'){
				 resourceData.TYPE_SHOW="JavaScript";
			 }else{
				 resourceData.TYPE_SHOW=resourceData.TYPE;
			 }
			 Acws.showDialog("#dlgView");
			 Acws.setJson("#dlgView", resourceData);
		}else{
			_err("找不到资源ID为["+resId+"]的资源");
			return false;
		}
	},{showMask:false});
}
	
//权限管理
function onSetResourceAuthClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要设置的资源");
		return false;
	}
	var resName=mygrid.getCellValue(selectedId,"RES_NAME");
	var MEMO_SETTINGS=mygrid.getCellValue(selectedId,"MEMO_SETTINGS");
	var RES_ID=mygrid.getCellValue(selectedId,"RES_ID");
	Acws.showDialog({url:'./acwsui/system/resourceAuthList.jsp',title:"资源权限管理（开发人员专用） [<span style='color:red'>"+resName+"</span>]",
		width:1000,height:1500,modal:true,
		dialogParams:{RES_ID:RES_ID,MEMO_SETTINGS:MEMO_SETTINGS},
		dialogEvent:{onOkClick: onSearchClick},onClose:function(){}, 
		iconCls:'icon-edit'});
}

//查看已关联菜单
function onViewMenuResourceClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要查看的资源");
		return false;
	}
	Acws.showDialog({url:'./acwsui/system/viewMenuResourceList.jsp',title:"关联菜单",
		width:600,height:400,modal:true,
		dialogParams:{RES_ID:selectedId},
		dialogEvent:{},onClose:function(){}, 
		iconCls:'icon-view'});
}

//删除事件
function onDelClick(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请先选择要删除的记录");
		return;
	}
	
	//校验是否已关联菜单
	Acws.ajax("./framework/system/res/checkForDeleteResource.ajax",{RES_ID:selectedId},function(outputData){
		if(outputData.success==true){
			doDelRes(selectedId);
		}else{
			_err("已关联菜单的资源不能删除");
			return false;
		}
	},{showMask:false});
}
function doDelRes(resId){
	_confirm("您确认要删除该资源吗？",function(q){
		if(!q){
			return;
		}
		Acws.ajax("./framework/system/res/deleteResource.ajax",{resId:resId},
			function(outputData){
				_alert(outputData.msg);
				onSearchClick();
			});
	});
}
</script>
</body>
</html>