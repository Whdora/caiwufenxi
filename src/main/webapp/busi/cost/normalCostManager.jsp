<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function ()
{
    normal_cost_datagrid = $('#normal_cost_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/costAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}',ciszd:1},
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
				width:240
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
                        width : 140
                    },
                    {
                        title : '金额',
                        field : 'camount',
                        align : "center",
                        width : 80,
                        sortable : true
                    },
                    {
                        title : '性质',
                        field : 'cxz',
                        width : 50,
                        align : "center"
                    },
                    {
                        title : '商品',
                        field : 'shangpinName',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '所属专业',
                        field : 'zrzxName',
                        align : "center",
                        width : 120
                    },
                    {
                        title : '入账属性',
                        field : 'crzsx',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '入账时间',
                        field : 'cdate',
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
                        title : '所属专业ID',
                        field : 'zrzxId',
                        align : "center",
                        width : 80,
                        hidden : true
                    }
                ]],
            toolbar : [
                {
                    text : '查看',
                    iconCls : 'icon-view',
                    handler : function ()
                    {
                        normal_costView();
                    }
                }, '-',
                {
                    text : '增加',
                    iconCls : 'icon-append',
                    handler : function ()
                    {
                        normal_costAppend();
                    }
                }, '-',
                {
                    text : '修改',
                    iconCls : 'icon-edit',
                    handler : function ()
                    {
                        normal_costEdit();
                    }
                }, '-',
                {
                    text : '删除',
                    iconCls : 'icon-delete',
                    handler : function ()
                    {
                        normal_costRemove();
                    }
                }, '-',
                {
                    text : '打印',
                    iconCls : 'icon-print',
                    handler : function ()
                    {
                    	normal_costPrint();
                    }
                }, '-',
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                        var url='${pageContext.request.contextPath}/costAction!exportExcel.action';
                        $('#normal_cost_search_form').attr('action',url);
                        $('#normal_cost_search_form').submit();
                    }
                }, '-'
                ]
        }
        );
    $('#normal_cost_manager_deptid').val('${sessionInfo.deptId}');
    $('#normalCostManager_kjkm').combotree({
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
				 $('#normalCostManager_kjkm').combo('showPanel');
			 }
		 }
	 }) ;
}
);


function normal_costPrint(){
	var rows = normal_cost_datagrid.datagrid('getChecked');
	var ids = [];
	if (rows.length>0){
		 for (var i = 0; i < rows.length; i++)
         {
             ids.push(rows[i].cid);
         }
		 $('#normal_cost_print_ids').val(ids);
		 var url='${pageContext.request.contextPath}/costAction!normalCostPrint.action';
         $('#normal_cost_search_form').attr('action',url);
         $('#normal_cost_search_form').submit();
	}else{
		parent.sy.messagerAlert('提示', '请选择要打印的记录！', 'info');
	}
}

function normal_costView()
{
	var rows = normal_cost_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '成本费用查看',
            iconCls : 'icon-view',
            href : '${pageContext.request.contextPath}/costAction!normalCostView.action',
            width : 620,
            height : 280,
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

function normal_costEdit()
{
	var rows = normal_cost_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
   		 var p = parent.sy.dialog(
        {
            title : '成本费用编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/costAction!normalCostEdit.action',
            width : 620,
            height : 320,
            buttons : [
                {
                    text : '保存',
                    iconCls : 'icon-save',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/costAction!edit.action',
                            success : function (d)
                            {
                                var json = $
                                    .parseJSON(d);
                                if (json.success)
                                {
                                	normal_cost_datagrid.datagrid('reload');
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
function normal_costAppend()
{
    var p = parent.sy.dialog(
        {
            title : '添加成本费用',
            iconCls : 'icon-append',
            href : '${pageContext.request.contextPath}/costAction!normalCostAdd.action',
            width : 620,
            height : 320,
            buttons : [
                {
                    text : '添加',
                    iconCls : 'icon-ok',
                    handler : function ()
                    {
                        var f = p.find('form');
                        f.form('submit',
                        {
                            url : '${pageContext.request.contextPath}/costAction!add.action',
                            onSubmit: function(){   
                                if (!f.form('validate')){
                                	return false;
                                }  
                            },
                            success : function (d)
                            {
                                var json = $.parseJSON(d);
                                if (json.success)
                                {
                                	normal_cost_datagrid.datagrid('reload');
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
function normal_costRemove()
{
    var rows = normal_cost_datagrid.datagrid('getChecked');
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
                    	normal_cost_datagrid.datagrid('load');
                    	normal_cost_datagrid.datagrid('unselectAll');
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

function normal_costDelete(cid)
{
    $('#normal_cost_manager_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    $('#normal_cost_manager_datagrid').datagrid('checkRow', $('#normal_cost_manager_datagrid').datagrid('getRowIndex', cid));
    normal_costRemove();
};



function _searchNormalCost() {
	normal_cost_datagrid.datagrid('load', sy.serializeObject($('#normal_cost_search_form')));
};
function cleanSearchNormalCost() {
	$("#normal_cost_search_form ").find("input[name!='deptId']").val('');
	 $('#normal_cost_manager_deptid').combotree('setValue','${sessionInfo.deptId}');
	 $("#normal_cost_search_form ").find("input[name='ciszd']").val('1');
	 $("#normal_cost_search_form ").find("input[name='cxz']").val('正常');
	 $("#normal_cost_search_form ").find("input[name='deptName']").val('${sessionInfo.deptName }');
	 normal_cost_datagrid.datagrid('load', sy.serializeObject($('#normal_cost_search_form')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询正常成本费用（支持模糊查询）',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="normal_cost_search_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<input type="hidden" name="cxz" value="正常" />
			<input type="hidden" name="ciszd" value="1" />
			<input type="hidden" id="normal_cost_print_ids" name="ids" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="120px"><input  id="normal_cost_manager_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:120px"/></td>
					<th width="100px">事由(摘要)：</th>
				    <td width="120px"><input type="text" name="cshiyou" style="width:120px"/></td>
					<th width="100px">列支方式：</th>
					 <td width="150">
			    		<select  class="easyui-combobox" name="clzfs" data-options="panelHeight:'auto'" style="width:150px">  
						    <option >现金</option>  
						    <option>银行</option>
						     <option>银行（市局付）</option>
						    <option>转账</option> 
						    <option>收款</option> 
						</select>  
		   			 </td>
					<th width="100px">所属专业：</th>
				    <td width="150"><input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/></td>
				    <th width="100px">单证编号：</th>
				    <td width="100px"><input type="text" name="cbh" style="width:100px"/></td>
				</tr>
				<tr>
				    <th>会计科目：</th>
				    <td colspan="3"><input id="normalCostManager_kjkm" name="subjectId" style="width:360px"/></td>
				 	<th>入账起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="createStartDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				    <th>入账结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="createEndDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
					<th>商品：</th>
				    <td ><input class="easyui-combobox" name="shangpinId" data-options="url:'shangpinAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:100px"/></td>
				 </tr>
				  <tr>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchNormalCost();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchNormalCost();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'正常成本费用列表',border:true" style="overflow: hidden;">
		<table id="normal_cost_manager_datagrid"></table>
	</div>
</div>