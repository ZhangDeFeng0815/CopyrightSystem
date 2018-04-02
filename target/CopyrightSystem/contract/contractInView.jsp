<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>获权合同</title>
	<script type="text/javascript" src="./common/partner.select.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="footer: '#dlg-buttons',border:false" fit=true>
<div data-options="region:'center',border:false,footer: '#dlg-buttons'" title="" style="height:99px;overflow:hidden">
	<table id="conditionDiv" class="acws-layout">
		<colgroup>
			<col style="width: 20%">
			<col style="width: 80%">
		</colgroup>
		<tr>
			<td class="t">合同编号<span class="bitian">*</span></td>
			<td class="ts">
				<span class='acws-span' data-field="contractCd"></span>
			</td>
		</tr>
		<tr>
			<td class="t">合作商名称<span class="bitian">*</span></td>
			<td class="ts">
				<span class='acws-span' data-field="partnerName"></span>
			</td>
		</tr>
		<tr>
			<td class="t">千字稿酬</td>
			<td class="ts">
				<span class='acws-span' data-field="costpStr" data-options=""></span>
			</td>
		</tr>
		<tr>
			<td class="t">附件</td>
			<td class="ts">
			    <input id="attachmentId" type="hidden" data-field="attachmentId"/>
				<a id="attachmentDl" style="display:none;" class="easyui-linkbutton acws-download" data-options="iconCls:'icon-download'" 
                 data-service="$contractAttchDownload" onClickBefore="onClickBefore()"><span data-field="fileName"/></a>
			</td>
		</tr>
		<tr>
            <td class="t">创建时间</td>
            <td class="ts">
                <span class='acws-span' data-field="createDate" data-options="clazz:'date', dateFmt:'yyyy-MM-dd HH:mm:ss'"></span>
            </td>
        </tr>
        <tr>
            <td class="t">创建人</td>
            <td class="ts">
                <span class='acws-span' data-field="createUserName"></span>
            </td>
        </tr>
	</table>
</div>
</div>

<div id="dlg-buttons" class="buttons">
    <a id="attachmentDl" style="display:none;" class="easyui-linkbutton acws-download" data-options="iconCls:'icon-download'" data-service="$contractAttchDownload" onClickBefore="onClickBefore()">附件下载</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>
var dlgParams = {};
//弹出窗口初始化事件
function onAcwsDialogInit(params){
	onInitContractInInfo(params.cd);
	dlgParams = params;
}
function onPartnerSelect(){
	PartnerUtils.selectOne("", function(rec){
		$A("partnerId").setAcwsValue(rec.partnerId);
		$A("partnerName").setAcwsValue(rec.partnerName);
	});
}

function onInitContractInInfo(contractCd){
    var inputData = {"contractCd" : contractCd};
    //调用后台获取Grid数据
    Acws.ajax("./contract/viewContractIn.ajax",inputData,function(outputData){
    	Acws.setJson("#conditionDiv", outputData.contract);
    	$A("createUserName").setAcwsValue(dlgParams.createUserName);
    	if ($A("attachmentId").getAcwsValue() != "") {
            $("#attachmentDl").show();
        }
    },{showMask:false});
}

function onClickBefore() {
    var data = {};
    data.contractCd = $A("contractCd").getAcwsValue();
    data.type = "IN";
    return data;
}
</script>
</body>
</html>