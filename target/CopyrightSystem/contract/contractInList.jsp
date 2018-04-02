<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>获权合同库</title>
</head>
<body style="overflow:hidden">
<div class="easyui-layout" data-options="border:false" fit=true>  
	<div region="north" title="查询区" data-options="collapsible:true,singleSelect:true,border:false" style="height:54px;overflow:hidden" >
		<table id="conditionDiv" class="acws-layout">
			<colgroup>
				<col style="width: 5%">
				<col style="width: 16%">
				<col style="width: 5%">
				<col style="width: 16%">
				<col style="width: 5%">
				<col style="width: 16%">
				<col style="width: 5%">
				<col style="width: 16%">
				<col style="width: 16%">
			</colgroup>
			<tr>
				<td class="t">合同编号</td>
				<td class="ts">
					<input class='easyui-textbox' data-field="CONTRACT_CD" value=""/>
				</td>
				<td class="t">合作商名称</td>
				<td class="ts" colspan=5>
					<input class='easyui-textbox' data-field="PARTNER_NAME" value="" style="width:95%"/>
				</td>
				
				<td class="ts" style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" onclick="onSearchClick()">查询</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onClearClick()">重置</a>
				</td>
			</tr>
		</table>
	</div>
		
		
	<div id="aa" region="center" title="您现在的位置:合同管理>获权合同" toolbar="#gridToolbar" data-options="border:false">
		<div id="gridToolbar" class="acws-toolbar" enablebtn="btnNew,btnEdit,btnView" disablebtn="">
			<a id="btnNew" class="acws_auth" authids="20000214" iconCls="icon-add"  onclick="onAddClick()">新增</a>
			<a id="btnEdit" class="acws_auth" authids="20000214" iconCls="icon-edit"  onclick="onEditClick()">修改</a>
			<a id="btnView"  iconCls="icon-view"  onclick="onViewClick()">查看</a>
		</div>
		<div id="gridDiv" class="acws-grid"
			style="width:100%;min-height:200px;height:200px;" 
			url="./contract/getContractInList.ajax"
			data-options="showPagebar:true,pageList:[50,100,200]" autoHeight=false fit=true>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>序号</td>
						<td>#master_checkbox</td>
						<td>合同编号</td>
						<td>合作商编号</td>
						<td>合作商名称</td>
						<td>千字稿酬</td>
						<td>创建人</td>
						<td>创建时间</td>
					</tr>
					<tr idField=contractId widthunit='%'>
						<td colField=null 			width=5 	align=center 	celltype=cntr></td>
						<td colField=null 			width=5 	align=center 	celltype=ch></td>
						<td colField=contractCd 	width=25 	align=center 	celltype=ro 	sort=str></td>
						<td colField=partnerId 		width=10 	align=center	celltype=ro 	sort=str></td>
						<td colField=partnerName 	width=25 	align=left 		celltype=ro 	sort=str></td>
						<td colField=costpStr	    width=8 	align=right	 	celltype=ro 	sort=str></td>
						<td colField=createUserName width=10 	align=center 	celltype=ro 	sort=str></td>
						<td colField=createDate 	width=12 	align=center 	celltype=at  	sort=str></td>
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
	initSearchCondition();
	onSearchClick();
});


//初始化查询条件
function initSearchCondition(){
	Acws.resetJson("#conditionDiv",{});
	
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

//新增
function onAddClick(){
	Acws.showDialog({url:'./contract/contractInAdd.jsp',title:'获权合同',width:400,height:300,modal:true,
		iconCls:'icon-add',dialogParams:{},dialogEvent:{onDialogClose: onSearchClick}});
}

//修改
function onEditClick(){
	var id = getGridSingleSelectedId();
	if(!id) return;
	var mygrid = Acws.getTargetObj("#gridDiv");
    var cd = mygrid.getCellValue(id, "contractCd");
    var createUserName = mygrid.getCellValue(id, "createUserName");
	Acws.showDialog({url:'./contract/contractInEdit.jsp',title:'获权合同',width:400,height:300,modal:true,
		iconCls:'icon-edit',dialogParams:{id:id, cd:cd, createUserName:createUserName},dialogEvent:{onDialogClose: onSearchClick}});
}

//查看
function onViewClick(){
	var id = getGridSingleSelectedId("查看");
	if(!id) return;
	var mygrid = Acws.getTargetObj("#gridDiv");
	var cd = mygrid.getCellValue(id, "contractCd");
	var createUserName = mygrid.getCellValue(id, "createUserName");
	Acws.showDialog({url:'./contract/contractInView.jsp',title:"获权合同",
		width:400,height:300,modal:true, dialogParams:{id:id, cd:cd, createUserName:createUserName},dialogEvent:{onDialogClose: onSearchClick}});
}

function getGridSingleSelectedId(){
	var mygrid = Acws.getTargetObj("#gridDiv");
	var id = mygrid.getCheckedIds();
	if(!id){
		_alert("请先选择一个合同、再执行该操作!");
		return false;
	} 
	
	var checkArr = id.split(",");
	if(checkArr.length > 1){
		_alert("只能选择单个合同，请重新选择");
		return false;
	}
	return id;
}
</script>
</body>
</html>