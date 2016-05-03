<%@ page language="java"  pageEncoding="UTF-8"%>
<div style="padding: 5px;overflow: hidden;">
	<form id="useredit_form" method="post">
	    <input name="cid" type="hidden" />
		<table id="useredit_table" width="343" class="input_table">
			<tr>
				<th width="141">用户名：</th>
				<td width="340"><input type="text" name="cusername" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写用户名！'" /></td>
			</tr>
			<tr>
				<th>密码：</th>
				<td><input type="password" name="cpassword" /></td>
			</tr>
			<tr>
				<th>创建时间：</th>
				<td><input type="text" name="ccreatedatetime" class="easyui-my97"  /></td>
			</tr>
			<tr>
				<th>修改时间：</th>
				<td><input type="text" name="cmodifydatetime" class="easyui-my97"  /></td>
			</tr>
			<tr>
				<th>所属单位：</th>
				<td><input id="useredit_dept" class="easyui-combotree" name="cdepartment" data-options="url:'deptAction!do_showDept.action',panelHeight:'auto',required:true" /></td>
			</tr>
			<tr>
				<th>用户角色：</th>
				<td><input id="useredit_role" class="easyui-combobox" name="roleIds" data-options="valueField:'cid',textField:'cname',url:'roleAction!do_combobox.action',panelHeight:'auto',required:true" /></td>
			</tr>
		</table>
	</form>
</div>