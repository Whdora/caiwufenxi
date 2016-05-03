<%@ page language="java"  pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid" /> 
		<table class="input_table">
			<tr>
				<th width="77">角色名称：</th>
				<td width="300" ><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写角色名称！'" style='width:250px;' /></td>
			</tr>
			<tr>
				<th>菜单权限：</th>
				<td ><input id="menuids" type="text" name="menuIds"  style='width:250px;'/><span onclick="$('#menuids').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
			<tr>
				<th>操作权限：</th>
				<td><input id="authids" name="authIds"  style='width:250px;'/><span onclick="$('#authids').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
			<tr>
				<th>角色描述：</th>
				<td ><textarea name="cdesc" style="height: 100px;width:250px;font-size:12px;"></textarea></td>
			</tr>
		</table>
	</form>
</div>
