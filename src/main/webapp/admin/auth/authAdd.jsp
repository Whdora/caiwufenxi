<%@ page language="java"  pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table class="input_table">
			<tr>
				<th width="77">权限名称：</th>
				<td width="200"><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写权限名称！'" /></td>
			</tr>
			<tr>
				<th >权限链接：</th>
				<td ><input type="text" name="curl"  /></td>
			</tr>
			<tr>
				<th>排序：</th>
				<td><input name="cseq" class="easyui-numberspinner" data-options="min:0,max:999,editable:true,required:true,missingMessage:'请选择排序！'" value="10"  /></td>
			</tr>
			<tr>
				<th>上级权限：</th>
				<td><input id="authAdd_pid" name="pid" /><span onclick="$('#authAdd_pid').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
		</table>
	</form>
</div>