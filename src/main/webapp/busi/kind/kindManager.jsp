<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		kind_treegrid=$('#dg_kindManager').treegrid({
			url : 'kindAction!do_treegrid.action',
			title:'归类列表',
			iconCls: 'icon-menu',
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
				title:'归类名称',
				field:'cname',
				align:'center',
				width:200
			}]],
			columns:[[{
				title:'排序',
				field:'cseq',
				align:'center',
				width:40,
			},{
				title:'上级归类ID',
				field:'pid',
				width:40,
				hidden:true
			},{
				title:'上级归类名称',
				field:'pname',
				align:'center',
				width:200
			},{
				field : 'action',
				title : '操作',
				width : 50,
				align:'center',
				formatter:function(value, row, index) {
					return sy.fs('<img onclick="kindEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="kindDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>', row.cid, 'js/themes/icons/pencil.png', row.cid, 'js/themes/icons/delete.png');
				}
			}]],
			toolbar:[{
				text:'新增',
				iconCls:'icon-append',
				handler:function(){
					kindAppend();
				}
			},{
				text:'展开',
				iconCls:'icon-add',
				handler:function(){
					var node = kind_treegrid.treegrid('getSelected');
					if (node) {
						kind_treegrid.treegrid('expandAll', node.cid);
					} else {
						kind_treegrid.treegrid('expandAll');
					};
				}
			},{
				text:'折叠',
				iconCls:'icon-remove',
				handler : function() {
					var node = kind_treegrid.treegrid('getSelected');
					if (node) {
						kind_treegrid.treegrid('collapseAll', node.cid);
					} else {
						kind_treegrid.treegrid('collapseAll');
					};
				}	
				}],
				onExpand : function(row) {
					kind_treegrid.treegrid('unselectAll');
				},
				onCollapse : function(row) {
					kind_treegrid.treegrid('unselectAll');
				}
		});
	});
	
	function kindAppend() {
		var p = parent.sy.dialog({
			iconCls: 'icon-menu',
			title : '添加归类',
			href : '${pageContext.request.contextPath}/kindAction!kindAdd.action',
			width : 320,
			height : 200,
			buttons : [ {
				text : '添加',
				iconCls: 'icon-ok',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/kindAction!add.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								kind_treegrid.treegrid('reload');
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
					url : '${pageContext.request.contextPath}/kindAction!do_treegrid.action'
				});
			}
		});
	};
	function kindEdit(cid) {
		if (cid != undefined) {
			$('#dg_kindManager').treegrid('select', cid);
		}
		var node = $('#dg_kindManager').treegrid('getSelected');
			var p = parent.sy.dialog({
				title : '编辑菜单',
				iconCls : 'icon-edit',
				href : '${pageContext.request.contextPath}/kindAction!kindEdit.action',
				width : 320,
				height : 200,
				buttons : [ {
					text : '保存',
					iconCls: 'icon-save',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/kindAction!edit.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									kind_treegrid.treegrid('reload');
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
						url : '${pageContext.request.contextPath}/kindAction!do_treegrid.action',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', node);
				}
			});
	};
	function kindDelete(cid) {
		if (cid != undefined) {
			$('#dg_kindManager').treegrid('select', cid);
		};
		var node = $('#dg_kindManager').treegrid('getSelected');
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.cname + '】？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/kindAction!delete.action',
						data : {
							cid : node.cid
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
								kind_treegrid.treegrid('remove', r.obj);
							}
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
						}
					});
				}
			});
	}
</script>
<table id="dg_kindManager"></table>