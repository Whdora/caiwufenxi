<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var pzh_add_datagrid;
$(function ()
{
    pzh_add_datagrid = $('#budget_pzh_datagrid').datagrid(
        {
            url : '${pageContext.request.contextPath}/budgetAction!do_datagrid.action',
            queryParams :{deptId:'${sessionInfo.deptId}',cstate:3},
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
                        title : '预计清算时间',
                        field : 'cyjqssj',
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
                        pzhView();
                    }
                }, '-',
                {
                    text : '增加',
                    iconCls : 'icon-append',
                    handler : function ()
                    {
                        pzhAppend();
                    }
                }, '-',
                {
                    text : '修改',
                    iconCls : 'icon-edit',
                    handler : function ()
                    {
                        pzhEdit();
                    }
                }, '-',
                              
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                        var url='${pageContext.request.contextPath}/budgetAction!exportExcel.action';
                        $('#budget_search_form').attr('action',url);
                        $('#budget_search_form').submit();
                    }
                }, '-']
        }
        );
    $('#pzh_manager_deptid').val('${sessionInfo.deptId}');
    
}
);

function pzhView()
{
	var rows = pzh_add_datagrid.datagrid('getChecked');
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '重点业务费凭证号查看',
            iconCls : 'icon-view',
            href : '${pageContext.request.contextPath}/kmlzAction!kmlzPzhView.action',
            width : 660,
            height : 600,
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
                 $('#kmlz_pzh_view_datagrid').datagrid(
                		 {
                			    url : '${pageContext.request.contextPath}/costAction!do_datagrid.action',
                	            queryParams :{budgetId:rows[0].cid,cprogress:2},
                	            pagination : true,
                	            pageSize : 5,
                	            pageList : [5, 10, 15],
                	            showFooter:true,
                	            border : true,
                	            width:600,
                	            height:250,
                	            idField : 'cid',
                	            sortName : 'cdate',
                	            sortOrder : 'desc',
                	            rownumbers: true,
                	            checkOnSelect : false,
                	            selectOnCheck : true,
                	            singleSelect:true,
                	            columns : [[
                	                        {
                	                            title : '编号',
                	                            field : 'cid',
                	                            width : 60,
                	                            align : "center",
                	                            hidden:true
                	                        },
                	                        {
                	            				title:'单位',
                	            				field:'deptName',
                	            				align:'center',
                	            				width:100,
                	            				hidden:true
                	            			},
                	            			{
                	            				title:'事由(摘要)',
                	            				field:'cshiyou',
                	            				align:'center',
                	            				width:160
                	            			},
                	            			{
                	                            title : '会计科目',
                	                            field : 'subjectName',
                	                            align : "center",
                	                            width : 100
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
                	                            width : 60
                	                        },
                	                        {
                	                            title : '凭证号',
                	                            field : 'cpzh',
                	                            align : "center",
                	                            width : 60
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
                	                            title : '入账日期',
                	                            field : 'cdate',
                	                            width : 80,
                	                            align : "center"
                	                        }
                	                       ]]
                		 });
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

function pzhEdit()
{
	var rows = pzh_add_datagrid.datagrid('getChecked');
	var lastIndex;
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '凭证号编辑',
            iconCls : 'icon-edit',
            href : '${pageContext.request.contextPath}/kmlzAction!kmlzPzhEdit.action',
            width : 660,
            height : 570,
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
                 $('#kmlz_pzh_edit_datagrid').datagrid(
                		 {
                			    url : '${pageContext.request.contextPath}/costAction!do_datagrid.action',
                	            queryParams :{budgetId:rows[0].cid,cprogress:2},
                	            pagination : true,
                	            pageSize : 10,
                	            pageList : [10, 20, 30],
                	            border : true,
                	            height:450,
                	            idField : 'cid',
                	            sortName : 'cdate',
                	            sortOrder : 'desc',
                	            rownumbers: true,
                	            checkOnSelect : false,
                	            selectOnCheck : true,
                	            singleSelect:true,
                	            columns : [[
                	                        {
                	                            title : '编号',
                	                            field : 'cid',
                	                            width : 60,
                	                            align : "center",
                	                            hidden:true
                	                        },
                	                        {
                	            				title:'单位',
                	            				field:'deptName',
                	            				align:'center',
                	            				width:100
                	            			},
                	            			{
                	            				title:'事由(摘要)',
                	            				field:'cshiyou',
                	            				align:'center',
                	            				width:200
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
                	                            title : '入账日期',
                	                            field : 'cdate',
                	                            width : 80,
                	                            align : "center"
                	                        },
                	                        {
                	                            title : '凭证号',
                	                            field : 'cpzh',
                	                            align : "center",
                	                            width : 80,
                	                            editor:"text"
                	                        }
                	                       ]],
                	             toolbar:[{
                	            	 text:"保存",
                	            	 iconCls:"icon-save",
                	            	 handler:function(){
                	            		 endEdit1();
                	            		 var updates=$("#kmlz_pzh_edit_datagrid").datagrid("getChanges","updated");
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
                     	                                	parent.sy.messagerAlert("提示","科目列账凭证号保存成功！","info"); 
                     	                                    $("#kmlz_pzh_edit_datagrid").datagrid("reload");                                    
                     	                                }
                     	                                else
                     	                                	parent.sy.messagerAlert("提示","科目列账凭证号提交保存失败！","info");   
                                                     }
                	                             });
                	                        }
                						  }); 
                						  }
                						 else{
                							 parent.sy.messagerAlert("提示","没有要保存的记录！","info");
                						 }
                	            	 }
                	             }],
                					onClickRow:function(rowIndex){
                						if (lastIndex != rowIndex){
                							$('#kmlz_pzh_edit_datagrid').datagrid('endEdit', lastIndex);
                							$('#kmlz_pzh_edit_datagrid').datagrid('beginEdit', rowIndex);
                						}
                						lastIndex = rowIndex;
                					},
                					onLoadSuccess:function(){
                				  $("#kmlz_pzh_edit_datagrid").datagrid("clearSelections");
                				}
                		 });
            }
        }
        );
    }
	else
		 if (rows.length > 1) {
				parent.sy.messagerAlert('提示', '只能选择一条记录！', 'info');
			} else {
				parent.sy.messagerAlert('提示', '请选择要增加凭证号的记录！', 'info');
			}
};

