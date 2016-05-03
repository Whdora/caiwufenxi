<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var budget_datagrid;
$(function ()
{
    budget_datagrid = $('#budget_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/budgetAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}'},
            pagination : true,
            pageSize : 10,
            pageList : [10, 20, 30, 40],
            border : false,
            fit : true,
            idField : 'cid',
            sortName : 'ccreatedate',
            sortOrder : 'desc',
            checkOnSelect : false,
            selectOnCheck : true,
            frozenColumns : [ [ {
				title:'编号',
				field:'cid',
				width:80,
				align:'center',
				checkbox : true
			},{
				title:'单位',
				field:'deptName',
				align:'center',
				width:100
			},
			{
                title : '归属办法字号',
                field : 'fileNumber',
                align : "center",
                width : 150
            },
            {
                title : '归属办法名称',
                field : 'fileName',
                align : "center",
                width : 200,
                formatter : function(value, rowData, rowIndex) {
					return sy.fs('<a href="{0}" target="_blank" >{1}</a>',"${pageContext.request.contextPath}"+rowData.filePath,rowData.fileName);
				}
            }]],
            columns : [[
                    {
                        title : '归属专业',
                        field : 'zrzxName',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '归属项目',
                        field : 'projectName',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '预计业务量收',
                        field : 'cyjywls',
                        align : "center",
                        width : 120,
                        sortable : true
                    },
                    {
                        title : '预计费用（不含税）',
                        field : 'cyjfy',
                        align : "center",
                        width : 180
                    },
                    {
                        title : '预计利润',
                        field : 'cyjlr',
                        width : 80,
                        align : "center"
                    },
                    {
                        title : '已用成本费用',
                        field : 'cyt',
                        width : 120,
                        align : "center"
                    },
                    {
                        title : '预计清算时间',
                        field : 'cyjqssj',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '清算费用（不含税）',
                        field : 'csjfy',
                        width : 180,
                        align : "center"
                    },
                    {
                        title : '创建日期',
                        field : 'ccreatedate',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '状态',
                        field : 'cstate',
                        align : "center",
                        width : 80,
                        formatter:function(value, row, index) {
                        	if (value==0){
                        		return "未提交审核";
                        	}
                        	else
                        		{
                        		  if (value==1){
                        			  return "等待审核";
                        		  }	else{
                        			  if (value==2){
                        				  return "审核未通过";
                        			  }else{
                        				  if (value==3){
                        					  return "已审核通过";  
                        				  }
                        			  }
                        		  }
                        		}
                        }
                    },
                    {
                        title : '单位ID',
                        field : 'deptId',
                        width : 80,
                        align : "center",
                        hidden : true
                    },
                    {
                        title : '用户ID',
                        field : 'userID',
                        align : "center",
                        width : 80,
                        hidden : true
                    },
                    {
                        title : '责任中心ID',
                        field : 'zrzxId',
                        align : "center",
                        width : 80,
                        hidden : true
                    },
                    {
                        title : '归属项目ID',
                        field : 'projectId',
                        align : "center",
                        width : 80,
                        hidden : true
                    },
                    {
                        title : '归属办法ID',
                        field : 'fileId',
                        align : "center",
                        width : 100 ,
                        hidden : true
                    },
                    {
                        title : '考核开始时间',
                        field : 'startdate',
                        align : "center",
                        width : 100 ,
                        hidden : true
                    },
                    {
                        title : '考核结束时间',
                        field : 'enddate',
                        align : "center",
                        width : 100 ,
                        hidden : true
                    }
                ]],
            toolbar : [
                {
                    text : '查看',
                    iconCls : 'icon-view',
                    handler : function ()
                    {
                        budgetView();
                    }
                }, '-',
                {
                    text : '增加',
                    iconCls : 'icon-append',
                    handler : function ()
                    {
                        budgetAppend();
                    }
                }, '-',
                {
                    text : '修改',
                    iconCls : 'icon-edit',
                    handler : function ()
                    {
                        budgetEdit();
                    }
                }, '-',
                {
                    text : '删除',
                    iconCls : 'icon-delete',
                    handler : function ()
                    {
                        budgetRemove();
                    }
                }, '-',
                {
                    text : '提交审核',
                    iconCls : 'icon-redo',
                    handler : function ()
                    {
                        budgetSubmit();
                    }
                }, '-',
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                        var url='${pageContext.request.contextPath}/budgetAction!exportExcel.action';
                        $('#budget_search_from').attr('action',url);
                        $('#budget_search_from').submit();
                    }
                }, '-']
        }
        );
    $('#budget_manager_deptid').val('${sessionInfo.deptId}');
    
}
);

