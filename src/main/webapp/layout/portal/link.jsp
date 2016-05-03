<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<div align="center" style="padding:8px;">
<table class="table   table-condensed" style="border-bottom: 1px dotted #DDDDDD" >
	
	<s:iterator value="alist">
		<tr>
			<td style="border-top: 1px dotted #DDDDDD"><a class="btn btn-small btn-success" style="width:150px" target="_blank" href='<s:property value="curl" />'><s:property value="ctitle" /></a></td>
		</tr>
	</s:iterator>
</table>
<a  href="javascript:void(0)" class="btn btn-small pull-right" onclick="moreLink();" >更多 &raquo;</a>
</div>