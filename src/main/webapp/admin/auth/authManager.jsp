<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
  	$(function(){
  		auth_treegrid=$('#dg_authManager').treegrid({
			url : 'authAction!do_treegrid.action',
			title:'权限列表',
			iconCls: 'icon-group',
			fitColumns : true,
			idField : 'cid',
			animate : false,
			parentField : 'pid',
			fit : true,
			border : true,
			treeField: 'cname',
			frozenColumns : [ [ {
				title:'编号',
				field:'cid',
				width:80,
				align:'center',
				hidden:true
			},{
				title:'权限名称',
				field:'cname',
				align:'center',
				width:200
			}]],
			columns:[[{
				title:'权限链接',
				field:'curl',
				align:'center',
				width:180
			},{
				title:'排序',
				field:'cseq',
				align:'center',
				width:40
			},{
				title:'上级权限ID',
				field:'pid',
				width:40,
				hidden:true
			},{
				title:'上级权限名称',
				field:'pname',
				align:'center',
				width:200
			},{
				field : 'action',
				title : '操作',
				width : 50,
				align:'center',
				formatter:function(value, row, index) {
					return sy.fs('<img onclick="authEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="authDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>', row.cid, 'js/themes/icons/pencil.png', row.cid, 'js/themes/icons/delete.png');
				}
			}]],
			toolbar:[{
				text:'新增',
				iconCls:'icon-append',
				handler:function(){
					authAppend();
				}
			},{
				text:'展开',
				iconCls:'icon-add',
				handler:function(){
					var node = auth_treegrid.treegrid('getSelected');
					if (node) {
						auth_treegrid.treegrid('expandAll', node.cid);
					} else {
						auth_treegrid.treegrid('expandAll');
					};
				}
			},{
				text:'折叠',
				iconCls:'icon-remove',
				handler : function() {
					var node = auth_treegrid.treegrid('getSelected');
					if (node) {
						auth_treegrid.treegrid('collapseAll', node.cid);
					} else {
						auth_treegrid.treegrid('collapseAll');
					};
				}	
				}],
				onExpand : function(row) {
					auth_treegrid.treegrid('unselectAll');
				},
				onCollapse : function(row) {
					auth_treegrid.treegrid('unselectAll');
				}
		});
	});
  	function authAppend() {
		var p = parent.sy.dialog({
			iconCls: 'icon-group',
			title : '添加权限',
			href : '${pageContext.request.contextPath}/authAction!authAdd.action',
			width : 340,
			height : 260,
			buttons : [ {
				text : '添加',
				iconCls: 'icon-ok',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/authAction!add.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								auth_treegrid.treegrid('reload');
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
				var pid = f.find('input[name=pid]');
				var ptree = pid.combotree({
					lines : true,
					url : '${pageContext.request.contextPath}/authAction!do_treegrid.action'
				});
			}
		});
	};
	
	function authEdit(cid) {
		if (cid != undefined) {
			$('#dg_authManager').treegrid('select', cid);
		}
		var node = $('#dg_authManager').treegrid('getSelected');
			var p = parent.sy.dialog({
				title : '编辑权限',
				iconCls : 'icon-edit',
				href : '${pageContext.request.contextPath}/authAction!authEdit.action',
				width : 340,
				height : 260,
				buttons : [ {
					text : '保存',
					iconCls: 'icon-save',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/authAction!edit.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									auth_treegrid.treegrid('reload');
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
					var pid = f.find('input[name=pid]');
					var ptree = pid.combotree({
						lines : true,
						url : '${pageContext.request.contextPath}/authAction!do_treegrid.action',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', node);
				}
			});
	};
	function authDelete(cid) {
		if (cid != undefined) {
			$('#dg_authManager').treegrid('select', cid);
		};
		var node = $('#dg_authManager').treegrid('getSelected');
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.cname + '】权限？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/authAction!delete.action',
						data : {
							cid : node.cid
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
								auth_treegrid.treegrid('remove', r.obj);
							}
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
						}
					});
				}
			});
	};
</script>
<table id="dg_authManager"></table>