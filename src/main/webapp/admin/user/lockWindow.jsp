<%@ page language="java"  pageEncoding="UTF-8"%>
<div style="padding: 5px;overflow: hidden;">
	<div align="center">
		<form id="lockInputForm" method="post">
			<input name="cid" type="hidden" />
			<table class="input_table">
				<tr>
					<th >登录名：</th>
					<td><input name="cusername" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th >密码：</th>
					<td><input name="cpassword" type="password" class="easyui-validatebox" data-options="required:true,missingMessage:'请输入密码！'"  style="width: 150px;" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
