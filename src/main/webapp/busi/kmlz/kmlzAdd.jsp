<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var pz_datagrid;
$(function ()
{
	var lastIndex2;
    pz_datagrid = $('#pz_manager_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/costAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}',ciszd:2,cxz:'正常'},
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
            singleSelect:true,
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
                    	 title : '凭证号',
                         field : 'cpzh',
                         align : "center",
                         width : 80,
                         editor:"text"
                       
                    },
                    {
                    	 title : '列支方式',
                         field : 'clzfs',
                         width : 60,
                         align : "center"
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
                        title : '入账属性',
                        field : 'crzsx',
                        align : "center",
                        width : 80
                    },
                    {
                        title : '创建日期',
                        field : 'ccreatedate',
                        align : "center",
                        width : 80
                    }
                ]],
            toolbar : [
                {
                	text:"保存",
	            	 iconCls:"icon-save",
	            	 handler:function(){
	            		 endEditPz();
	            		 var updates=$("#pz_manager_datagrid").datagrid("getChanges","updated");
					     var edits=[];
					     var datas;
					     if (updates.length>0){
					    	 parent.sy.messagerConfirm('请确认', '是否保存输入的这'+updates.length+"条凭证号？",function(r){  
	                        if(r){  
	                          for ( i=0;i<updates.length;i++){
	                             edits[i]="{"+'"'+"cid"+'"'+":"+'"'+updates[i].cid+'"'+","+'"'+"pzh"+'"'+":"+'"'+$.trim(updates[i].cpzh)+'"'+"}";
	                          };
	                             datas="["+edits.join(",")+"]";
	                             $.ajax({
	                            	 url:"${pageContext.request.contextPath}/costAction!addPzh.action",
	                            	 data:{
	                            		ids:datas 
	                            	 },
	                            	 dataType : 'json',
                                    cache : false,
                                    success:function(d){
    	                                if (d.success){
    	                                	parent.sy.messagerAlert("提示","凭证号保存成功！","info"); 
    	                                    $("#pz_manager_datagrid").datagrid("reload");                                    
    	                                }
    	                                else
    	                                	parent.sy.messagerAlert("提示","凭证号提交保存失败！","info");   
                                    }
	                             });
	                        }
						  }); 
						  }
						 else{
							 parent.sy.messagerAlert("提示","没有要保存的记录！","info");
						 }
	            	 }
                }
                ],
                onClickRow:function(rowIndex){
					if (lastIndex2 != rowIndex){
						$('#pz_manager_datagrid').datagrid('endEdit', lastIndex2);
						$('#pz_manager_datagrid').datagrid('beginEdit', rowIndex);
					}
					lastIndex2 = rowIndex;
				},
				onLoadSuccess:function(){
			  $("#pz_manager_datagrid").datagrid("clearSelections");
			}
        }
        );
    $('#pz_manager_deptid').val('${sessionInfo.deptId}');
}
);

function endEditPz(){
    var rows = $("#pz_manager_datagrid").datagrid('getRows');
    for ( var i = 0; i < rows.length; i++) {
       $("#pz_manager_datagrid").datagrid('endEdit', i);
    };
};


function _searchCostPz() {
	pz_datagrid.datagrid('load', sy.serializeObject($('#pz_search_form')));
};
function cleanSearchCostPz() {
	$("#pz_search_form ").find("input[name!='ciszd']").val('');
	 $('#pz_manager_deptid').combotree('setValue','${sessionInfo.deptId}');
	 $('#pz_manager_xingzhi').combobox('setValue','正常');
	pz_datagrid.datagrid('load', sy.serializeObject($('#pz_search_form')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询（支持模糊查询）',iconCls:'icon-search'" style="height: 230px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="pz_search_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<input type="hidden" name="ciszd" value="2" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="150px"><input  id="pz_manager_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:150px"/></td>
					<th width="100px">事由(摘要)：</th>
				    <td width="150px"><input type="text" name="cshiyou" style="width:150px"/></td>
				</tr>
				<tr>
				    <th>会计科目：</th>
				    <td><input class="easyui-combotree" name="subjectId" data-options="url:'kjkmAction!do_treegrid.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/></td>
				    <th>性质：</th>
				    <td>
					    <select id="pz_manager_xingzhi" class="easyui-combobox" name="cxz" data-options="panelHeight:'auto'" style="width:150px">  
						    <option>正常</option>  
						</select>  
					</td>
				  </tr>
				  <tr>
				    <th>所属专业：</th>
				    <td><input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/></td>
				    <th>归属项目：</th>
				    <td><input class="easyui-combobox" name="projectId" data-options="url:'projectAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/></td>
				  </tr>
				  <tr>
				    <th>创建起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="createStartDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				    <th>创建结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="createEndDate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				  </tr>
				  <tr>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchCostPz();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchCostPz();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'成本费用列表',border:true" style="overflow: hidden;">
		<table id="pz_manager_datagrid"></table>
	</div>
</div>