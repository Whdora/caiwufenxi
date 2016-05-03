<%@ page language="java" pageEncoding="UTF-8"%>
<div style="padding: 5px;overflow: hidden;">
	<form id="useradd_form" method="post">
		<table width="343" class="input_table">
			<tr>
				<th width="141">用户名：</th>
				<td width="340"><input type="text" name="cusername" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写用户名！'" />
				</td>
			</tr>
			<tr>
				<th>密码：</th>
				<td><input type="password" name="cpassword" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写登录密码'" />
				</td>
			</tr>
			<tr>
				<th>重复密码:</th>
				<td><input type="password" name="cpassword2" class="easyui-validatebox" data-options="required:'true',missingMessage:'请再次填写密码',validType:'eqPassword[\'#useradd_form input[name=cpassword]\']'" />
				</td>
			</tr>
			<tr>
				<th>所属单位：</th>
				<td><input id="useradd_dept" class="easyui-combotree" name="cdepartment" data-options="url:'deptAction!do_showDept.action',panelHeight:'auto',required:true" />
				</td>
			</tr>
			<tr>
				<th>用户角色：</th>
				<td><input id="useradd_role" class="easyui-combobox" name="roleIds" data-options="valueField:'cid',textField:'cname',url:'roleAction!do_combobox.action',panelHeight:'auto',required:true" /></td>
			</tr>
		</table>
	</form>
</div>
