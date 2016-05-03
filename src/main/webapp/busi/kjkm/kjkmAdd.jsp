<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table width="300" class="input_table">
			<tr>
				<th width="100">会计科目编号：</th>
				<td ><input type="text" name="cid" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写会计科目编号！'" /></td>
			</tr>
			<tr>
				<th width="100">会计科目名称：</th>
				<td ><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写会计科目名称！'" /></td>
			</tr>
			<tr>
				<th>显示顺序：</th>
				<td><input name="cseq" class="easyui-numberspinner" data-options="min:0,max:999,editable:true,required:true,missingMessage:'请选择排序'" value="10" /></td>
			</tr>
			<tr>
				<th>上级科目：</th>
				<td><input id="kjkmAdd_pid" name="pid" /><span onclick="$('#kjkmAdd_pid').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
		</table>
	</form>
</div>
