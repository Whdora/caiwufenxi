<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table width="300" class="input_table">
			<tr>
				<th width="77">归类名称：</th>
				<td ><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写归类名称！'" /></td>
			</tr>
			<tr>
				<th>归类顺序：</th>
				<td><input name="cseq" class="easyui-numberspinner" data-options="min:0,max:999,editable:false,required:true,missingMessage:'请选择归类顺序'" value="10" /></td>
			</tr>
			<tr>
				<th>上级类别：</th>
				<td><input id="kindAdd_pid" name="pid" /><span onclick="$('#kindAdd_pid').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
		</table>
	</form>
</div>
