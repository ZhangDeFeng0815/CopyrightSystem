<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<title>批量退订</title>
		<%@ include file="/acwsui/acws.jsp"%>
		<%@ include file="/common/myapp.jsp"%>
		<style>
		input{width:95%}
		.acws-toolbar{background-color:rgb(171, 199, 236);height:25px;
			-webkit-background-clip: border-box;
			-webkit-background-origin: padding-box;
			-webkit-background-size: auto;
			background-attachment: scroll;
			background-attachment: scroll;
			background-clip: border-box;
			background-color: rgba(0, 0, 0, 0);
			background-image: url(./images/corners-sprite.gif)  repeat-x 0 -126px;;
			background-origin: padding-box;
			background-size: auto;}
		.acws-toolbar .x-panel-tl{background:transparent url(../images/default/panel/corners-sprite.gif) no-repeat 0 0;padding-left:6px;zoom:1;border-bottom:1px solid #99bbe8;}
		.t, .ts,#desktop-portal{background-color:rgb(223, 232, 246);border-color:rgb(223, 232, 246);}
		.t{text-align: right}
		#conditionDiv{border-color:rgb(223, 232, 246);}
		</style>
	</head>
	
	<body>
	<div id="tabsMain" class="easyui-tabs" data-options="fit:true,border:true">
		<div id="desktop-portal" border="false" title="批量退订" data-options="tabWidth:80,fit:true,border:false">
		</div>
		<div id="desktop-portal" border="false" title="批量退订操作文件查询" data-options="tabWidth:150,fit:true,border:false" style="overflow:auto">
		<table id="conditionDiv" class="acws-table x-panel-tl" style="margin-bottom:2px">
			<colgroup>
				<col style="width: 10%">
				<col style="width: 30%">
				<col style="width: 10%">
				<col style="width: 40%">
				<col style="width: 10%">
			</colgroup>
			<tr>
				<td class="t">操作员</td>
				<td class="ts"><input type="text" data-field="BOOK_NAME"
					id="book_name" /></td>
				<td class="t">文件名</td>
				<td class="ts">
					<input type="text" data-field="BOOK_NAME"
					id="book_name"  /></td>
				</td>
				<td class="ts" rowspan=3 style="text-align:center">
					<a class="easyui-linkbutton" iconCls="icon-search" style="padding:5px">查询</a>
				</td>
			</tr>
			<tr>
				<td class="t">开始时间</td>
				<td class="ts"><input class="acws-date" data-field="PEN_NAME" value="2015-03-01"/>
				<td class="t">结束时间</td>
				<td class="ts"><input class="acws-date"  data-field="AUTHOR_NAME" value="2015-03-31"/>
			</tr>
		</table>
		<div id="gridDiv" class="acws-grid"
			style="width:100%;min-height:100px;height:100%" data-options="minHeight:100" autoHeight=false>
			<table class="acwsgrid">
				<thead>
					<tr>
						<td>文件名</td>
						<td>导入开始时间</td>
						<td>导入结束时间</td>
						<td></td>
						<td></td>
						<td>操作员</td>
						<td>操作</td>
					</tr>
					<tr idField=id widthunit='%'>
						<td colField=FILE_NAME width=30 align=left celltype=ro sort=str></td>
						<td colField=START_TIME width=15 align=center celltype=ro sort=str>
						</td>
						<td colField=END_TIME width=15 align=center celltype=ro sort=str></td>
						<td colField=USER_CONFIRM width=0 align=center celltype=ro sort=str></td>
						<td colField=OP_TYPE width=0 align=center celltype=ro sort=str></td>
						<td colField=USER_NAME width=8 align=center celltype=ro
							sort=str></td>
						<td colField=OP width=32 align=center celltype=ro sort=str></td>
					</tr>
				</thead>
			</table>
		</div>
	</div>
		</div>
	</div>
		
	<script>
	
	$(function(){
		$("#gridDiv").height(100);
		var mygrid = Acws.getTargetObj("#gridDiv");
		mygrid.enableAutoHeight(true);
		mygrid.addRow(mygrid.uid(),
				['20150320批量退订.txt','2015-03-20 15:31:21','2015-03-20 15:31:22','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150319批量退订.txt','2015-03-19 16:01:11','2015-03-19 16:01:12','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150318批量退订.txt','2015-03-18 15:30:21','2015-03-18 15:30:22','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150317批量退订.txt','2015-03-17 14:31:01','2015-03-17 14:31:03','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150316批量退订.txt','2015-03-16 14:31:21','2015-03-16 14:31:22','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150315批量退订.txt','2015-03-15 15:31:21','2015-03-15 15:31:22','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150314批量退订.txt','2015-03-14 15:28:17','2015-03-14 15:28:18','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150313批量退订.txt','2015-03-13 15:31:01','2015-03-13 15:31:03','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150312批量退订.txt','2015-03-12 13:50:13','2015-03-12 13:50:14','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150311批量退订.txt','2015-03-11 14:25:41','2015-03-11 14:25:42','否','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150310批量退订.txt','2015-03-10 15:11:23','2015-03-10 15:11:24','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150309批量退订.txt','2015-03-09 16:28:51','2015-03-09 16:28:52','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150308批量退订.txt','2015-03-08 15:33:41','2015-03-08 15:33:42','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150307批量退订.txt','2015-03-07 14:37:28','2015-03-07 14:37:29','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150306批量退订.txt','2015-03-06 15:43:35','2015-03-06 15:43:36','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150305批量退订.txt','2015-03-05 16:39:41','2015-03-05 16:39:42','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150304批量退订.txt','2015-03-04 13:51:19','2015-03-04 13:51:20','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150303批量退订.txt','2015-03-03 15:38:38','2015-03-03 15:38:39','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150302批量退订.txt','2015-03-02 15:00:21','2015-03-02 15:00:22','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		mygrid.addRow(mygrid.uid(),
				['20150301批量退订.txt','2015-03-01 15:45:16','2015-03-01 15:45:17','是','批量退订','徐飞','<a href="#"><img src="./acwsui/easyui1.4/themes/icons/filesave.png" ></img>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><img src="./acwsui/easyui1.4/themes/icons/book_open.png" ></img>查看</a>'],0);
		//mygrid.loadData(gridData);
	});

	</script>
	</body>
</html>
