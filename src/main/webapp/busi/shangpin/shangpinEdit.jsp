<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid" />
		<br />
		<table width="300" class="input_table">
			<tr>
				<th width="100">商品名称：</th>
				<td ><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写商品名称！'" /></td>
			</tr>
		</table>
	</form>
</div>