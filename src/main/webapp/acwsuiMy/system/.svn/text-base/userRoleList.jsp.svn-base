<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>用户配置角色</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
</head>
<body style="overflow:hidden">
	<div class="easyui-layout acws_noborder_top" data-options="fit:true,border:false" >
		<div region="center" title="您现在的位置:系统设置>用户管理>配置角色" data-options="border:false,footer:'#cancel-buttons'">
			<div id="gridDiv" class="acws-grid" style="width:100%;height:99%;" data-options="autoExpand:true,border:false,multiline:false">
				<table class="acwsgrid">
					<thead>
						<tr>
							<td>分配/取消</td>
							<td>角色名称</td>
							<td>角色编号</td>
							<td>备注</td>
							<td>是否预留</td>
							<td></td>
						</tr>
						<tr idField=ROLE_ID widthunit='%'>
							<td colField=IS_HAVE_CH  		width=7 	align=center 	celltype=ch></td>
							<td colField=ROLE_NAME 	width=25 	align=left 		celltype=ro ></td>
							<td colField=ROLE_ID 	width=10 	align=left 		celltype=ro ></td>
							<td colField=MEMO 	width=* 	align=left 		celltype=ro ></td>
							<td colField=TYPE_CH    width=6 align=center celltype=ro></td>
							<td colField=TYPE 	width=0 	align=left 		celltype=ro ></td>
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
function setUserRole(id,state){
	if(state==true){
		onAddUserRoleClick(id);
	}else{
		onDelUserRoleClick(id);
	}
}

//新增用户角色
function onAddUserRoleClick(roleId){
	/* _confirm("您确定为此用户分配当前角色关联吗？",function(r){
		if(!r)return;
		
	}); */
	Acws.ajax("./framework/system/role/batchAddRoleUser.ajax",{userIds:dlgParams.userId,roleId:roleId},function(outputData){
			if (outputData.success == false) {
				_err(outputData.msg);
				searchData();
			}
		}, {
			showMask : false
		});
}

//删除用户角色
function onDelUserRoleClick(roleId){
	/* _confirm('您确定为此用户取消当前角色关联吗？',function(r){
		if(!r)return;
		
	}); */
	
	Acws.ajax("./framework/system/role/batchDeleteRoleUser.ajax",{userIds:dlgParams.userId,roleId:roleId},function(outputData){
		if (outputData.success == false) {
			_err(outputData.msg);
			searchData();
		}
	}, {
		showMask : false
	});
}

//弹出窗口初始化事件
function onAcwsDialogInit(params){
	dlgParams = params || {};
	var mygrid=Acws.getTargetObj("#gridDiv");
	mygrid.attachEvent("onRowCreated", function(rId,rObj,rXml){
		var type=this.getCellValue(rId,'TYPE');//类型 1：预留 2：自定义
		var TYPE_CH = this.getCell(rId,'TYPE_CH');
		TYPE_CH.setDisabled(true);
		if(type==1){
			TYPE_CH.setValue("是");
		}else{
			TYPE_CH.setValue("否");
			//TYPE_CH.setBgColor('#d3d3d3');
			//TYPE_CH.getTextColor('#d3d3d3');
			
		}
	});
	
	mygrid.attachEvent("onCheck", function(rId,cInd,state){
		   if(state==true){
			   mygrid.cells(rId,cInd).setValue(1);
		   }else{
			   mygrid.cells(rId,cInd).setValue(0);
		   }
		   setUserRole(rId,state);
		});  
	
	/* $A("MEMO_SETTINGS").setAcwsValue(dlgParams.MEMO_SETTINGS);
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
	});  */
	searchData(); 
}

//查询数据
function searchData(){
	var mygrid=Acws.getTargetObj("#gridDiv");
	//调用后台获取Grid数据
	var inputData={};
	inputData.userId=dlgParams.userId;
	inputData.gridSettings=mygrid.getGridSettings();
	Acws.ajax("./framework/system/role/roleList.ajax",inputData,function(outputData){
		mygrid.loadData(outputData.dataList);
		var initHadRoles = outputData.initHadRoles;
		if(initHadRoles){
			var initHadRoleArr=initHadRoles.split(",");
			initHadRoleArr.forEach(function(value,index,array){
				mygrid.setCellValue(value,'IS_HAVE_CH',1);
	 		});
		}
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
