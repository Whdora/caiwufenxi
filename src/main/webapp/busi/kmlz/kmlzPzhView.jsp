<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table  class="input_table">
		 <tr>
		    <th>单位名称：</th>
		    <td >
		    	<input type="text" name="deptName"  style="width:150px" />
		    </td>
		    <th >创建日期：</th>
		    <td >
		    	<input type="text" name="ccreatedate"  style="width:150px" />
		    </td>
		  </tr>
		 <tr>
				<th width="140">所属专业：</th>
				<td width="180"><input type="text" name="zrzxName" style="width:150px" /></td>
				<th width="140">归属项目：</th>
				<td width="180"><input type="text" name="projectName" style="width:150px" /></td>
			</tr>
			<tr>
				<th>预计业务量收：</th>
				<td><input type="text" name="cyjywls" style="width:150px" />
				</td>
				<th>预计费用(不含税)：</th>
				<td><input type="text" name="cyjfy" style="width:150px" />
				</td>
			</tr>
			<tr>
				<th>预计利润：</th>
				<td><input type="text"  name="cyjlr" style="width:150px" />
				</td>
				<th>预计清算时间：</th>
				<td><input type="text" name="cyjqssj"  style="width:150px" />
				</td>
			</tr>
		   <tr>
		    <th>归属办法字号：</th>
		    <td>
		    	<input type="text" name="fileNumber"  style="width:150px" />
		    </td>
		    <th>归属办法名称：</th>
		    <td>
		    	<input type="text" name="fileName"  style="width:150px" />
		    </td>
		  </tr>
		  <tr>
		    <th>考核开始时间：</th>
		    <td>
		    	<input type="text" name="startdate"  style="width:150px" />
		    </td>
		    <th>考核结束时间：</th>
		    <td>
		    	<input type="text" name="enddate"  style="width:150px" />
		    </td>
		  </tr>
		   <tr >
		    <th>查看办法内容：</th>
		    <td colspan="3">&nbsp;<a target="_blank"><span ></span></a></td>
		  </tr>
		  <tr >
		    <th><strong>成本费用列表：</strong></th>
		    <td colspan="3">&nbsp;</td>
		  </tr>
		</table>
	</form>
	<table id="kmlz_pzh_view_datagrid"></table>
</div>