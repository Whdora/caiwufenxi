<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var project_datagrid;
$(function ()
{
    project_datagrid = $('#project_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/projectAction!do_datagrid.action',
            title : '归属项目列表',
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
                        title : '归属项目名称',
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
                                '<img onclick="projectEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="projectDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
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
                        projectAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        projectRemove();
                    }
                }, '-'],
            onRowContextMenu : function (e, rowIndex, rowData)
            {
                e.preventDefault();
                $(this).datagrid('unselectAll');
                $(this).datagrid('selectRow', rowIndex);
                $('#project_menu').menu('show',
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

function projectEdit(cid)
{
    if (cid != undefined)
    {
        $('#project_manager_datagrid').datagrid('unselectAll');
        $('#project_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#project_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '归属项目编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/projectAction!projectEdit.action',
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
                            url : '${pageContext.request.contextPath}/projectAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    project_datagrid.datagrid('reload');
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
function projectAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加归属项目',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/projectAction!projectAdd.action',
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
                            url : '${pageContext.request.contextPath}/projectAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    project_datagrid.datagrid('reload');
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
function projectRemove()
{
    var rows = project_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选归属项目？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/projectAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        project_datagrid.datagrid('load');
                        project_datagrid.datagrid('unselectAll');
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

function projectDelete(cid)
{
    $('#project_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#project_manager_datagrid').datagrid('checkRow', $('#project_manager_datagrid').datagrid('getRowIndex', cid));
    projectRemove();
}

</script>
<table id="project_manager_datagrid" ></table>
<div id="project-menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="projectAppend();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="projectDelete();" data-options="iconCls:'icon-delete'">删除</div>
	<div onclick="projectEdit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>
