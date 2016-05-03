<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var download_datagrid;
$(function ()
{
    download_datagrid = $('#download_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/downloadAction!do_datagrid.action',
            pagination : true,
            pageSize : 10,
            pageList : [10, 20, 30, 40],
            border : false,
            fit: true,
            fitColumns : true,
            idField : 'cid',
            sortName : 'cuploaddate',
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
                        title : '上传时间',
                        field : 'cuploaddate',
                        align : "center",
                        width : 150
                    },
                    {
                        title : '文件名称',
                        field : 'cfilename',
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
                        title : '下载链接',
                        field : 'cfilepath',
                        align : "center",
                        width : 180,
                        formatter : function(value, rowData, rowIndex) {
        					return sy.fs('<span class="icon-download" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span><a href="${pageContext.request.contextPath}/downAction!download.action?filename={0}&filepath={1}" >点击下载文件</a>',rowData.cfilename,rowData.cfilepath);
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
                                '<img onclick="downloadEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="downloadDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
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
                        downloadAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        downloadRemove();
                    }
                }, '-'],
            onRowContextMenu : function (e, rowIndex, rowData)
            {
                e.preventDefault();
                $(this).datagrid('unselectAll');
                $(this).datagrid('selectRow', rowIndex);
                $('#download_menu').menu('show',
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

function downloadEdit(cid)
{
    if (cid != undefined)
    {
        $('#download_manager_datagrid').datagrid('unselectAll');
        $('#download_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#download_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '下载编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/downloadAction!downloadEdit.action',
            width : 420,
            height : 250,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/downloadAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    download_datagrid.datagrid('reload');
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
                f.find('input[name=cfilename]').select();
            }
        }
        );
};
function downloadAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加下载',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/downloadAction!downloadAdd.action',
            width : 420,
            height : 270,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/downloadAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    download_datagrid.datagrid('reload');
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
function downloadRemove()
{
    var rows = download_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选下载？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/downloadAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        download_datagrid.datagrid('load');
                        download_datagrid.datagrid('unselectAll');
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

function downloadDelete(cid)
{
    $('#download_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#download_manager_datagrid').datagrid('checkRow', $('#download_manager_datagrid').datagrid('getRowIndex', cid));
    downloadRemove();
};



function _searchDownload() {
	download_datagrid.datagrid('load', sy.serializeObject($('#download_search_from')));
};
function cleanSearchDownload() {
	$('#download_search_from table input').val('');
	download_datagrid.datagrid('load', sy.serializeObject($('#download_search_from')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询（支持模糊查询）',iconCls:'icon-search'" style="height: 80px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="download_search_from">
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">文件名称：</th>
				    <td width="150px"><input type="text" name="cfilename" /></td>
				    <td width="150px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchDownload();">开始查询</a></td>
				    <td width="150px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchDownload();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'下载列表',border:true,iconCls:'icon-download'" style="overflow: hidden;">
		<table id="download_manager_datagrid"></table>
	</div>
</div>
<div id="download-menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="downloadAppend();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="downloadDelete();" data-options="iconCls:'icon-delete'">删除</div>
	<div onclick="downloadEdit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>
