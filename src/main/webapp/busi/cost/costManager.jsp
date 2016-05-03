<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var cost_datagrid;
var costOverBudget=false;
$(function ()
{
    cost_datagrid = $('#cost_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/costAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}',ciszd:2},
            pagination : true,
            pageSize : 10,
            pageList : [10, 20, 30, 40],
            border : false,
            fit : true,
            idField : 'cid',
            sortName : 'ccreatedate',
            sortOrder : 'desc',
            checkOnSelect : true,
            selectOnCheck : true,
            singleSelect:false,
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
			},{
				title:'事由(摘要)',
				field:'cshiyou',
				align:'center',
				width:200
			}]],
            columns : [[
					{
					    title : '单证编号',
					    field : 'cbh',
					    width : 80,
					    align : "center"
					},   
                    {
                        title : '列支方式',
                        field : 'clzfs',
                        width : 100,
                        align : "center"
                    },
                    {
                        title : '借贷方向',
                        field : 'cfx',
                        width : 60,
                        align : "center"
                    },
                    {
                        title : '科目编号',
                        field : 'subjectId',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '会计科目',
                        field : 'subjectName',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '金额',
                        field : 'camount',
                        align : "center",
                        width : 80,
                        sortable : true
                    },
                    {
                        title : '税金',
                        field : 'csj',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '性质',
                        field : 'cxz',
                        width : 50,
                        align : "center"
                    },
                    {
                        title : '归类',
                        field : 'kindName',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '所属专业',
                        field : 'zrzxName',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '归属项目',
                        field : 'projectName',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '商品',
                        field : 'shangpinName',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '入账属性',
                        field : 'crzsx',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '凭证号',
                        field : 'cpzh',
                        align : "center",
                        width : 60
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
                        width : 250,
                        formatter : function(value, rowData, rowIndex) {
                        	if (rowData.fileName != null){
                        		return sy.fs('<a href="{0}" target="_blank" >{1}</a>',"${pageContext.request.contextPath}"+rowData.filePath,rowData.fileName);
                        	}
        				}
                    },
                    {
                        title : '创建日期',
                        field : 'ccreatedate',
                        align : "center",
                        width : 80
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
                        title : '归类ID',
                        field : 'kindId',
                        width : 60,
                        align : "center",
                        hidden : true
                    },
                    {
                        title : '所属专业ID',
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
                        costView();
                    }
                }, '-',
                {
                    text : '增加',
                    iconCls : 'icon-append',
                    handler : function ()
                    {
                        costAppend();
                    }
                }, '-',
                {
                    text : '修改',
                    iconCls : 'icon-edit',
                    handler : function ()
                    {
                        costEdit();
                    }
                }, '-',
                {
                    text : '删除',
                    iconCls : 'icon-delete',
                    handler : function ()
                    {
                        costRemove();
                    }
                }, '-',
                {
                    text : '打印',
                    iconCls : 'icon-print',
                    handler : function ()
                    {
                    	zd_costPrint();
                    }
                }, '-',
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                        var url='${pageContext.request.contextPath}/costAction!exportExcel.action';
                        $('#cost_search_form').attr('action',url);
                        $('#cost_search_form').submit();
                    }
                }, '-'
                ]
        }
        );
    $('#cost_manager_deptid').val('${sessionInfo.deptId}');
    $('#CostManager_kjkm').combotree({
		 url:'kjkmAction!do_treegrid.action',
		 panelHeight:400,
		 lines:true,
		 onBeforeSelect:function(node){
			 if (!$(this).tree('isLeaf',node.target)){
				 return false;
			 }
		 },
		 onClick:function(node){
			 if (!$(this).tree('isLeaf',node.target)){
				 $('#CostManager_kjkm').combo('showPanel');
			 }
		 }
	 }) ;
}
);

function zd_costPrint(){
	var rows = cost_datagrid.datagrid('getChecked');
	var ids = [];
	if (rows.length>0){
		 for (var i = 0; i < rows.length; i++)
         {
             ids.push(rows[i].cid);
         }
		 $('#cost_print_ids').val(ids);
		 var url='${pageContext.request.contextPath}/costAction!costPrint.action';
         $('#cost_search_form').attr('action',url);
         $('#cost_search_form').submit();
	}else{
		parent.sy.messagerAlert('提示', '请选择要打印的记录！', 'info');
	}
}

