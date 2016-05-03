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
				<th width="120">所属专业：</th>
				<td width="150"><input type="text" name="zrzxName" style="width:150px" /></td>
				<th width="120">归属项目：</th>
				<td width="150"><input type="text" name="projectName" style="width:150px" /></td>
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
			<th>实际清算时间：</th>
				<td><input type="text" name="csjqssj"  style="width:150px" />
				</td>
			<th>实际清算(不含税)：</th>
				<td><input type="text" name="csjfy"  style="width:150px"/>
				</td>
		</tr>
		 <tr>
			<th>清算与预计差异：</th>
			<td><input type="text" name="cfycy" readonly="readonly" style="width:150px" />
			</td>
			<th>税金：</th>
			<td><input type="text" name="csj" readonly="readonly" style="width:150px" />
			</td>
		</tr>
		<tr>
			<th>总费用：</th>
			<td colspan="3"><input type="text" name="ctotal" readonly="readonly" style="width:430px" /></td>
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
		    <th>归属办法文件：</th>
		    <td colspan="3"><a id="audit_view_filepath" target="_blank"><span id="audit_view_filename"></span></a></td>
		  </tr>
		  <tr >
		    <th>清算费用文件：</th>
		    <td colspan="3"><a id="audit_view_auditfilepath" target="_blank"><span id="audit_view_auditfilename"></span></a></td>
		  </tr>
		</table>
	</form>
</div>