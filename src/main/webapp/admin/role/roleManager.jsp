<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var role_datagrid;
	$(function() {
		role_datagrid = $('#role_manager_datagrid').datagrid({
							url : '${pageContext.request.contextPath}/roleAction!do_datagrid.action',
							title : '',
							iconCls : 'icon-user',
							pagination : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							fit : true,
							fitColumns : true,
							nowrap : false,
							border : true,
							idField : 'cid',
							sortName : 'cname',
							sortOrder : 'desc',
							checkOnSelect : false,
							selectOnCheck : true,
							frozenColumns : [ [ {
								title : '编号',
								field : 'cid',
								width : 150,
								align : "center",
								checkbox : true
							}, {
								title : '角色名称',
								field : 'cname',
								align : "center",
								width : 150,
								sortable : true
							} ] ],
							columns : [ [
									{
										title : '备注',
										field : 'cdesc',
										align : "center",
										width : 80
									},
									{
										title : '拥有操作权限ID',
										field : 'authIds',
										align : "center",
										width : 200,
										hidden : true
									},
									{
										title : '操作权限',
										field : 'authNames',
										align : "center",
										width : 200
									},
									{
										title : '拥有菜单权限ID',
										field : 'menuIds',
										align : "center",
										width : 200,
										hidden : true
									},
									{
										title : '菜单权限',
										field : 'menuNames',
										align : "center",
										width : 200
									},
									{
										field : 'action',
										title : '操作',
										align : "center",
										width : 50,
										align : 'center',
										formatter : function(value, row, index) {
											return sy.fs(
															'<img onclick="roleEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="roleDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
															row.cid,
															'js/themes/icons/pencil.png',
															row.cid,
															'js/themes/icons/delete.png');
										}
									} ] ],
							toolbar : [ {
								text : '增加',
								iconCls : 'icon-append',
								handler : function() {
									roleAppend();
								}
							}, '-', {
								text : '批量删除',
								iconCls : 'icon-remove',
								handler : function() {
									roleRemove();
								}
							}, '-' ],
							onRowContextMenu : function(e, rowIndex, rowData) {
								e.preventDefault();
								$(this).datagrid('unselectAll');
								$(this).datagrid('selectRow', rowIndex);
								$('#role_menu').menu('show', {
									left : e.pageX,
									top : e.pageY
								});
							}
						});

	});

	function roleEdit(cid) {
		if (cid != undefined) {
			$('#role_manager_datagrid').datagrid('unselectAll');
			$('#role_manager_datagrid').datagrid('selectRecord', cid);
		}
		var rows = $('#role_manager_datagrid').datagrid('getSelected');
		var p = parent.sy.dialog({
						title : '角色编辑',
						iconCls : 'icon-edit',
						href : '${pageContext.request.contextPath}/roleAction!roleEdit.action',
						width : 420,
						height : 260,
						buttons : [ {
							text : '保存',
							iconCls : 'icon-save',
							handler : function() {
								var f = p.find('form');
								f.form(	'submit',{
										url : '${pageContext.request.contextPath}/roleAction!edit.action',
										success : function(d) {
											var json = $
													.parseJSON(d);
											if (json.success) {
												role_datagrid.datagrid('reload');
												p.dialog('close');
											}
											parent.sy.messagerShow({
													msg : json.msg,
													title : '提示'
												});
									    }
									});
							}
						} ],
						onLoad : function() {
							var f = p.find('form');
							var authIds = f.find('input[name=authIds]');
							var menuIds = f.find('input[name=menuIds]');
							var authIdsTree = authIds.combotree({
										lines : true,
										url : '${pageContext.request.contextPath}/authAction!do_treegrid.action',
										checkbox : true,
										multiple : true,
										onCheck : function(){
											var tr=authIds.combotree('tree');
											var rs=tr.tree('getCheckedExt');
											var values=[];
											var texts=[];
											for(var i=0;i<rs.length;i++){
												values.push(rs[i].id);
												texts.push(rs[i].text);
											}
											authIds.combo('setValues',values).combo('setText',texts.join(','));
										}
									});
							var menuIdsTree = menuIds.combotree({
										lines : true,
										url : '${pageContext.request.contextPath}/menuAction!do_treeRecursive.action',
										checkbox : true,
										multiple : true,
										onLoadSuccess : function() {
											parent.$.messager.progress('close');
										},
										onCheck : function(){
											var tr=menuIds.combotree('tree');
											var rs=tr.tree('getCheckedExt');
											var values=[];
											var texts=[];
											for(var i=0;i<rs.length;i++){
												values.push(rs[i].id);
												texts.push(rs[i].text);
											}
											menuIds.combo('setValues',values).combo('setText',texts.join(','));
										}
							});
							f.form('load', {
								cid : rows.cid,
								cname : rows.cname,
								cdesc : rows.cdesc,
								authIds : sy.getList(rows.authIds),
								menuIds : sy.getList(rows.menuIds)
							});
						}
					});
	};
	function roleAppend() {
		var p = parent.sy.dialog({
					title : '添加角色',
					href : '${pageContext.request.contextPath}/roleAction!roleAdd.action',
					width : 420,
					height : 300,
					buttons : [ {
						text : '添加',
						iconCls : 'icon-ok',
						handler : function() {
							var f = p.find('form');
							f.form('submit',{
								url : '${pageContext.request.contextPath}/roleAction!add.action',
								success : function(d) {
									var json = $.parseJSON(d);
									if (json.success) {
										role_datagrid.datagrid('reload');
										p.dialog('close');
									}
									parent.sy.messagerShow({
										msg : json.msg,
										title : '提示'
									});
								}
							});
						}
					} ],
					onLoad : function() {
						var f = p.find('form');
						var authIds = f.find('input[name=authIds]');
						var menuIds = f.find('input[name=menuIds]');
						var authIdsTree = authIds.combotree({
									lines : true,
									url : '${pageContext.request.contextPath}/authAction!do_treegrid.action',
									checkbox : true,
									multiple : true,
									onCheck : function(){
										var tr=authIds.combotree('tree');
										var rs=tr.tree('getCheckedExt');
										var values=[];
										var texts=[];
										for(var i=0;i<rs.length;i++){
											values.push(rs[i].id);
											texts.push(rs[i].text);
										}
										authIds.combo('setValues',values).combo('setText',texts.join(','));
									}
								});
						var menuIdsTree = menuIds.combotree({
							lines : true,
							url : '${pageContext.request.contextPath}/menuAction!do_treeRecursive.action',
							checkbox : true,
							multiple : true,
							onCheck : function(){
								var tr=menuIds.combotree('tree');
								var rs=tr.tree('getCheckedExt');
								var values=[];
								var texts=[];
								for(var i=0;i<rs.length;i++){
									values.push(rs[i].id);
									texts.push(rs[i].text);
								}
								menuIds.combo('setValues',values).combo('setText',texts.join(','));
							}
						});
					}
				});
	}
	function roleRemove() {
		var rows = role_datagrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.sy.messagerConfirm('请确认','是否删除当前所选角色？',function(r) {
								if (r) {
									for ( var i = 0; i < rows.length; i++) {
										ids.push(rows[i].cid);
									}
									$.ajax({
												url : '${pageContext.request.contextPath}/roleAction!delete.action',
												data : {
													ids : ids.join(',')
												},
												dataType : 'json',
												success : function(d) {
													role_datagrid.datagrid('load');
													role_datagrid.datagrid('unselectAll');
													parent.sy.messagerShow({
														title : '提示',
														msg : d.msg
													});
												}
											});
								}
							});
		} else {
			parent.sy.messagerAlert('提示', '请选择要删除的记录！', 'error');
		}
	};
	
	function roleDelete(cid){
		$('#role_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		$('#role_manager_datagrid').datagrid('checkRow', $('#role_manager_datagrid').datagrid('getRowIndex', cid));
		roleRemove();
	}
</script>
<table id="role_manager_datagrid"></table>
<div id="role-menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="roleAppend();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="roleDelete();" data-options="iconCls:'icon-delete'">删除</div>
	<div onclick="roleEdit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>