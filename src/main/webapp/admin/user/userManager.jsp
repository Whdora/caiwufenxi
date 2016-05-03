<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var userList;
	$(function() {
		userList = $('#user_manager_datagrid').datagrid({
			url : 'userAction!do_dataGrid.action',
			fitColumns : true,
			pagination : true,
			idField : 'cid',
			fit : true,
			border : false,
			pageSize : 10,
			sortName : 'ccreatedatetime',
			sortOrder : 'desc',
			checkOnSelect : false,
			selectOnCheck : true,
			pageList : [ 10, 20, 30, 40, 50 ],
			columns : [ [ {
				field : 'cid',
				title : '编号',
				width : 80,
				align : "center",
				checkbox : true
			}, {
				field : 'cusername',
				title : '用户名称',
				width : 80,
				align : "center",
				sortable : true
			}, {
				field : 'cpassword',
				title : '用户密码',
				width : 80,
				align : "center",
				formatter : function(value, row, index) {
					return '******';
				}
			}, {
				field : 'ccreatedatetime',
				title : '创建时间',
				width : 120,
				align : "center",
				sortable : true
			}, {
				field : 'cmodifydatetime',
				title : '修改时间',
				width : 120,
				align : "center",
				sortable : true
			}, {
				field : 'cdeptname',
				title : '所属部门',
				align : "center",
				width : 150
			},{
				field : 'cdepartment',
				title : '所属部门ID',
				align : "center",
				width : 100,
				hidden: true
			}, {
				field : 'roleNames',
				title : '用户角色',
				align : "center",
				width : 100
			},{
				field : 'roleIds',
				title : '角色ID',
				align : "center",
				width : 100 ,
				hidden: true
			}] ],
			toolbar : [ {
				iconCls : 'icon-append',
				text : '增加',
				handler : function() {
					userAppend();
				}
			},'-', {
				iconCls : 'icon-edit',
				text : '修改',
				handler : function() {
					userEdit();
				}
			},'-', {
				iconCls : 'icon-delete',
				text : '删除',
				handler : function() {
					userDelete();
				}
			} ]
		});
	});
	function userEdit() {
		var rows = userList.datagrid('getChecked');
		if (rows.length == 1) {
			var p = parent.sy
					.dialog({
						title : '修改用户信息',
						iconCls : 'icon-user',
						href : '${pageContext.request.contextPath}/userAction!userEdit.action',
						width : 300,
						height : 320,
						buttons : [ {
							text : '保存',
							iconCls : 'icon-save',
							handler : function() {
								var f = p.find('form');
								f.form('submit',{
													url : '${pageContext.request.contextPath}/userAction!edit.action',
													success : function(d) {
														var json = $
																.parseJSON(d);
														if (json.success) {
															userList.datagrid('reload');
															p.dialog('close');
														}
														parent.sy
																.messagerShow({
																	msg : json.msg,
																	title : '提示'
																});
													}
												});
							}
						} ],
						onLoad : function() {
							var f = p.find('form');
							f.form('load', {
								cid : rows[0].cid,
								cusername : rows[0].cusername,
								cdepartment : rows[0].cdepartment,
								ccreatedatetime : rows[0].ccreatedatetime,
								cmodifydatetime : rows[0].cmodifydatetime,
								roleIds:rows[0].roleIds
							});
						}

					});
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'info');
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'info');
		}
	};
	function userAppend() {
		var p = parent.sy
				.dialog({
					title : '增加用户',
					iconCls : 'icon-user',
					href : '${pageContext.request.contextPath}/userAction!userAdd.action',
					width : 300,
					height : 280,
					buttons : [ {
						text : '增加',
						iconCls : 'icon-add',
						handler : function() {
							var f = p.find('form');
							f
									.form(
											'submit',
											{
												url : '${pageContext.request.contextPath}/userAction!add.action',
												success : function(d) {
													var json = $.parseJSON(d);
													if (json.success) {
														userList
																.datagrid('reload');
														p.dialog('close');
													}
													parent.sy.messagerShow({
														msg : json.msg,
														title : '提示'
													});
												}
											});
						}
					} ]
				});
	};
	function userDelete() {
		var rows = userList.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.sy
					.messagerConfirm(
							'请确认',
							'您确认要删除当前所选的'+rows.length+'条记录？',
							function(r) {
								if (r) {
									for ( var i = 0; i < rows.length; i++) {
										ids.push(rows[i].cid);
									}
									$
											.ajax({
												url : '${pageContext.request.contextPath}/userAction!delete.action',
												data : {
													ids : ids.join(',')
												},
												dataType : 'json',
												success : function(d) {
													userList.datagrid('load');
													userList
															.datagrid('unselectAll');
													parent.sy.messagerShow({
														title : '提示',
														msg : d.msg
													});
												}
											});
								}
							});
		} else {
			parent.sy.messagerAlert('提示', '请选择要删除的用户！', 'error');
		}
	};
	function _search() {
		userList.datagrid('load', sy.serializeObject($('#bt_user_search_from')));
	};
	function cleanSearch() {
		userList.datagrid('load', {});
		$('#bt_user_search_from input').val('');
	};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询用户',iconCls:'icon-search'" style="height: 100px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="bt_user_search_from">
			<table style="height: 100%;" class="input_table">
				<tr>
					<td align="right">用户名称：</td>
					<td><input type="text" name="cusername">
					</td>
					<td></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton" id="bt_user_search_btn" onclick="_search();">查询</a>&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" onClick="cleanSearch();">清空</a>
					</td>
				</tr>
				<tr>
					<td align="right">创建时间：</td>
					<td><input class="easyui-my97" type="text" name="ccreatedatetimeStart" maxDate="#F{ $dp.$D('bt_user_input_createTime_ed')||'2020-10-01'}" id="bt_user_input_createTime_st">
					</td>
					<td align="center">-</td>
					<td><input class="easyui-my97" type="text" name="ccreatedatetimeEnd" minDate="#F{ $dp.$D('bt_user_input_createTime_st')}" id="bt_user_input_createTime_ed">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'用户列表',border:true,iconCls:'icon-role'" style="overflow: hidden;">
		<table id="user_manager_datagrid"></table>
	</div>
</div>
