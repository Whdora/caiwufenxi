<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid" />
		<table width="400" class="input_table">
			<tr>
				<th width="100">链接名称：</th>
				<td><input type="text"  name="ctitle" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写链接名称！'" style="width:280px" />
				</td>
			</tr>
			<tr>
				<th width="100">链接地址：</th>
				<td width="300"><input type="text"  name="curl" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写链接地址！'" style="width:280px" />
				</td>
			</tr>
		</table>
	</form>
</div>