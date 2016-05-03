<%@ page language="java"  pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function () {
    $('#analysisCost2_chart').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '吉安市邮政局重点业务费对比图'
        },
        subtitle: {
            text: '数据来源: 财务分析系统'
        },
        xAxis: {
            categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
        },
        yAxis: {
            title: {
                text: '重点业务费(万元)'
            }
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+
                    this.x +': '+ this.y +'°C';
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: '2013年',
            data: [71.0, 61.9, 91.5, 140.5, 100.4, 31.5, 55.2, 96.5, 73.3, 68.3, 83.9, 90.6]
        }, {
            name: '2012年',
            data: [60.9, 48.2, 85.7, 87.5, 110.9, 55.2, 66.0, 86.6, 94.2, 40.3, 66.6, 74.8]
        }]
    });
});
</script>
<div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',title:'统计条件',iconCls:'icon-search'" style="height: 200px;padding:5px;border-bottom:none;overflow: hidden;">
		<form id="analysisCost_form" method="post"  >
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
	<div data-options="region:'center',title:'统计分析图示',iconCls:'icon-chart', border:true" >
		<div id="analysisCost2_chart" style="padding:5px" ></div>
	</div>
</div>
