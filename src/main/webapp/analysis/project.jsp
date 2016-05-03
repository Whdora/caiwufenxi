<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var tjproject_datagrid;
$(function ()
{
    tjproject_datagrid = $('#project_tj_datagrid').datagrid(
        {
            pagination : false,
            border : false,
            fit : true,
            showFooter:true,
            idField : 'projectId',
            sortName : 'projectId',
            sortOrder : 'asc',
            checkOnSelect : true,
            selectOnCheck : true,
            singleSelect:false,
            columns : [[
					{
					    title : '单位',
					    field : 'deptName',
					    width : 120,
					    align : "center"
					},   
                    {
                        title : '专业名称',
                        field : 'cname',
                        width : 180,
                        align : "center"
                    },
                    {
                        title : '本年累计',
                        field : 'bntotal',
                        width : 80,
                        align : "center"
                    },
                    {
                        title : '本年支付内部',
                        field : 'bnnb',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '本年支付外部',
                        field : 'bnwb',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '本月累计',
                        field : 'bytotal',
                        width : 80,
                        align : "center"
                    },
                    {
                        title : '本月支付内部',
                        field : 'bynb',
                        align : "center",
                        width : 100
                    },
                    {
                        title : '本月支付外部',
                        field : 'bywb',
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
                    	var sd =$('#project_tj_form').find("input[name='cmonth']").val();
                    	var url='${pageContext.request.contextPath}/analysisAction!exportTjzrzx.action';
                    	if (sd.length>0 ){
	                    	$('#project_tj_form').attr('action',url);
	                        $('#project_tj_form').submit();
                    	}else{
                    		parent.sy.messagerAlert('提示', '请选择统计月份！', 'info');
                    	}
                    }
                }, '-'
                ]
        }
        );
    $('#project_tj_deptid').val('${sessionInfo.deptId}');
}
);


function _tjproject() {
	var sd =$('#project_tj_form').find("input[name='cmonth']").val();
	if (sd.length>0 ){
		tjproject_datagrid.datagrid({
			url : '${pageContext.request.contextPath}/analysisAction!tjproject.action',
			queryParams:sy.serializeObject($('#project_tj_form'))
		});
	}else
		{
		parent.sy.messagerAlert('提示', '请选择统计月份！', 'info');
		}
	};

</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'重点业务成本统计',iconCls:'icon-search'" style="height: 100px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="project_tj_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="120px"><input  id="project_tj_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:120px"/></td>
					<th width="100px">统计月份：</th>
					<td width="150px">
						<input class="easyui-my97" type="text" name="cmonth" id="tjproject_cmonth" data-options="dateFmt:'yyyy年MM月'"  />
					</td>
				    <td width="180px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_tjproject();">开始统计</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'重点业务成本列支情况表',border:true" style="overflow: hidden;">
		<table id="project_tj_datagrid"></table>
	</div>
</div>