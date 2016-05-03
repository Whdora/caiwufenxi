<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var audit_datagrid;
$(function ()
{
    audit_datagrid = $('#audit_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/budgetAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}',cstate:3 },
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
                width : 200
            }]],
            columns : [[
                    {
                        title : '所属专业',
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
                        title : '预计清算时间',
                        field : 'cyjqssj',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '实际清算时间',
                        field : 'csjqssj',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '实际清算（不含税）',
                        field : 'csjfy',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '清算与预计差异',
                        field : 'cfycy',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '税金',
                        field : 'csj',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '清算总费用',
                        field : 'ctotal',
                        align : "center",
                        width : 80
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
                        hidden : true
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
                        auditView();
                    }
                }, '-',
                {
                    text : '清算录入',
                    iconCls : 'icon-input',
                    handler : function ()
                    {
                        auditEdit();
                    }
                }, '-',
                {
                    text : '导出Excel',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                        var url='${pageContext.request.contextPath}/auditAction!exportExcel.action';
                        $('#audit_search_form').attr('action',url);
                        $('#audit_search_form').submit();
                    }
                }, '-'
                ]
        }
        );
    $('#audit_manager_deptid').val('${sessionInfo.deptId}');
    
}
);

function auditView()
{
	var rows = audit_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '重点业务费详情查看',
            iconCls : 'icon-view',
            href : '${pageContext.request.contextPath}/auditAction!auditView.action',
            width : 660,
            height : 550,
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
                 $('#audit_view_filepath').attr('href','${pageContext.request.contextPath}'+rows[0].filePath);
                 $('#audit_view_filename').html(rows[0].fileName);
                 $('#audit_view_auditfilepath').attr('href','${pageContext.request.contextPath}'+rows[0].cauditfilepath);
                 $('#audit_view_auditfilename').html(rows[0].cauditfilename);
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

function auditEdit()
{
	var rows = audit_datagrid.datagrid('getChecked');
	if (rows.length == 1 ) {
   		 var p = parent.sy.dialog(
        {
            title : '重点业务费清算录入',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/auditAction!auditEdit.action',
            width : 600,
            height : 550,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/auditAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    audit_datagrid.datagrid('reload');
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
                },
                {
                    text : '关闭',
                    iconCls : 'icon-exit',
                    handler : function (){
                 	   p.dialog('close');
                 	   }
                }
            ],
            onLoad : function ()
            {
                var f = p.find('form');
                f.form('load',rows[0]);
                $.ajax({
            		type:'post',
        			url:'${pageContext.request.contextPath}/costAction!do_sumyt.action',
        			data:{budgetId:rows[0].cid},
        			success:function(d){
        				 var json = $.parseJSON(d);
        				$('#auditEdit_yyt').val(json.obj);
        			}
        		});
            }
        }
        );
	 }
	else
		 if (rows.length > 1) {
				parent.sy.messagerAlert('提示', '只能选择一条记录编辑！', 'info');
			} else {
				parent.sy.messagerAlert('提示', '请选择要修改的记录！', 'info');
			}
};


function _searchBudget_audit() {
	audit_datagrid.datagrid('load', sy.serializeObject($('#audit_search_form')));
};
function _cleanSearchBudget_audit() {
	$('#audit_search_form table input[name!=deptId]').val('');
	audit_datagrid.datagrid('load', sy.serializeObject($('#audit_search_form')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询（支持模糊查询）',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="audit_search_form" method="post" target="_blank">
			<input type="hidden" name="cstate" value="3" />
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">所属单位：</th>
					<td width="150px"><input  id="audit_manager_deptid" class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:150px"/></td>
				    <th width="100px">归属办法名称：</th>
				    <td width="150px"><input type="text" name="fileName"  style="width:150px"/></td>
				  </tr>
				  <tr>
				    <th>所属专业：</th>
				    <td><input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'"  style="width:150px"/></td>
				    <th>归属项目：</th>
				    <td><input class="easyui-combobox" name="projectId" data-options="url:'projectAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'"  style="width:150px"/></td>
				  </tr>
				  <tr>
				    <th>创建起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="createStartDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				    <th>创建结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="createEndDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px" /></td>
				  </tr>
				  <tr>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchBudget_audit();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="_cleanSearchBudget_audit();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'重点业务费预算列表',border:true" style="overflow: hidden;">
		<table id="audit_manager_datagrid"></table>
	</div>
</div>
