<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var shangpin_datagrid;
$(function ()
{
    shangpin_datagrid = $('#shangpin_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/shangpinAction!do_datagrid.action',
            title : '商品列表',
            pagination : true,
            pageSize : 10,
            pageList : [10, 20, 30, 40],
            border : true,
            fit: true,
            idField : 'cid',
            sortName : 'cname',
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
                        title : '商品名称',
                        field : 'cname',
                        align : "center",
                        width : 200,
                        sortable : true
                    },
                    {
                        field : 'action',
                        title : '操作',
                        width : 120,
                        align : 'center',
                        formatter : function (value, row, index)
                        {
                            return sy.fs(
                                '<img onclick="shangpinEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="shangpinDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
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
                        shangpinAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        shangpinRemove();
                    }
                }, '-'],
            onRowContextMenu : function (e, rowIndex, rowData)
            {
                e.preventDefault();
                $(this).datagrid('unselectAll');
                $(this).datagrid('selectRow', rowIndex);
                $('#shangpin_menu').menu('show',
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

function shangpinEdit(cid)
{
    if (cid != undefined)
    {
        $('#shangpin_manager_datagrid').datagrid('unselectAll');
        $('#shangpin_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#shangpin_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '商品编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/shangpinAction!shangpinEdit.action',
            width : 320,
            height : 150,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/shangpinAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    shangpin_datagrid.datagrid('reload');
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
                f.form('load',
                {
                    cid : rows.cid,
                    cname : rows.cname,
                }
                );
            }
        }
        );
};
function shangpinAppend()
{
    var p = parent.sy.dialog(
        {
            title : '商品项目',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/shangpinAction!shangpinAdd.action',
            width : 320,
            height : 150,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/shangpinAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    shangpin_datagrid.datagrid('reload');
                                    f.find('input[name=cname]').val('').focus();
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
function shangpinRemove()
{
    var rows = shangpin_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选商品？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/shangpinAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        shangpin_datagrid.datagrid('load');
                        shangpin_datagrid.datagrid('unselectAll');
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

function shangpinDelete(cid)
{
    $('#shangpin_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#shangpin_manager_datagrid').datagrid('checkRow', $('#shangpin_manager_datagrid').datagrid('getRowIndex', cid));
    shangpinRemove();
}

</script>
<table id="shangpin_manager_datagrid" ></table>
<div id="shangpin-menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="shangpinAppend();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="shangpinDelete();" data-options="iconCls:'icon-delete'">删除</div>
	<div onclick="shangpinEdit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>
