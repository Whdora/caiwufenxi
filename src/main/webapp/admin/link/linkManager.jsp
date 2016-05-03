<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var link_datagrid;
$(function ()
{
    link_datagrid = $('#link_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/linkAction!do_datagrid.action',
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
                        title : '创建时间',
                        field : 'ccreatedate',
                        align : "center",
                        width : 150
                    },
                    {
                        title : '链接名称',
                        field : 'ctitle',
                        align : "center",
                        width : 180
                    },
                    {
                        title : '创建人',
                        field : 'userName',
                        align : "center",
                        width : 150
                    },
                    {
                        title : '链接地址',
                        field : 'curl',
                        align : "center",
                        width : 180,
                        formatter : function(value, rowData, rowIndex) {
        					return sy.fs('<a href="{0}" target="_blank">{1}</a>',rowData.curl,rowData.curl);
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
                                '<img onclick="linkEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="linkDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
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
                        linkAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        linkRemove();
                    }
                }, '-'],
            onRowContextMenu : function (e, rowIndex, rowData)
            {
                e.preventDefault();
                $(this).datagrid('unselectAll');
                $(this).datagrid('selectRow', rowIndex);
                $('#link_menu').menu('show',
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

function linkEdit(cid)
{
    if (cid != undefined)
    {
        $('#link_manager_datagrid').datagrid('unselectAll');
        $('#link_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#link_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '链接编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/linkAction!linkEdit.action',
            width : 420,
            height : 200,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/linkAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    link_datagrid.datagrid('reload');
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
            }
        }
        );
};
function linkAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加链接',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/linkAction!linkAdd.action',
            width : 420,
            height : 200,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/linkAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    link_datagrid.datagrid('reload');
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
function linkRemove()
{
    var rows = link_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选链接？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/linkAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        link_datagrid.datagrid('load');
                        link_datagrid.datagrid('unselectAll');
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

function linkDelete(cid)
{
    $('#link_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#link_manager_datagrid').datagrid('checkRow', $('#link_manager_datagrid').datagrid('getRowIndex', cid));
    linkRemove();
};



function _searchLink() {
	link_datagrid.datagrid('load', sy.serializeObject($('#link_search_from')));
};
function cleanSearchLink() {
	$('#link_search_from table input').val('');
	link_datagrid.datagrid('load', sy.serializeObject($('#link_search_from')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询（支持模糊查询）',iconCls:'icon-search'" style="height: 80px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="link_search_from">
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">链接名称：</th>
				    <td width="150px"><input type="text" name="ctitle" /></td>
				    <td width="150px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchLink();">开始查询</a></td>
				    <td width="150px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchLink();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'链接列表',border:true,iconCls:'icon-link'" style="overflow: hidden;">
		<table id="link_manager_datagrid"></table>
	</div>
</div>
<div id="link-menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="linkAppend();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="linkDelete();" data-options="iconCls:'icon-delete'">删除</div>
	<div onclick="linkEdit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>
