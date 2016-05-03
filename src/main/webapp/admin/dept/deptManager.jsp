<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function(){
	  dept_treegrid=$('#dg_deptManager').treegrid({
			url : 'deptAction!do_showDept.action',
			title:'单位列表',
			iconCls:'icon-org',
			fitColumns : true,
			idField : 'cid',
			animate : false,
			parentField : 'pid',
			fit : true,
			border : true,
			treeField: 'cdeptName',
			frozenColumns : [ [ {
				title:'编号',
				field:'cid',
				width:80,
				align:'center',
				hidden:true
			},{
				title:'单位名称',
				field:'cdeptName',
				align:'center',
				width:200
			}]],
			columns:[[{
				title:'排序',
				field:'cseq',
				align:'center',
				width:100,
			},
			{
				title:'上级单位',
				field:'pdeptName',
				align:'center',
				width:200,
			},{
				title:'创建时间',
				field:'ccreateDatetime',
				align:'center',
				width:100,
			},{
				title:'修改时间',
				field:'cmodifyDatetime',
				align:'center',
				width:100,
			},{
				title:'上级单位ID',
				field:'pid',
				width:40,
				hidden:true
			},{
				field : 'action',
				title : '操作',
				width : 50,
				align:'center',
				formatter:function(value, row, index) {
					return sy.fs('<img onclick="deptEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="deptDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>', row.cid, 'js/themes/icons/pencil.png', row.cid, 'js/themes/icons/delete.png');
				}
			}]],
			toolbar:[{
				text:'新增',
				iconCls:'icon-append',
				handler:function(){
					deptAppend();
				}
			},{
				text:'展开',
				iconCls:'icon-add',
				handler:function(){
					var node = dept_treegrid.treegrid('getSelected');
					if (node) {
						dept_treegrid.treegrid('expandAll', node.cid);
					} else {
						dept_treegrid.treegrid('expandAll');
					};
				}
			},{
				text:'折叠',
				iconCls:'icon-remove',
				handler : function() {
					var node = dept_treegrid.treegrid('getSelected');
					if (node) {
						dept_treegrid.treegrid('collapseAll', node.cid);
					} else {
						dept_treegrid.treegrid('collapseAll');
					};
				}	
				}],
				onExpand : function(row) {
					dept_treegrid.treegrid('unselectAll');
				},
				onCollapse : function(row) {
					dept_treegrid.treegrid('unselectAll');
				}
		});
  });
  function deptAppend() {
		var p = parent.sy.dialog({
			iconCls: 'icon-org',
			title : '添加单位',
			href : '${pageContext.request.contextPath}/deptAction!deptAdd.action',
			width : 300,
			height : 240,
			buttons : [ {
				text : '添加',
				iconCls: 'icon-ok',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/deptAction!add.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								dept_treegrid.treegrid('reload');
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
					url : '${pageContext.request.contextPath}/deptAction!do_showDept.action'
				});
			}
		});
	};
	function deptEdit(cid) {
		if (cid != undefined) {
			$('#dg_deptManager').treegrid('select', cid);
		}
		var node = $('#dg_deptManager').treegrid('getSelected');
			var p = parent.sy.dialog({
				title : '编辑单位',
				iconCls : 'icon-edit',
				href : '${pageContext.request.contextPath}/deptAction!deptEdit.action',
				width : 300,
				height : 240,
				buttons : [ {
					text : '保存',
					iconCls: 'icon-save',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/deptAction!edit.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									dept_treegrid.treegrid('reload');
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
						url : '${pageContext.request.contextPath}/deptAction!do_showDept.action',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', node);
				}
			});
	};
	
	function deptDelete(cid) {
		if (cid != undefined) {
			$('#dg_deptManager').treegrid('select', cid);
		};
		var node = $('#dg_deptManager').treegrid('getSelected');
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.cdeptName + '】？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/deptAction!delete.action',
						data : {
							cid : node.cid
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
								dept_treegrid.treegrid('remove', r.obj);
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

<table id="dg_deptManager"></table>