function costView()
{
	var rows = cost_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '成本费用查看',
            iconCls : 'icon-view',
            href : '${pageContext.request.contextPath}/costAction!costView.action',
            width : 660,
            height : 560,
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

function costEdit()
{
	var rows = cost_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
   		 var p = parent.sy.dialog(
        {
            title : '成本费用编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/costAction!costEdit.action',
            width : 660,
            height : 420,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                    	 var f = p.find('form');
                         if ($('#cost_edit_file_input').combogrid('getValue').length>0){
                			 $.ajax(
                                     {
                                         url : '${pageContext.request.contextPath}/costAction!do_check.action',
                                         data :
                                         {
                                             budgetId:$('#cost_edit_file_input').combogrid('getValue'),
                                             camount:$("#cost_edit_amount").val(),
                                             cid:rows[0].cid
                                         },
                                         async:false,
                                         dataType : 'json',
                                         cache : false,
                                         success : function (dd)
                                         {
                                        	 if (dd.success){
                                        		 _overCost();
                                        	 }
                                         }
                                     }
                                     );
                         }
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/costAction!edit.action',
                            onSubmit: function(){   
                                if (!f.form('validate')){
                                	return false;
                                }  
                                else
                                {
                                	    if (costOverBudget){
                                	    	parent.sy.messagerAlert('提示', '成本费用已超过已审核预算70%或者清算数！', 'warning',function(){
                                 				$('#cost_edit_amount').select();
                                 				costOverBudget=false;
                                    		 });
                                	    	return false;
                                	}
                                }
                            },
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                    cost_datagrid.datagrid('reload');
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
        );
	 }
	else
		 if (rows.length > 1) {
				parent.sy.messagerAlert('提示', '只能选择一条记录编辑！', 'info');
			} else {
				parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'info');
			}
};
function costAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加成本费用',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/costAction!costAdd.action',
            width : 660,
            height : 420,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        if ($('#cost_file_input').combogrid('getValue').length>0){
               			 $.ajax(
                                    {
                                        url : '${pageContext.request.contextPath}/costAction!do_check.action',
                                        data :
                                        {
                                            budgetId:$('#cost_file_input').combogrid('getValue'),
                                            camount:$("#cost_input_amount").val()
                                        },
                                        async:false,
                                        dataType : 'json',
                                        cache : false,
                                        success : function (dd)
                                        {
                                       	 if (dd.success){
                                       		 _overCost();
                                       	 }
                                        }
                                    }
                                    );
                        }
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/costAction!add.action',
                            onSubmit: function(){   
                                if (!f.form('validate')){
                                	return false;
                                }  
                                else
                                {
                                	if ($('#cost_xingzhi').combobox('getValue')=="重点"){
                                		if ( $('#cost_file_input').combogrid('getValue').length==0){
                                			parent.sy.messagerAlert('提示', '重点业务费归属办法不能为空！', 'warning',function(){
                                				$('#cost_file_input').focus();
                                			});
                                			return false;
                                		};
                                	  if (costOverBudget){
                                	    	parent.sy.messagerAlert('提示', '成本费用已超过已审核预算70%或者清算数！', 'warning',function(){
                                 				$('#cost_input_amount').focus();
                                 				costOverBudget=false;
                                    		 });
                                	    	return false;
                                	    }
                                	}
                                }
                            },
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                    cost_datagrid.datagrid('reload');
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
function costRemove()
{
    var rows = cost_datagrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0)
    {
        parent.sy.messagerConfirm('请确认', '是否删除当前所选成本费用？', function (r)
        {
            if (r)
            {
                for (var i = 0; i < rows.length; i++)
                {
                    ids.push(rows[i].cid);
                }
                $.ajax(
                {
                    url : '${pageContext.request.contextPath}/costAction!delete.action',
                    data :
                    {
                        ids : ids.join(',')
                    },
                    dataType : 'json',
                    success : function (d)
                    {
                        cost_datagrid.datagrid('load');
                        cost_datagrid.datagrid('unselectAll');
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

function costDelete(cid)
{
    $('#cost_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#cost_manager_datagrid').datagrid('checkRow', $('#cost_manager_datagrid').datagrid('getRowIndex', cid));
    costRemove();
};


function _searchCost() {
	cost_datagrid.datagrid('load', sy.serializeObject($('#cost_search_form')));
};
function cleanSearchCost() {
	$("#cost_search_form ").find("input[name!='deptId']").val('');
	 $('#cost_manager_deptid').combotree('setValue','${sessionInfo.deptId}');
	 $("#cost_search_form ").find("input[name='ciszd']").val('2');
	 $("#cost_search_form ").find("input[name='deptName']").val('${sessionInfo.deptName }');
	cost_datagrid.datagrid('load', sy.serializeObject($('#cost_search_form')));
};
function _overCost(){
	costOverBudget=true;
}
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询成本费用（支持模糊查询）',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="cost_search_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<input type="hidden" name="ciszd" value="2" />
			<input type="hidden" id="cost_print_ids" name="ids" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="120px"><input  id="cost_manager_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:120px"/></td>
					<th width="100px">事由(摘要)：</th>
				    <td width="150px"><input type="text" name="cshiyou" style="width:120px"/></td>
					<th width="100px">列支方式:</th>
					 <td width="150">
			    		<select  class="easyui-combobox" name="clzfs" data-options="panelHeight:'auto'" style="width:150px">  
						    <option >现金</option>  
						    <option>银行</option>
						     <option>银行（市局付）</option>
						    <option>转账</option> 
						    <option>收款</option> 
						</select>  
		   			 </td>
		   			 <th width="100px">性质：</th>
				    <td width="150">
					    <select id="cost_manager_xingzhi" class="easyui-combobox" name="cxz" data-options="panelHeight:'auto'" style="width:150px">  
						    <option >重点</option>
						    <option>正常</option>  
						</select>  
					</td>
					<th width="80px">单证编号：</th>
				    <td width="80px"><input type="text" name="cbh" style="width:80px"/></td>
				</tr>
				<tr>
				    <th>会计科目：</th>
				    <td colspan="3"><input id="CostManager_kjkm" name="subjectId"  style="width:350px"/></td>
				    <th>所属专业：</th>
				    <td><input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/></td>
				    <th>归属项目：</th>
				    <td><input class="easyui-combobox" name="projectId" data-options="url:'projectAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/></td>
				    <th>商品：</th>
				    <td ><input class="easyui-combobox" name="shangpinId" data-options="url:'shangpinAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:80px"/></td>
				  </tr>
				<tr>
				    <th >归属办法字号：</th>
				    <td ><input type="text" name="fileNumber" style="width:120px"/></td>
				    <th >归属办法名称：</th>
				    <td ><input type="text" name="fileName" style="width:120px" /></td>
				    <th>入账起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="createStartDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				    <th>入账结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="createEndDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				  </tr>
				  <tr>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchCost();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchCost();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'成本费用列表',border:true" style="overflow: hidden;">
		<table id="cost_manager_datagrid"></table>
	</div>
</div>