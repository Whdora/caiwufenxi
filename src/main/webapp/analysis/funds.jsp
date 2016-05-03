<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript">
var tjfunds_datagrid;
$(function ()
{
    tjfunds_datagrid = $('#funds_tj_datagrid').datagrid(
        {
            pagination : false,
            border : false,
            fit : true,
            showFooter:true,
            checkOnSelect : true,
            selectOnCheck : true,
            singleSelect:false,
            columns : [[
					<c:out value="${fields}" escapeXml="false" />
                ]],
            toolbar : [
                {
                    text : '导出',
                    iconCls : 'icon-excel',
                    handler : function ()
                    {
                    	var sdate =$('#funds_tj_form').find("input[name='startdate']").val();
                    	var edate =$('#funds_tj_form').find("input[name='enddate']").val();
                    	var url='${pageContext.request.contextPath}/analysisAction!exportTjFund.action';
                    	if (sdate.length>0 && edate.length >0){
	                    	$('#funds_tj_form').attr('action',url);
	                        $('#funds_tj_form').submit();
                    	}else{
                    		parent.sy.messagerAlert('提示', '请选择统计日期！', 'info');
                    	}
                    }
                }, '-'
                ]
        }
        );
    $('#funds_tj_deptid').val('${sessionInfo.deptId}');
}
);


function _tjfunds() {
	var sdate =$('#funds_tj_form').find("input[name='startdate']").val();
	var edate =$('#funds_tj_form').find("input[name='enddate']").val();
	if (sdate.length>0 && edate.length >0){
		tjfunds_datagrid.datagrid({
			url : '${pageContext.request.contextPath}/analysisAction!tjfunds.action',
			queryParams:sy.serializeObject($('#funds_tj_form'))
		});
	}else
		{
		parent.sy.messagerAlert('提示', '请选择统计日期！', 'info');
		}
	};

</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'资金使用情况',iconCls:'icon-search'" style="height: 100px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="funds_tj_form" method="post"  target="_blank">
			<input type="hidden" name="deptName" value="${sessionInfo.deptName }" />
			<table style="height: 100%;" class="input_table">
				<tr>
					<th width="100px">所属单位：</th>
					<td width="120px"><input  id="funds_tj_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:120px"/></td>
					<th width="100px">起始日期：</th>
					<td width="150px">
						<input class="easyui-my97" type="text"  id="tjfunds_startdate" name="startdate" data-options="dateFmt:'yyyy-MM-dd'"  />
					</td>
					<th width="100px">结束日期：</th>
					<td width="150px">
						<input class="easyui-my97" type="text"  id="tjfunds_enddate" name="enddate" data-options="dateFmt:'yyyy-MM-dd'"  />
					</td>
				    <td width="180px" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_tjfunds();">开始统计</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'资金使用情况表',border:true" style="overflow: hidden;">
		<table id="funds_tj_datagrid"></table>
	</div>
</div>