function pzhAppend()
{
	var rows = pzh_add_datagrid.datagrid('getChecked');
	var lastIndex;
	if (rows.length == 1) {
    	var p = parent.sy.dialog(
        {
            title : '凭证号录入',
            iconCls : 'icon-input',
            href : '${pageContext.request.contextPath}/kmlzAction!kmlzPzhAdd.action',
            width : 800,
            height : 570,
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
                 $('#kmlz_pzh_add_datagrid').datagrid(
                		 {
                			    url : '${pageContext.request.contextPath}/costAction!do_datagrid.action',
                	            queryParams :{budgetId:rows[0].cid,cprogress:1},
                	            pagination : true,
                	            pageSize : 10,
                	            pageList : [10, 20, 30],
                	            border : true,
                	            height:480,
                	            idField : 'cid',
                	            sortName : 'cdate',
                	            sortOrder : 'desc',
                	            rownumbers: true,
                	            checkOnSelect : false,
                	            selectOnCheck : true,
                	            singleSelect:true,
                	            columns : [[
                	                        {
                	                            title : '编号',
                	                            field : 'cid',
                	                            width : 60,
                	                            align : "center",
                	                            hidden:true
                	                        },
                	                        {
                	            				title:'单位',
                	            				field:'deptName',
                	            				align:'center',
                	            				width:100
                	            			},
                	            			{
                	            				title:'事由(摘要)',
                	            				field:'cshiyou',
                	            				align:'center',
                	            				width:200
                	            			},
                	            			{
                	                            title : '会计科目',
                	                            field : 'subjectName',
                	                            align : "center",
                	                            width : 80
                	                        },
                	                        {
                	                            title : '金额',
                	                            field : 'camount',
                	                            align : "center",
                	                            width : 60,
                	                            sortable : true
                	                        },
                	                        {
                	                            title : '税金',
                	                            field : 'csj',
                	                            align : "center",
                	                            width : 60
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
                	                            width : 100
                	                        },
                	                        {
                	                            title : '入账日期',
                	                            field : 'cdate',
                	                            width : 80,
                	                            align : "center"
                	                        },
                	                        {
                	                            title : '凭证号',
                	                            field : 'cpzh',
                	                            align : "center",
                	                            width : 80,
                	                            editor:"text"
                	                        }
                	                       ]],
                	             toolbar:[{
                	            	 text:"保存",
                	            	 iconCls:"icon-save",
                	            	 handler:function(){
                	            		 endEdit();
                	            		 var updates=$("#kmlz_pzh_add_datagrid").datagrid("getChanges","updated");
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
                     	                                	parent.sy.messagerAlert("提示","科目列账凭证号保存成功！","info"); 
                     	                                    $("#kmlz_pzh_add_datagrid").datagrid("reload");                                    
                     	                                }
                     	                                else
                     	                                	parent.sy.messagerAlert("提示","科目列账凭证号提交保存失败！","info");   
                                                     }
                	                             });
                	                        }
                						  }); 
                						  }
                						 else{
                							 parent.sy.messagerAlert("提示","没有要保存的记录！","info");
                						 }
                	            	 }
                	             }],
                					onClickRow:function(rowIndex){
                						if (lastIndex != rowIndex){
                							$('#kmlz_pzh_add_datagrid').datagrid('endEdit', lastIndex);
                							$('#kmlz_pzh_add_datagrid').datagrid('beginEdit', rowIndex);
                						}
                						lastIndex = rowIndex;
                					},
                					onLoadSuccess:function(){
                				  $("#kmlz_pzh_add_datagrid").datagrid("clearSelections");
                				}
                		 });
            }
        }
        );
    }
	else
		 if (rows.length > 1) {
				parent.sy.messagerAlert('提示', '只能选择一条记录！', 'info');
			} else {
				parent.sy.messagerAlert('提示', '请选择要增加凭证号的记录！', 'info');
			}
};

function endEdit(){
    var rows = $("#kmlz_pzh_add_datagrid").datagrid('getRows');
    for ( var i = 0; i < rows.length; i++) {
       $("#kmlz_pzh_add_datagrid").datagrid('endEdit', i);
    };
};

function endEdit1(){
    var rows = $("#kmlz_pzh_edit_datagrid").datagrid('getRows');
    for ( var i = 0; i < rows.length; i++) {
       $("#kmlz_pzh_edit_datagrid").datagrid('endEdit', i);
    };
};

function _searchPzh() {
	pzh_add_datagrid.datagrid('load', sy.serializeObject($('#budget_search_form')));
};
function cleanSearchPzh() {
	$('#budget_search_form table input[name!=deptId]').val('');
	pzh_add_datagrid.datagrid('load', sy.serializeObject($('#budget_search_form')));
};
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询预算（支持模糊查询）',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="budget_search_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">所属单位：</th>
					<td width="150px"><input  id="pzh_manager_deptid" class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true" /></td>
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
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchPzh();">开始查询</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchPzh();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'重点业务费预算列表',border:true" style="overflow: hidden;">
		<table id="budget_pzh_datagrid"></table>
	</div>
</div>
