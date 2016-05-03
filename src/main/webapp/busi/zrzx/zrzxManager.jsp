<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var zrzx_datagrid;
$(function ()
{
    zrzx_datagrid = $('#zrzx_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/zrzxAction!do_datagrid.action',
            title : '专业列表',
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
                        title : '专业名称',
                        field : 'cname',
                        align : "center",
                        width : 180,
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
                                '<img onclick="zrzxEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="zrzxDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
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
                        zrzxAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        zrzxRemove();
                    }
                }, '-']
        }
        );
    
}
);

function zrzxEdit(cid)
{
    if (cid != undefined)
    {
        $('#zrzx_manager_datagrid').datagrid('unselectAll');
        $('#zrzx_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#zrzx_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '专业编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/zrzxAction!zrzxEdit.action',
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
                            url : '${pageContext.request.contextPath}/zrzxAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    zrzx_datagrid.datagrid('reload');
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
function zrzxAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加专业',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/zrzxAction!zrzxAdd.action',
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
                            url : '${pageContext.request.contextPath}/zrzxAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    zrzx_datagrid.datagrid('reload');
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
function zrzxRemove()
{
    var rows = zrzx_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选专业？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/zrzxAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        zrzx_datagrid.datagrid('load');
                        zrzx_datagrid.datagrid('unselectAll');
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

function zrzxDelete(cid)
{
    $('#zrzx_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#zrzx_manager_datagrid').datagrid('checkRow', $('#zrzx_manager_datagrid').datagrid('getRowIndex', cid));
    zrzxRemove();
}

</script>
<table id="zrzx_manager_datagrid" ></table>
