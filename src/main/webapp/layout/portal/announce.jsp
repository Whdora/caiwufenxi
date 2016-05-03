<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<script>
function showAnnounce(cid) {

	var p = parent.sy.dialog({
		title : '通知详细内容',
		modal : true,
		maximizable : true,
		width : 600,
		height : 500,
		buttons : [
                    {
                        text : '关闭',
                        iconCls : 'icon-exit',
                        handler : function (){
                     	   p.dialog('close');
                     	   }
                        }],
		content : '<iframe src="${pageContext.request.contextPath}/announceAction!do_showContent.action?cid=' + cid + '" frameborder="0" style="border:0;width:100%;height:99.0%;"></iframe>'
	});
}
</script>
<div align="center" style="padding:8px;">
<table class="table   table-condensed" style="border-bottom: 1px dotted #DDDDDD" >
	<thead>
		<tr>
			<th width="25%">发布时间</th>
			<th width="60%">通知标题</th>
			<th width="15%">发布人</th>
		</tr>
	</thead>
	<tbody>
	<s:iterator value="alist">
		<tr>
			<td style="border-top: 1px dotted #DDDDDD"><s:date name="ccreatedate" format="yyyy-MM-dd HH:mm:ss"/></td>
			<td style="border-top: 1px dotted #DDDDDD"><a  href="javascript:void(0)" onclick="showAnnounce('<s:property value="cid" />')"><s:property value="ctitle" /></a></td>
			<td style="border-top: 1px dotted #DDDDDD"><s:property value="userName" /></td>
		</tr>
	</s:iterator>
</table>
<a  href="javascript:void(0)" class="btn btn-small pull-right" onclick="moreAnnounce();" >更多 &raquo;</a>
</div>