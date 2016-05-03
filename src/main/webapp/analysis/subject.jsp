<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var tjsubject_datagrid;
$(function ()
{
    tjsubject_datagrid = $('#subject_tj_datagrid').datagrid(
        {
            pagination : false,
            border : false,
            fit : true,
            idField : 'subjectId',
            sortName : 'subjectId',
            sortOrder : 'asc',
            checkOnSelect : true,
            selectOnCheck : true,
            singleSelect:false,
            columns : [[
					{
					    title : '会计科目编号',
					    field : 'subjectId',
					    width : 120,
					    align : "center"
					},   
                    {
                        title : '会计科目名称',
                        field : 'subjectName',
                        width : 180,
                        align : "center"
                    },
                    {
                        title : '上期余额',
                        field : 'sqye',
                        width : 80,
                        align : "center"
                    },
                    {
                        title : '本期发生额（借）',
                        field : 'bqyej',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '本期发生额（贷）',
                        field : 'bqyed',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '本期余额',
                        field : 'bqye',
                        align : "center",
                        width : 100
                    }
                ]],
            toolbar : [
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                    	var sd =$('#subject_tj_form').find("input[name='startdate']").val();
                    	var ed =$('#subject_tj_form').find("input[name='enddate']").val();
                    	var url='${pageContext.request.contextPath}/analysisAction!exportTjSubject.action';
                    	if (sd.length>0 && ed.length>0){
	                    	$('#subject_tj_form').attr('action',url);
	                        $('#subject_tj_form').submit();
                    	}else{
                    		parent.sy.messagerAlert('提示', '请选择入账开始和结束日期！', 'info');
                    	}
                    }
                }, '-'
                ]
        }
        );
    $('#subject_tj_deptid').val('${sessionInfo.deptId}');
    $('#tjsubject_kjkm').combotree({
		 url:'kjkmAction!do_treegrid.action',
		 panelHeight:400
	 }) ;
}
);


function _searchCost() {
	var sd =$('#subject_tj_form').find("input[name='startdate']").val();
	var ed =$('#subject_tj_form').find("input[name='enddate']").val();
	if (sd.length>0 && ed.length>0){
		tjsubject_datagrid.datagrid({
			url : '${pageContext.request.contextPath}/analysisAction!tjsubject.action',
			queryParams:sy.serializeObject($('#subject_tj_form'))
		});
	}else
		{
		parent.sy.messagerAlert('提示', '请选择入账开始和结束日期！', 'info');
		}
	};

</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'查询科目余额',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="subject_tj_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="120px"><input  id="subject_tj_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:120px"/></td>
		   			 <th width="100px">性质：</th>
				    <td width="150">
					    <select id="subject_tj_xingzhi" class="easyui-combobox" name="ciszd" data-options="panelHeight:'auto'" style="width:150px">  
						    <option value="0">不限定</option>
						    <option value="1" >正常</option>  
						    <option value="2">重点</option>
						</select>  
					</td >
					 <th width="100px">所属专业：</th>
				    <td width="150">
				    	<input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',valueField:'cid',textField:'cname'" style="width:150px"/>
				    </td>
				</tr>
				<tr>
				    <th>会计科目：</th>
				    <td colspan="5"><input id="tjsubject_kjkm" name="subjectId"  style="width:450px"/></td>
				  </tr>
				<tr>
				    <th>入账起始日期：</th>
				    <td><input class="easyui-my97" type="text" name="startdate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				    <th>入账结束日期：</th>
				    <td><input class="easyui-my97" type="text" name="enddate" data-options="dateFmt:'yyyy-MM-dd'" style="width:150px"/></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchCost();">开始统计</a></td>
				 </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'科目余额列表',border:true" style="overflow: hidden;">
		<table id="subject_tj_datagrid"></table>
	</div>
</div>