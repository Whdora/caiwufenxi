<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table width="500" class="input_table">
			<tr>
				<th width="77">菜单名称：</th>
				<td ><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写菜单名称！',style:'width:140px;'" /></td>
				<th width="77">菜单图标：</th>
				<td ><input name="iconCls" /></td>
			</tr>
			<tr>
				<th>菜单链接：</th>
				<td colspan="3"><input type="text" name="curl"  style="width:390px"/></td>
			</tr>
			<tr>
				<th>菜单顺序：</th>
				<td><input name="cseq" class="easyui-numberspinner" data-options="min:0,max:999,editable:false,required:true,missingMessage:'请选择菜单排序'" value="10" style="width:100px" /></td>
				<th>上级菜单：</th>
				<td><input id="menuAdd_pid" name="pid" /><span onclick="$('#menuAdd_pid').combotree('clear');" class="icon-clear" style="cursor: pointer;display:inline-block;vertical-align:middle;width:16px;height:16px;"></span></td>
			</tr>
		</table>
	</form>
</div>
