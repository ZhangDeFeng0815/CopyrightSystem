<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>菜单资源关联管理</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
</head>

<body>
	<div class="easyui-layout acws_noborder_top" data-options="fit:true,border:false" >
		<div class="acws_noborder_top" region="center" title="您现在的位置1:系统设置>菜单管理>菜单资源关联管理" toolbar="#mytoolbar"	data-options="border:false,footer:'#cancel-buttons'">
			<div id="mytoolbar" class="acws-toolbar" enablebtn="btnAdd,btnDel,btnExport,btnImport"	data-options="border:false">
				<a id="btnAdd"  iconCls="icon-add"    onclick="onAddClick()">新增</a>
				<a id="btnDel"  iconCls="icon-del"  onclick="onDelClick()">删除</a>
				<a id="btnExport"  iconCls="icon-export"  onclick="onMoveUp()">上移</a>
				<a id="btnImport"  iconCls="icon-import"  onclick="onMoveDown()">下移</a>
			</div>
			<div id="gridDiv" class="acws-grid"  data-options="border:false,multiline:false" fit=true>
				<table class="acwsgrid">
					<thead>
						<tr>
							<td>资源编号</td>
							<td>资源名称</td>
							<td>是否入口</td>
							<td>备注</td>
							<td>路径</td>
							<td></td>
						</tr>
						<tr idField=ID widthunit='%'>
							<td colField=RES_ID 	width=10 	align=left 		celltype=ro sort=str></td>
							<td colField=RES_NAME 	width=20 	align=left 	celltype=ro sort=str></td>
							<td colField=IS_ENTER_CH  		width=7 	align=center 	celltype=ch></td>
							<td colField=RES_MEMO width=* align=left celltype=ro sort=str></td>
							<td colField=PATH 	width=30 	align=left 		celltype=ro sort=str></td>
							<td colField=IS_ENTER width=0 	align=left 	celltype=ro></td>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div id="cancel-buttons" class="buttons" data-options="border:false">
			<a  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog();">关闭</a>
		</div>
	</div>
	<!-- 查询页面 结束-->
<script>
var dlgParams={};

//设置是否入口
function updateMenuResEnter(id,state){
	Acws.ajax("./framework/system/menu/updateMenuResEnter.ajax", {menuResId:id,enterValue:state}, function(outputData){
		if(outputData.success==false){
			//更新失败，刷新列表
			_alert(outputData.msg);
			searchData();
		} 
	},{showMask:false});
}

//弹出窗口初始化事件
function onAcwsDialogInit(params){
	dlgParams = params || {};
	$A("MEMO_SETTINGS").setAcwsValue(dlgParams.MEMO_SETTINGS);
	var mygrid = Acws.getTargetObj("#gridDiv");
	mygrid.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var IS_ENTER = this.getCellValue(rId,"IS_ENTER");
		var IS_ENTER_CH = this.getCell(rId,'IS_ENTER_CH');
		if(IS_ENTER==="1"){ 
			IS_ENTER_CH.setValue(1);
		}else{
			IS_ENTER_CH.setValue(0);
		}
	});
	mygrid.attachEvent("onCheck", function(rId,cInd,state){
	   if(state==true){
		   mygrid.cells(rId,cInd).setValue(1);
	   }else{
		   mygrid.cells(rId,cInd).setValue(0);
	   }
	   updateMenuResEnter(rId,state);
	}); 
	searchData(); 
}

//查询数据
function searchData(){
	var inputData = {};
	var mygrid = Acws.getTargetObj("#gridDiv");
	inputData.gridSettings=mygrid.getGridSettings();
	inputData.MENU_ID=dlgParams.MENU_ID;
	//调用后台获取Grid数据
	Acws.ajax("./framework/system/menu/menuResourceList.ajax",inputData,function(outputData){
		mygrid.loadData(outputData.dataList)
	});
}

function onAddClick(){
	Acws.showDialog({url:'./acwsui/system/selectResources.jsp',title:"资源选择",
		width:1000,height:500,modal:true,
		dialogParams:{},
		dialogEvent:{onOkClick: onAddCallBackClick},onClose:function(){}, 
		iconCls:'icon-edit'});
}

function onAddCallBackClick(resIds){
	//保存
	var mygrid=Acws.getTargetObj("#gridDiv");
	var inputData = {};
	inputData.MENU_ID = dlgParams.MENU_ID;
	inputData.RESIDS = resIds;
	Acws.ajax("./framework/system/menu/saveMenuResource.ajax", inputData, function(outputData){
		_alert(outputData.msg);
		if(outputData.success){
			//刷新列表
			searchData();
		} 
	});
}

//工具栏：删除按钮事件
function onDelClick(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var selectedId = mygrid.getSelectedId();
	if(!selectedId){
		_warn("请选择需要删除的记录!");
		return false;
	}
	_confirm("您确认要删除与该资源的关联关系吗？",function(r){
		if(!r){
			return;
		}
		Acws.ajax("./framework/system/menu/deleteMenuRes.ajax", {id:selectedId},function(outputData){
			_alert(outputData.msg);
			//2.1、输出操作结果信息
			if(outputData.success){
				//2.2、刷新列表
				searchData();
			}
		}); 
	});
}

//上移
function onMoveUp(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var id = mygrid.getSelectedId();
	if(!id){
		_warn("请选择需要上移的记录!");
		return false;
	}
	mygrid.moveRow(id,"up");
	sortMenuRes(mygrid);
}

//下移
function onMoveDown(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	var id = mygrid.getSelectedId();
	if(!id){
		_warn("请选择需要下移的记录!");
		return false;
	}
	mygrid.moveRow(id,"down");
	sortMenuRes(mygrid);
}

function sortMenuRes(mygrid){
	var ids=mygrid.getAllRowIds();
	Acws.ajax("./framework/system/menu/sortMenuRes.ajax", {ids:ids},function(outputData){
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
