<%@ page language="java" pageEncoding="UTF-8"%>
<div id="index_regdialog" class="easyui-dialog" style="width:250px;"
		data-options="title:'注册',modal:true,closed:true,buttons:[{
				text:'注册',
				iconCls:'icon-edit',
				handler:function(){
				$('#index_regform').form('submit',{
				  url:'${pageContext.request.contextPath}/userAction!reg.action',
			      success:function(r) {
			          var obj=$.parseJSON(r);
		              if (obj.success) {
		    	          $('#index_regdialog').dialog('close');
		              }   
			      $.messager.show({title:'提示',msg:obj.msg});
			     }
				})
               } 
			}]">
		<form id="index_regform" method="post">
			<table>
				<tr>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>登&nbsp;录&nbsp;名：</th>
					<td><input name="username" class="easyui-validatebox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<th>密&nbsp;&nbsp;&nbsp;&nbsp;码：</th>
					<td><input id="password" name="password" type="password" class="easyui-validatebox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<th>重复密码：</th>
					<td><input id="password2" name="password2" type="password" class="easyui-validatebox" data-options="required:true,validType:'eqPassword[\'#password\']'"/>
					</td>
				</tr>
			</table>
		</form>
	</div>