function budgetView()
{
	var rows = budget_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '重点业务费预算查看',
            iconCls : 'icon-view',
            href : '${pageContext.request.contextPath}/budgetAction!budgetView.action',
            width : 660,
            height : 350,
            buttons : [
                       {
                           text : '关闭',
                           iconCls : 'icon-exit',
                           handler : function (){
                        	   p.dialog('close');
                        	   }
                           }],
            onLoad : function ()
            {
            	 var f = p.find('form');
                 f.form('load',rows[0]);
                 f.find('a').attr('href','${pageContext.request.contextPath}'+rows[0].filePath);
                 f.find('span').html(rows[0].fileName);
            }
        }
        );
    }
	else
		 if (rows.length > 1) {
				parent.sy.messagerAlert('提示', '只能选择一条记录查看！', 'info');
			} else {
				parent.sy.messagerAlert('提示', '请选择要查看的记录！', 'info');
			}
};

function budgetEdit()
{
	var rows = budget_datagrid.datagrid('getChecked');
	if (rows.length == 1 ) {
		if (rows[0].cstate!=3){
   		 var p = parent.sy.dialog(
        {
            title : '重点业务费预算编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/budgetAction!budgetEdit.action',
            width : 580,
            height : 300,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/budgetAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                	budget_datagrid.datagrid('reload');
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
                f.form('load',rows[0]);
            }
        }
        );}
		else{
			parent.sy.messagerAlert('提示', '该成本费用预算已审批通过，只有管理员才能修改！', 'info');
		}
	 }
	else
		 if (rows.length > 1) {
				parent.sy.messagerAlert('提示', '只能选择一条记录编辑！', 'info');
			} else {
				parent.sy.messagerAlert('提示', '请选择要修改的记录！', 'info');
			}
};

function budgetAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加重点业务费预算',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/budgetAction!budgetAdd.action',
            width : 600,
            height : 300,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/budgetAction!add.action',
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    budget_datagrid.datagrid('reload');
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
};

function budgetRemove()
{
    var rows = budget_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选重点业务费预算？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/budgetAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        budget_datagrid.datagrid('load');
                        budget_datagrid.datagrid('unselectAll');
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

function budgetSubmit()
{
    var rows = budget_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否将当前所选重点业务费预算提交审核？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/budgetAction!submit.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        budget_datagrid.datagrid('load');
                        budget_datagrid.datagrid('unselectAll');
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
        parent.sy.messagerAlert('提示', '请选择要提交审核的记录！', 'error');
    }
};

function budgetDelete(cid)
{
    $('#budget_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#budget_manager_datagrid').datagrid('checkRow', $('#budget_manager_datagrid').datagrid('getRowIndex', cid));
    budgetRemove();
};


function _searchBudget() {
	budget_datagrid.datagrid('load', sy.serializeObject($('#budget_search_from')));
};
function cleanSearchBudget() {
	$('#budget_search_from table input[name!=deptId]').val('');
	 $('#budget_manager_deptid').combotree('setValue','${sessionInfo.deptId}');
	 $('#budget_search_from').find('input[name=deptName]').val('${sessionInfo.deptName }');
	budget_datagrid.datagrid('load', sy.serializeObject($('#budget_search_from')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询预算（支持模糊查询）',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="budget_search_from" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">所属单位：</th>
					<td width="150px"><input  id="budget_manager_deptid" class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true" /></td>
				    <th width="100px">归属办法名称：</th>
				    <td width="150px"><input type="text" name="fileName" /></td>
				  </tr>
				  <tr>
				    <th>所属专业：</th>
				    <td><input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" /></td>
				    <th>归属项目：</th>
				    <td><input class="easyui-combobox" name="projectId" data-options="url:'projectAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" /></td>
				  </tr>
				  <tr>
				    <th>创建起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="createStartDate" data-options="dateFmt:'yyyy-MM-dd'"  style="width:150px" /></td>
				    <th>创建结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="createEndDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px" /></td>
				  </tr>
				  <tr>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchBudget();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchBudget();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'重点业务费预算列表',border:true" style="overflow: hidden;">
		<table id="budget_manager_datagrid"></table>
	</div>
</div>
