<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var announce_datagrid;
$(function ()
{
    announce_datagrid = $('#announce_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/announceAction!do_datagrid.action',
            pagination : true,
            pageSize : 10,
            pageList : [10, 20, 30, 40],
            border : false,
            fit: true,
            fitColumns : true,
            idField : 'cid',
            sortName : 'ccreatedate',
            sortOrder : 'desc',
            checkOnSelect : false,
            selectOnCheck : true,
            columns : [[
                    {
                        title : '编号',
                        field : 'cid',
                        width : 150,
                        align : "center",
                        checkbox : true
                    },
                    {
                        title : '发布时间',
                        field : 'ccreatedate',
                        align : "center",
                        width : 150
                    },
                    {
                        title : '通知标题',
                        field : 'ctitle',
                        align : "center",
                        width : 180
                    },
                    {
                        title : '发布人',
                        field : 'userName',
                        align : "center",
                        width : 150
                    },
                    {
                        title : '通知内容',
                        field : 'ccontent',
                        align : "center",
                        width : 180,
                        formatter : function(value, rowData, rowIndex) {
        					return '<span class="icon-search" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span><a href="javascript:void(0);" onclick="showAnnounce(' + rowIndex + ');">查看通知内容</a>';
        				}
                    },
                    {
                        field : 'action',
                        title : '操作',
                        width : 120,
                        align : 'center',
                        formatter : function (value, row, index)
                        {
                            return sy.fs(
                                '<img onclick="announceEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="announceDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
                                row.cid,
                                'js/themes/icons/pencil.png',
                                row.cid,
                                'js/themes/icons/delete.png');
                        }
                    }
                ]],
            toolbar : [
                {
                    text : '增加',
                    iconCls : 'icon-append',
                    handler : function ()
                    {
                        announceAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        announceRemove();
                    }
                }, '-'],
            onRowContextMenu : function (e, rowIndex, rowData)
            {
                e.preventDefault();
                $(this).datagrid('unselectAll');
                $(this).datagrid('selectRow', rowIndex);
                $('#announce_menu').menu('show',
                {
                    left : e.pageX,
                    top : e.pageY
                }
                );
            }
        }
        );
    
}
);

function announceEdit(cid)
{
    if (cid != undefined)
    {
        $('#announce_manager_datagrid').datagrid('unselectAll');
        $('#announce_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#announce_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '通知编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/announceAction!announceEdit.action',
            width : 830,
            height : 500,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/announceAction!edit.action',
                            onSubmit: function(){   
                            	announce_edit_editor.sync();	
                            }, 
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    announce_datagrid.datagrid('reload');
                                    p.dialog('close');
                                }
                                parent.sy.messagerShow(
                                {
                                    msg : json.msg,
                                    title : '提示'
                                }
                                );
                            }
                        }
                        );
                    }
                }
            ],
            onLoad : function ()
            {
                var f = p.find('form');
                f.form('load',rows);
                announce_edit_editor.html(rows.ccontent);
            }
        }
        );
};
function announceAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加通知',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/announceAction!announceAdd.action',
            width : 830,
            height : 500,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/announceAction!add.action',
                            onSubmit: function(){   
                            	announce_editor.sync();	
                            }, 

                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    announce_datagrid.datagrid('reload');
                                    p.dialog('close');
                                }
                                parent.sy.messagerShow(
                                {
                                    msg : json.msg,
                                    title : '提示'
                                }
                                );
                            }
                        }
                        );
                    }
                }
            ]
        }
        );
}
function announceRemove()
{
    var rows = announce_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选通知？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/announceAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        announce_datagrid.datagrid('load');
                        announce_datagrid.datagrid('unselectAll');
                        parent.sy.messagerShow(
                        {
                            title : '提示',
                            msg : d.msg
                        }
                        );
                    }
                }
                );
            }
        }
        );
    }
    else
    {
        parent.sy.messagerAlert('提示', '请选择要删除的记录！', 'error');
    }
};

function announceDelete(cid)
{
    $('#announce_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#announce_manager_datagrid').datagrid('checkRow', $('#announce_manager_datagrid').datagrid('getRowIndex', cid));
    announceRemove();
};

function showAnnounce(rowIndex) {
	var rows = announce_datagrid.datagrid('getRows');
	var row = rows[rowIndex];

	var p = parent.sy.dialog({
		title : '[' + row.ctitle + ']',
		modal : true,
		maximizable : true,
		width : 600,
		height : 600,
		buttons : [
                    {
                        text : '关闭',
                        iconCls : 'icon-exit',
                        handler : function (){
                     	   p.dialog('close');
                     	   }
                        }],
		content : '<iframe src="${pageContext.request.contextPath}/announceAction!do_showContent.action?cid=' + row.cid + '" frameborder="0" style="border:0;width:100%;height:99.0%;"></iframe>'
	});

	announce_datagrid.datagrid('unselectAll');
}

function _searchAnnounce() {
	announce_datagrid.datagrid('load', sy.serializeObject($('#announce_search_from')));
};
function cleanSearchAnnounce() {
	$('#announce_search_from table input').val('');
	announce_datagrid.datagrid('load', sy.serializeObject($('#announce_search_from')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询（支持模糊查询）',iconCls:'icon-search'" style="height: 80px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="announce_search_from">
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">通知标题：</th>
				    <td width="150px"><input type="text" name="ctitle" /></td>
				    <td width="150px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchAnnounce();">开始查询</a></td>
				    <td width="150px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchAnnounce();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'通知列表',border:true,iconCls:'icon-role'" style="overflow: hidden;">
		<table id="announce_manager_datagrid"></table>
	</div>
</div>
<div id="announce-menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="announceAppend();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="announceDelete();" data-options="iconCls:'icon-delete'">删除</div>
	<div onclick="announceEdit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>
