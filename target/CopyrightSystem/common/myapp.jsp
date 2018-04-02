<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
/**
 * 公共页面设置
 * 公共JS、CSS引入
 */
%>
<style>

/*去掉easyui的按钮虚线框*/
a.l-btn:focus {
    outline:none;
    -moz-outline:none;
}

input[type="text"]{
	width: 95%
}

.x-panel-tl {
	background: transparent url(../images/default/panel/corners-sprite.gif)
		no-repeat 0 0;
	padding-left: 6px;
	zoom: 1;
	border-bottom: 1px solid #99bbe8;
}

.t {
	background-color: #E0ECFF;
	text-align: right
}

#desktop-portal {
	background-color: #fff;
	border-color: rgb(223, 232, 246);
}

.acws_auth{display:none}

.combo-panel{border-right:1px solid #95B8E7;}

.textbox .icon-popedit{margin-top:1px;}
.icon-popedit{
	background:url('./acwsui/easyui1.4/themes/icons/calendar_select_week.png') no-repeat;
}

</style>
<script type="text/javascript">
function addMainTab(p){
 	$('#tabsMain').bspt('addTab',p);
}
/*--acwsauth--*/
$(function(){
	$(".acws_auth[authids]").each(function(){
		var me=$(this);
		var objAuthIds=me.attr("authids");
		if(!objAuthIds) return true;
		var authIdArr=objAuthIds.split(",");
		//多个权限，只要有一个权限就显示
		for(var j=0; j<authIdArr.length; j++){
			if(Acws.hasAuth(authIdArr[j])){
				me.show();
				return true;
			}else{
				me.hide();
			}
		}
     });
});
</script>
