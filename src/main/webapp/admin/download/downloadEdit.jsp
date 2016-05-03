<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid" />
		<table width="400" class="input_table">
			<tr>
				<th width="100">文件链接：</th>
				<td><input type="text"  name="cfilepath" readonly="readonly" style="width:280px" />
				</td>
			</tr>
			<tr>
				<th width="100">文件名称：</th>
				<td width="300"><input type="text"  name="cfilename" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写文件名称！'" style="width:280px" />
				</td>
			</tr>
		</table>
	</form>
</div>