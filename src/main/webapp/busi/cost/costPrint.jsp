<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.PrintArea.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/printTable.css" type="text/css"></link>
<script type="text/javascript">
	function doPrintCost(){
		$('#CostPrintArea').printArea();
	}
</script>
</head>
<body>
<div id="CostPrintArea" align="center">
<div style="height:150px"></div>
<table  style="font-size:12px;margin-left:130px;">
	<tr style="height:44px;">
	  <td width="260" ></td>
	  <td width="260" align="center" style="letter-spacing:10px;font-size:18px;font-weight:bold;">${datas.lzfs }费用报销单</td>
	  <td width="260" align="center" style="font-size:8px;">单证编号：第${datas.dzbh }号</td>
	</tr>
	<tr>
	  <td width="260" align="left">部门：${datas.deptName }</td>
	  <td width="260" align="center"><fmt:formatDate value="${now }" dateStyle="long" pattern="yyyy年MM月dd日" /></td>
	  <td width="260" align="right">单位：元</td>
	</tr>
</table>
<table class="printTable" style="font-size:12px;margin-left:130px;">
	<thead>
		<tr>
			<td width="260">事由(摘要)</td>
			<td width="180">会计科目</td>
			<td width="100">所属专业</td>
			<td width="100">金额</td>
			<td width="140">审批</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="row" items="${datas.rows }" varStatus="i">
			<tr>
				<td>${row.cshiyou }</td>
				<td>${row.subjectId}${row.subjectName}</td>
				<td>${row.zrzxName}</td>
				<td><fmt:formatNumber value="${row.camount+row.csj}" pattern="#0.00" /> </td>
				<c:if test="${i.first}">
				<td rowspan="8" ></td>
				</c:if>
			</tr>
		</c:forEach>
		<c:if test ="${datas.total <8}" >
			<c:forEach begin="${datas.total}" end="7" varStatus="i">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:forEach>
		</c:if>
		<tr>
			<td>合计：    ${datas.lzfs }</td>
			<td>￥：<fmt:formatNumber value="${datas.amount }" pattern="#0.00" /></td>
			<td colspan="3">人民币：${datas.upperNumber }</td>
		</tr>
	</tbody>
</table>
<table style="font-size:12px;margin-left:130px;">
	<tr>
		<td width="200" align="left">附件单据：&nbsp;&nbsp;&nbsp;&nbsp;张</td>
	  <td width="200" align="left">会计审批：</td>
	  <td width="180" align="left">出纳：</td>
	  <td width="200" align="left">收款人：</td>
	</tr>
</table>
</div>
<br />
<div align="center">
<input type="button" value="打印单据" onclick="doPrintCost()" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="关闭窗口"  onclick="window.close()" />
</div>
</body>
</html>
