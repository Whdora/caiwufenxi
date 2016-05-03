<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table class="input_table">
			<tr>
				<th width="77">单位名称：</th>
				<td width="200"><input type="text" name="cdeptName" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写单位名称！'" /></td>
			</tr>
			<tr>
				<th>显示顺序：</th>
				<td><input name="cseq" class="easyui-numberspinner" data-options="min:0,max:999,editable:true,required:true,missingMessage:'请选择排序'" value="10" /></td>
			</tr>
			<tr>
				<th>上级单位：</th>
				<td><input id="deptAdd_pid" name="pid" /><span onclick="$('#deptAdd_pid').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
		</table>
	</form>
</div>