<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html style="width: 100%;height: 100%;overflow: hidden;">
<head>
<title>痛快科技财务分析系统</title>
<meta name="renderer" content="webkit" >
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<link rel="stylesheet" href="js/themes/bootstrap/easyui.css" type="text/css">
<link rel="stylesheet" href="js/themes/icon.css" type="text/css">
<link media="screen" type="text/css" href="js/themes/login.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<script type="text/javascript" >
//  $(function(){
//	  if ($.browser.msie){
//		  location.href="chrome.jsp";
//	  }
//  });
</script>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;padding: 0;margin: 0;">
	<form id="form-body" style="display: none;">
		<ul>
			<li><label>账 号: </label> <input
					value="admin"
					class="easyui-validatebox account form-textbox" type="text" id="cusername" name="cusername" required></li>
			<li><label>密 码 :</label> <input
					value="123456"
					class="easyui-validatebox  password form-textbox" type="password" id="cpassword" name="cpassword" required></li>
		</ul>
	</form>
	<div id="logo" style="display: none;">
		<h1>痛快科技财务分析系统</h1>
	</div>
</body>
</html>