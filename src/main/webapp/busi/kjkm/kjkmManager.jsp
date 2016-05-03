<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		kjkm_treegrid=$('#dg_kjkmManager').treegrid({
			url : 'kjkmAction!do_treegrid.action',
			title:'会计科目列表',
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
				title:'会计科目名称',
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
				title:'上级会计科目ID',
				field:'pid',
				width:40,
				hidden:true
			},{
				title:'上级会计科目名称',
				field:'pname',
				align:'center',
				width:200
			},{
				field : 'action',
				title : '操作',
				width : 50,
				align:'center',
				formatter:function(value, row, index) {
					return sy.fs('<img onclick="kjkmEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="kjkmDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>', row.cid, 'js/themes/icons/pencil.png', row.cid, 'js/themes/icons/delete.png');
				}
			}]],
			toolbar:[{
				text:'新增',
				iconCls:'icon-append',
				handler:function(){
					kjkmAppend();
				}
			},{
				text:'展开',
				iconCls:'icon-add',
				handler:function(){
					var node = kjkm_treegrid.treegrid('getSelected');
					if (node) {
						kjkm_treegrid.treegrid('expandAll', node.cid);
					} else {
						kjkm_treegrid.treegrid('expandAll');
					};
				}
			},{
				text:'折叠',
				iconCls:'icon-remove',
				handler : function() {
					var node = kjkm_treegrid.treegrid('getSelected');
					if (node) {
						kjkm_treegrid.treegrid('collapseAll', node.cid);
					} else {
						kjkm_treegrid.treegrid('collapseAll');
					};
				}	
				}],
				onExpand : function(row) {
					kjkm_treegrid.treegrid('unselectAll');
				},
				onCollapse : function(row) {
					kjkm_treegrid.treegrid('unselectAll');
				}
		});
	});
	
	function kjkmAppend() {
		var p = parent.sy.dialog({
			iconCls: 'icon-menu',
			title : '添加会计科目',
			href : '${pageContext.request.contextPath}/kjkmAction!kjkmAdd.action',
			width : 350,
			height : 300,
			buttons : [ {
				text : '添加',
				iconCls: 'icon-ok',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/kjkmAction!add.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								kjkm_treegrid.treegrid('reload');
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
					url : '${pageContext.request.contextPath}/kjkmAction!do_treegrid.action'
				});
			}
		});
	};
	function kjkmEdit(cid) {
		if (cid != undefined) {
			$('#dg_kjkmManager').treegrid('select', cid);
		}
		var node = $('#dg_kjkmManager').treegrid('getSelected');
			var p = parent.sy.dialog({
				title : '编辑菜单',
				iconCls : 'icon-edit',
				href : '${pageContext.request.contextPath}/kjkmAction!kjkmEdit.action',
				width : 350,
				height : 300,
				buttons : [ {
					text : '保存',
					iconCls: 'icon-save',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/kjkmAction!edit.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									kjkm_treegrid.treegrid('reload');
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
						url : '${pageContext.request.contextPath}/kjkmAction!do_treegrid.action',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', node);
				}
			});
	};
	function kjkmDelete(cid) {
		if (cid != undefined) {
			$('#dg_kjkmManager').treegrid('select', cid);
		};
		var node = $('#dg_kjkmManager').treegrid('getSelected');
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.cname + '】？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/kjkmAction!delete.action',
						data : {
							cid : node.cid
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
								kjkm_treegrid.treegrid('remove', r.obj);
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
<table id="dg_kjkmManager"></table>