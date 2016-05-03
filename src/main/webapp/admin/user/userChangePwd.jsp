<%@ page language="java"  pageEncoding="UTF-8"%>
<div style="padding: 5px;overflow: hidden;">
	<form id="userchangepwd_form" method="post">
		<input type="hidden" name="cid" />
		<table width="343" class="input_table">
			<tr>
				<th width="141">用户名：</th>
				<td width="340"><input type="text" name="cusername" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写用户名！'" />
				</td>
			</tr>
			<tr>
				<th>原密码：</th>
				<td><input type="password" name="oldpassword" class="easyui-validatebox" data-options="required:'true',missingMessage:'请输入原密码'" />
				</td>
			</tr>
			<tr>
				<th>新密码：</th>
				<td><input type="password" name="newpassword" class="easyui-validatebox" data-options="required:'true',missingMessage:'请输入新密码'" />
				</td>
			</tr>
			<tr>
				<th>重复新密码:</th>
				<td><input type="password" name="newpassword2" class="easyui-validatebox" data-options="required:'true',missingMessage:'请重复一次新密码',validType:'eqPassword[\'#userchangepwd_form input[name=newpassword]\']'" />
				</td>
			</tr>
		</table>
	</form>
</div>
