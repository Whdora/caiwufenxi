<%@ page language="java" pageEncoding="UTF-8"%>
<script>
var announce_edit_editor;
$(function() {
		announce_edit_editor = KindEditor.create('#announce-edit-content', {
			width : '680px',
			height : '300px',
			items : [ 'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak', 'anchor', 'link', 'unlink' ],
			uploadJson : '${pageContext.request.contextPath}/uploadAction!upload.action',
			allowFileManager : false
		});
});
</script>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid" />
		<table width="800" class="input_table">
			<tr>
				<th width="100">通知标题：</th>
				<td ><input type="text" name="ctitle" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写通知标题！'"  style="width:680px"/></td>
			</tr>
			<tr>
				<th width="100">通知内容：</th>
				<td ><textarea name="ccontent" id="announce-edit-content" style="visibility: hidden;"></textarea></td>
			</tr>
		</table>
	</form>
</div>