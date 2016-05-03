<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function () {
    $('#analysisCost1_chart').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '吉安市邮政局首季重点业务费分析表'
        },
        subtitle: {
            text: '2013年1月-2013年3月'
        },
        credits:{
        	enable : true,
        	text : '吉安市邮政局',
        	href : ''
        },
        tooltip: {
        	style : {fontSize:'12px'},
        	headerFormat: '<span style="font-size:12px">{point.key}</span><br />',
    	    pointFormat: '{series.name}<b>{point.percentage}%</b>',
        	percentageDecimals: 1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    style: {fontSize : '12px'},
                    connectorColor: '#000000',
                    formatter: function() {
                        return '<b>'+ this.point.name +'</b>：'+ this.percentage +' %';
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: '占比：',
            data: [
                ['储蓄营销费',   45.0],
                ['贺卡营销费',       26.8],
                {
                    name: '报刊营销费',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['短信营销费',    8.5],
                ['集邮营销费',     6.2],
                ['其他',   0.7]
            ]
        }]
    });
});
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'统计条件',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="analysisCost1_form" method="post"  >
			<input type="hidden" name="deptName" value="${sessionInfo.deptName}" />
			<table style="height: 100%;" class="input_table">
				<tr>
				    <th width="100px">所属单位：</th>
					<td width="150px"><input   class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true" /></td>
				    <th width="100px">归属办法名称：</th>
				    <td width="150px"><input type="text" name="fileName" /></td>
				  </tr>
				  <tr>
				    <th>责任中心：</th>
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
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="_searchBudget();">统计分析</a></td>
				    <td colspan="2" align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onClick="cleanSearchBudget();">清空条件</a></td>
				  </tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',title:'统计分析图示',iconCls:'icon-chart', border:true" ">
		<div id="analysisCost1_chart" style="padding:5px" ></div>
	</div>
</div>
