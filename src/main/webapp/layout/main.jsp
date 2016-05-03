<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML >
<html>
<head>
<title>痛快信息科技财务分析系统</title>
<meta name="renderer" content="webkit" >
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/syUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/btutil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/post.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/WdatePicker.js" defer="defer"></script>
<base href="<%=basePath%>" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/kindeditor-4.1.7/kindeditor-all-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/kindeditor-4.1.7/lang/zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/highcharts/highcharts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/highcharts/modules/exporting.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/highcharts/themes/grid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/<c:out value="${cookie.easyuiThemeName.value}" default="bootstrap"/>/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/icon.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/css.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/kindeditor-4.1.7/themes/default/default.css" type="text/css"></link>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',href:'layout/north.jsp'" style="height: 60px;overflow: hidden;border-bottom:none" ></div>
	<div data-options="region:'west',title:'功能菜单',href:'layout/west.jsp'" style="width: 200px;overflow: hidden;border-right:none"></div>
	<div data-options="region:'center',href:'layout/center.jsp'" style="overflow: hidden;"></div>
	<div data-options="region:'south',href:'layout/south.jsp'" style="height: 25px;overflow: hidden;"></div>
</body>
</html>
