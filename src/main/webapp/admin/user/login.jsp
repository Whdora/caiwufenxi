<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		$("#user_login_loginForm input[name=username]").focus();
		$('#user_login_loginForm').form({
			 url:'${pageContext.request.contextPath}/userAction!do_login.action',
		      success:function(r) {
		          var obj=$.parseJSON(r);
	              if (obj.success) {
	    	          $('#user_login_loginDialog').dialog('close');
	              }   
		      $.messager.show({title:'提示',msg:obj.msg});
		      }
		});
	});
</script>
<div id="user_login_loginDialog" class="easyui-dialog"
		data-options="title:'系统登录',modal:true,closable:false,buttons:[{
				text:'登录',
				iconCls:'icon-ok',
				handler:function(){$('#user_login_loginForm').submit();}
			},{
				text:'注册',
				iconCls:'icon-edit',
				handler:function(){
				$('#index_regform input').val('');
				$('#index_regdialog').dialog('open');
				}
			}]">
			<form id="user_login_loginForm" method="post">
		<table>
			<tr>
				<th>&nbsp;</th>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>登录名：</th>
				<td><input name="username" class="easyui-validateBox" data-options="required:true,missingMessage:'请输入登陆名！'"/>
				</td>
			</tr>
			<tr>
				<th>密&nbsp;&nbsp;码：</th>
				<td><input type="password" name="password" class="easyui-validateBox" data-options="required:true,missingMessage:'请输入密码！'"/>
				</td>
			</tr>
			<tr>
				<th>验证码：</th>
				<td><input />
				</td>
			</tr>
		</table>
		</form>
	</div>