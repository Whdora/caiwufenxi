<%@ page language="java" pageEncoding="UTF-8"%>
<div align="center" style="padding:5px">
	<form method="post">
		<table  class="input_table">
		 <tr>
		    <th width="100">单位名称：</th>
		    <td width="160">
		    	<input type="text" name="deptName" readonly="readonly"  style="width:150px" />
		    </td>
		    <th width="100">入账时间：</th>
		    <td width="160">
		    	<input type="text" name="cdate"  readonly="readonly"  style="width:150px" />
		    </td>
		  </tr>
		 <tr>
		    <th >列支方式：</th>
		    <td>
		    	<input type="text" name="clzfs" readonly="readonly"  style="width:150px" />
		    </td>
		    <th >借贷方向：</th>
		    <td>
		    	<input type="text" name="cfx" readonly="readonly"  style="width:150px" />
		    </td>
		 </tr>   
		 <tr>
			 <th >单证编号：</th>
			    <td>
			    	<input type="text" name="cbh" readonly="readonly"  style="width:150px" />
			    </td>
		    <th>性质：</th>
		    <td>
		    	<input type="text" name="cxz" readonly="readonly" style="width:150px" />
		    </td>
		  </tr>
		  <tr>
		    <th>事由(摘要)：</th>
		    <td ><input type="text" name="cshiyou" readonly="readonly" style="width:150px" /></td>
		    <th>会计科目：</th>
		    <td>
		    	<input type="text" name="subjectName"  readonly="readonly" style="width:150px" />
		    </td>
		  </tr>
		  <tr>
		    <th>金额：</th>
		    <td><input type="text" name="camount"  readonly="readonly"  style="width:150px" /></td>
		    <th>税金：</th>
		    <td>
		    	<input type="text" name="csj"  readonly="readonly" style="width:150px" />
		    </td>
		  </tr>
		  <tr>
		    <th>归类：</th>
		    <td>
		    	<input type="text" name="kindName"  readonly="readonly" style="width:150px" />
		    </td>
		    <th>所属专业：</th>
		    <td>
		    	<input type="text" name="zrzxName" readonly="readonly"  style="width:150px" />
		    </td>
		  </tr>
		  <tr>
		    <th>入账属性：</th>
		    <td>
		    	<input type="text" name="crzsx"  readonly="readonly"  style="width:150px" />
		    </td>
		    <th>归属项目：</th>
		    <td>
		    	<input type="text" name="projectName"  readonly="readonly"  style="width:150px" />
		    </td>
		  </tr>
		   <tr>
		    <th>商品：</th>
		    <td>
		    	<input type="text" name="shangpinName"  readonly="readonly"  style="width:150px" />
		    </td>
		  </tr>
		   <tr>
		    <th>归属办法字号：</th>
		    <td>
		    	<input type="text" name="fileNumber" readonly="readonly"  style="width:150px" />
		    </td>
		    <th>归属办法：</th>
		    <td>
		    	<input type="text" name="fileName"  readonly="readonly" style="width:150px" />
		    </td>
		  </tr>
		</table>
	</form>
</div>