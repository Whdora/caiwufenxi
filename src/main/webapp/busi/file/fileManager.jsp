<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var file_datagrid;
$(function ()
{
    file_datagrid = $('#file_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/fileAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}'},
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
                        title : '单位名称',
                        field : 'deptName',
                        align : "center",
                        width : 150,
                    },
                    {
                        title : '归属办法文件号',
                        field : 'cfilenumber',
                        align : "center",
                        width : 180,
                        sortable : true
                    },
                    {
                        title : '归属办法名称',
                        field : 'cname',
                        align : "center",
                        width : 250,
                        formatter : function(value, rowData, rowIndex) {
        					return sy.fs('<a href="{0}" target="_blank" >{1}</a>',"${pageContext.request.contextPath}"+rowData.cfilepath,rowData.cname);
        				}
                    },
                    {
                        title : '发布时间',
                        field : 'cdate',
                        align : "center",
                        width : 120,
                        sortable : true
                    },
                    {
                        title : '考核开始时间',
                        field : 'cstartdate',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '考核结束时间',
                        field : 'cenddate',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '创建时间',
                        field : 'ccreatedate',
                        align : "center",
                        width : 120,
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
                                '<img onclick="fileEdit(\'{0}\');" src="{1}" style="cursor: pointer;" title="修改"/>&nbsp;<img onclick="fileDelete(\'{2}\');" src="{3}"  style="cursor: pointer;" title="删除"/>',
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
                        fileAppend();
                    }
                }, '-',
                {
                    text : '批量删除',
                    iconCls : 'icon-remove',
                    handler : function ()
                    {
                        fileRemove();
                    }
                }, '-'],
            onRowContextMenu : function (e, rowIndex, rowData)
            {
                e.preventDefault();
                $(this).datagrid('unselectAll');
                $(this).datagrid('selectRow', rowIndex);
                $('#file_menu').menu('show',
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

function fileEdit(cid)
{
    if (cid != undefined)
    {
        $('#file_manager_datagrid').datagrid('unselectAll');
        $('#file_manager_datagrid').datagrid('selectRecord', cid);
    }
    var rows = $('#file_manager_datagrid').datagrid('getSelected');
    var p = parent.sy.dialog(
        {
            title : '归属办法编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/fileAction!fileEdit.action',
            width : 500,
            height : 350,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/fileAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    file_datagrid.datagrid('reload');
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
function fileAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加归属办法',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/fileAction!fileAdd.action',
            width : 500,
            height : 350,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/fileAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    file_datagrid.datagrid('reload');
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
function fileRemove()
{
    var rows = file_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选归属办法？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/fileAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        file_datagrid.datagrid('load');
                        file_datagrid.datagrid('unselectAll');
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

function fileDelete(cid)
{
    $('#file_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#file_manager_datagrid').datagrid('checkRow', $('#file_manager_datagrid').datagrid('getRowIndex', cid));
    fileRemove();
};

function showCdesc(rowIndex) {
	var rows = file_datagrid.datagrid('getRows');
	var row = rows[rowIndex];

	var p = parent.sy.dialog({
		title : '[' + row.cname + ']',
		modal : true,
		maximizable : true,
		width : 600,
		height : 400,
		buttons : [
                    {
                        text : '关闭',
                        iconCls : 'icon-exit',
                        handler : function (){
                     	   p.dialog('close');
                     	   }
                        }],
		content : '<iframe src="${pageContext.request.contextPath}/fileAction!do_showContent.action?cid=' + row.cid + '" frameborder="0" style="border:0;width:100%;height:99.0%;"></iframe>'
	});

	file_datagrid.datagrid('unselectAll');
}

function _searchFile() {
	file_datagrid.datagrid('load', sy.serializeObject($('#file_search_from')));
};
function cleanSearchFile() {
	$('#file_search_from table input').val('');
	file_datagrid.datagrid('load', sy.serializeObject($('#file_search_from')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询文件（支持模糊查询）',iconCls:'icon-search'" style="height: 150px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="file_search_from">
			<input type="hidden" name="deptId" value="${sessionInfo.deptId}" />
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">文件字号：</th>
				    <td width="150px"><input type="text" name="cfilenumber" /></td>
				    <th width="100px">文件名称：</th>
				    <td width="150px"><input type="text" name="cname" /></td>
				  </tr>
				  <tr>
				    <th>发布起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="createStartDate" data-options="dateFmt:'yyyy-MM-dd'" /></td>
				    <th>发布结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="createEndDate" data-options="dateFmt:'yyyy-MM-dd'" /></td>
				  </tr>
				  <tr>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchFile();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchFile();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'归属办法列表',border:true,iconCls:'icon-role'" style="overflow: hidden;">
		<table id="file_manager_datagrid"></table>
	</div>
</div>
