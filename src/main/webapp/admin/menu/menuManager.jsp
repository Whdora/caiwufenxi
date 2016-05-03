<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var menuList;
	$(function(){
		iconData = [ {
			value : '',
			text : '默认'
		}, {
			value : 'icon-add',
			text : 'icon-add'
		}, {
			value : 'icon-edit',
			text : 'icon-edit'
		}, {
			value : 'icon-append',
			text : 'icon-append'
		},{
			value : 'icon-clear',
			text : 'icon-clear'
		},{
			value : 'icon-delete',
			text : 'icon-delete'
		},{
			value : 'icon-remove',
			text : 'icon-remove'
		}, {
			value : 'icon-save',
			text : 'icon-save'
		}, {
			value : 'icon-cut',
			text : 'icon-cut'
		}, {
			value : 'icon-ok',
			text : 'icon-ok'
		}, {
			value : 'icon-no',
			text : 'icon-no'
		}, {
			value : 'icon-cancel',
			text : 'icon-cancel'
		}, {
			value : 'icon-reload',
			text : 'icon-reload'
		}, {
			value : 'icon-search',
			text : 'icon-search'
		}, {
			value : 'icon-print',
			text : 'icon-print'
		}, {
			value : 'icon-help',
			text : 'icon-help'
		}, {
			value : 'icon-undo',
			text : 'icon-undo'
		}, {
			value : 'icon-redo',
			text : 'icon-redo'
		}, {
			value : 'icon-back',
			text : 'icon-back'
		}, {
			value : 'icon-sum',
			text : 'icon-sum'
		}, {
			value : 'icon-tip',
			text : 'icon-tip'
		} ];
		treegrid=$('#dg_menuManager').treegrid({
			url : 'menuAction!do_treegrid.action',
			title:'菜单列表',
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
				title:'菜单名称',
				field:'cname',
				align:'center',
				width:200
			}]],
			columns:[[{
				title:'菜单图标',
				field:'ciconcls',
				align:'center',
				width:40,
				formatter:function(value) {
					if (!value) {
						return '';
					} else {
						return sy.fs('<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span>', value);
					}
				}
			},{
				title:'菜单链接',
				field:'curl',
				align:'center',
				width:180
			},{
				title:'菜单顺序',
				field:'cseq',
				align:'center',
				width:40
			},{
				title:'上级菜单ID',
				field:'pid',
				width:40,
				hidden:true
			},{
				title:'上级菜单',
				field:'pname',
				align:'center',
				width:200
			},{
				field : 'action',
				title : '操作',
				width : 50,
				align:'center',
				formatter:function(value, row, index) {
					return sy.fs('<img onclick="menuEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="menuDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>', row.cid, 'js/themes/icons/pencil.png', row.cid, 'js/themes/icons/delete.png');
				}
			}]],
			toolbar:[{
				text:'新增',
				iconCls:'icon-append',
				handler:function(){
					menuAppend();
				}
			},{
				text:'展开',
				iconCls:'icon-add',
				handler:function(){
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('expandAll', node.cid);
					} else {
						treegrid.treegrid('expandAll');
					};
				}
			},{
				text:'折叠',
				iconCls:'icon-remove',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('collapseAll', node.cid);
					} else {
						treegrid.treegrid('collapseAll');
					};
				}	
				}],
				onExpand : function(row) {
					treegrid.treegrid('unselectAll');
				},
				onCollapse : function(row) {
					treegrid.treegrid('unselectAll');
				}
		});
	});
	function menuAppend() {
		var p = parent.sy.dialog({
			iconCls: 'icon-menu',
			title : '添加菜单',
			href : '${pageContext.request.contextPath}/menuAction!menuAdd.action',
			width : 520,
			height : 200,
			buttons : [ {
				text : '添加',
				iconCls: 'icon-ok',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/menuAction!add.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								treegrid.treegrid('reload');
								p.dialog('close');
								parent.ctrlTree.tree('reload');/*刷新左侧菜单树*/
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
				var iconCls = f.find('input[name=iconCls]');
				var iconCombo = iconCls.combobox({
					data : iconData,
					formatter : function(v) {
						return sy.fs('<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span>{1}', v.value, v.value);
					}
				});
				var ptree = pid.combotree({
					lines : true,
					url : '${pageContext.request.contextPath}/menuAction!do_treeRecursive.action'
				});
			}
		});
	};
	function menuEdit(cid) {
		if (cid != undefined) {
			$('#dg_menuManager').treegrid('select', cid);
		}
		var node = $('#dg_menuManager').treegrid('getSelected');
			var p = parent.sy.dialog({
				title : '编辑菜单',
				iconCls : 'icon-edit',
				href : '${pageContext.request.contextPath}/menuAction!menuEdit.action',
				width : 520,
				height : 200,
				buttons : [ {
					text : '保存',
					iconCls: 'icon-save',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/menuAction!edit.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									treegrid.treegrid('reload');
									p.dialog('close');
									parent.ctrlTree.tree('reload');/*刷新左侧菜单树*/
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
					var iconCls = f.find('input[name=iconCls]');
					var iconCombo = iconCls.combobox({
						data : iconData,
						formatter : function(v) {
							return sy.fs('<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span>{1}', v.value, v.value);
						}
					});
					var ptree = pid.combotree({
						lines : true,
						url : '${pageContext.request.contextPath}/menuAction!do_treeRecursive.action',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', node);
				}
			});
	};
	function menuDelete(cid) {
		if (cid != undefined) {
			$('#dg_menuManager').treegrid('select', cid);
		};
		var node = $('#dg_menuManager').treegrid('getSelected');
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.cname + '】？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/menuAction!delete.action',
						data : {
							cid : node.cid
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
								treegrid.treegrid('remove', r.obj);
								parent.ctrlTree.tree('reload');/*刷新左侧菜单树*/
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
<table id="dg_menuManager"></table>