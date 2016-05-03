<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.portal.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/syUtil.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/<c:out value="${cookie.easyuiThemeName.value}" default="bootstrap"/>/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/icon.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/css.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/portal.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap-2.3.1/css/bootstrap.min.css" type="text/css"></link>
<script type="text/javascript">
	var portal;
	var panels;
	$(function() {
		portalLayout = $('#portalLayout').layout({
			fit : true
		});
		$(window).resize(function() {
			portalLayout.layout('panel', 'center').panel('resize', {
				width : 1,
				height : 1
			});
		});
		panels = [
				{
					id : 'p1',
					title : '最新通知',
					height : 280,
					collapsible : true,
					href : '${pageContext.request.contextPath}/announceAction!do_listAnnounce.action'
				},
				{
					id : 'p2',
					title : '常用链接',
					height : 280,
					collapsible : true,
					href : '${pageContext.request.contextPath}/linkAction!do_listLink.action'
				},
				{
					id : 'p3',
					title : '资料下载',
					height : 280,
					collapsible : true,
					href : '${pageContext.request.contextPath}/downloadAction!do_listDownload.action'
				} ,{
					id : 'p4',
					title : '系统说明',
					height : 280,
					collapsible : true,
					href : '${pageContext.request.contextPath}/layout/portal/about.jsp'
				}];
	portal = $('#portal').portal({
		border : false,
		fit : true,
		onStateChange : function() {
			$.cookie('portal-state', getPortalState(), {
				expires : 7
			});
		}
	});
	var state = $.cookie('portal-state');
	if (!state) {
		state = 'p1,p2:p3,p4';/*冒号代表列，逗号代表行*/
	}
	addPanels(state);
	portal.portal('resize');

});

function getPanelOptions(id) {
	for ( var i = 0; i < panels.length; i++) {
		if (panels[i].id == id) {
			return panels[i];
		}
	}
	return undefined;
}
function getPortalState() {
	var aa=[];
	for(var columnIndex=0;columnIndex<2;columnIndex++) {
		var cc=[];
		var panels=portal.portal('getPanels',columnIndex);
		for(var i=0;i<panels.length;i++) {
			cc.push(panels[i].attr('id'));
		}
		aa.push(cc.join(','));
	}
	return aa.join(':');
}
function addPanels(portalState) {
	var columns = portalState.split(':');
	for (var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
		var cc = columns[columnIndex].split(',');
		for (var j = 0; j < cc.length; j++) {
			var options = getPanelOptions(cc[j]);
			if (options) {
				var p = $('<div/>').attr('id', options.id).appendTo('body');
				p.panel(options);
				portal.portal('add', {
					panel : p,
					columnIndex : columnIndex
				});
			}
		}
	}
}
function moreAnnounce(){
	var node={"text":"通知管理","iconCls":"icon-options","attributes":{"url":"announceAction!announceManager.action"}};
	$(window.parent.addTab(node));
}

function moreDownload(){
	var node={"text":"常用下载","iconCls":"icon-download","attributes":{"url":"downloadAction!downloadManager.action"}};
	$(window.parent.addTab(node));
}
function moreLink(){
	var node={"text":"常用网址","iconCls":"icon-options","attributes":{"url":"linkAction!linkManager.action"}};
	$(window.parent.addTab(node));
}
</script>
</head>
<body>
<div id="portalLayout">
		<div data-options="region:'center',border:false">
			<div id="portal" style="position: relative">
				<div></div>
				<div></div>
			</div>
		</div>
	</div>
</body>
</html>
