<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
var tjnormal_datagrid;
$(function ()
{
    tjnormal_datagrid = $('#normal_tj_datagrid').datagrid(
        {
            pagination : false,
            border : false,
            fit : true,
            showFooter:true,
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
                        title : '项目名称',
                        field : 'cname',
                        width : 180,
                        align : "center"
                    },
                    {
                        title : '本年累计',
                        field : 'bntotal',
                        width : 120,
                        align : "center"
                    },
                    {
                        title : '本月累计',
                        field : 'bytotal',
                        width : 120,
                        align : "center"
                    }
                ]],
            toolbar : [
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                    	var sd =$('#normal_tj_form').find("input[name='cmonth']").val();
                    	var url='${pageContext.request.contextPath}/analysisAction!exportTjNormal.action';
                    	if (sd.length>0 ){
	                    	$('#normal_tj_form').attr('action',url);
	                        $('#normal_tj_form').submit();
                    	}else{
                    		parent.sy.messagerAlert('提示', '请选择统计月份！', 'info');
                    	}
                    }
                }, '-'
                ]
        }
        );
    $('#normal_tj_deptid').val('${sessionInfo.deptId}');
}
);


function _tjnormal() {
	var sd =$('#normal_tj_form').find("input[name='cmonth']").val();
	if (sd.length>0 ){
		tjnormal_datagrid.datagrid({
			url : '${pageContext.request.contextPath}/analysisAction!tjnormal.action',
			queryParams:sy.serializeObject($('#normal_tj_form'))
		});
	}else
		{
		parent.sy.messagerAlert('提示', '请选择统计月份！', 'info');
		}
	};

</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'正常成本费用统计',iconCls:'icon-search'" style="height: 100px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="normal_tj_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="120px"><input  id="normal_tj_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:120px"/></td>
					<th width="100px">统计月份：</th>
					<td width="150px">
						<input class="easyui-my97" type="text" name="cmonth" id="tjnormal_cmonth" data-options="dateFmt:'yyyy年MM月'"  />
					</td>
				    <td width="180px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_tjnormal();">开始统计</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'正常成本费用列支情况表',border:true" style="overflow: hidden;">
		<table id="normal_tj_datagrid"></table>
	</div>
</div>