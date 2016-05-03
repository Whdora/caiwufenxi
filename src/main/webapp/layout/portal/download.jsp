<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<div align="center" style="padding:8px;">
<table class="table   table-condensed" style="border-bottom: 1px dotted #DDDDDD" >
	<thead>
		<tr>
			<th width="25%">上传时间</th>
			<th width="60%">文件名</th>
			<th width="15%">发布人</th>
		</tr>
	</thead>
	<tbody>
	<s:iterator value="alist">
		<tr>
			<td style="border-top: 1px dotted #DDDDDD"><s:date name="cuploaddate" format="yyyy-MM-dd HH:mm:ss"/></td>
			<td style="border-top: 1px dotted #DDDDDD"><a  href="${pageContext.request.contextPath}/downAction!download.action?filename=<s:property value='cfilename' />&filepath=<s:property value='cfilepath' />" ><s:property value="cfilename" /></a></td>
			<td style="border-top: 1px dotted #DDDDDD"><s:property value="userName" /></td>
		</tr>
	</s:iterator>
</table>
<a  href="javascript:void(0)" class="btn btn-small pull-right" onclick="moreDownload();" >更多 &raquo;</a>
</div>