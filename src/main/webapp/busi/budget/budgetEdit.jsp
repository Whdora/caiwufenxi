<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function(){
	  $('#budget_file_edit').combogrid({
		  url : '${pageContext.request.contextPath}/fileAction!do_datagrid.action?deptId=${sessionInfo.deptId}',
          pagination : true,
          pageSize : 5,
          pageList : [5, 10, 15, 20],
          border : true,
          fit: true,
          required: true,
          idField : 'cid',
          singleSelect : true,
          textField : 'cfilenumber',
          sortName : 'ccreatedate',
          sortOrder : 'desc',
          checkOnSelect : false,
          selectOnCheck : true,
          columns : [[
                  {
                      title : '编号',
                      field : 'cid',
                      width : 150,
                      align : "center",
                      hidden : true
                  },
                  {
                      title : '归属办法文件号',
                      field : 'cfilenumber',
                      align : "center",
                      width : 180,
                      sortable : true
                  },
                  {
                      title : '归属办法名称',
                      field : 'cname',
                      align : "center",
                      width : 250,
                      formatter : function(value, rowData, rowIndex) {
      					return sy.fs('<a href="{0}" target="_blank" >{1}</a>',"${pageContext.request.contextPath}"+rowData.cfilepath,rowData.cname);
      				}
                  },
                  {
                      title : '创建时间',
                      field : 'ccreatedate',
                      align : "center",
                      width : 150,
                      hidden: true
                  }
              ]]
	  });
  });
 </script>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid"  />
		<table width="550" class="input_table">
			<tr >
				<th>归属办法：</th>
				<td colspan="3"><input type="text" id="budget_file_edit" name="fileId" style="width:440px" />
				</td>
			</tr>
			<tr>
				<th width="120">所属专业：</th>
				<td width="150"><input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'" /></td>
				<th width="120">归属项目：</th>
				<td width="150"><input class="easyui-combobox" name="projectId" data-options="url:'projectAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'" /></td>
			</tr>
			<tr>
				<th>预计业务量收：</th>
				<td><input class="easyui-numberbox" name="cyjywls" data-options="min:0,precision:2,required:'true'" />
				</td>
				<th>预计费用(不含税)：</th>
				<td><input class="easyui-numberbox" name="cyjfy" data-options="min:0,precision:2,required:'true'" />
				</td>
			</tr>
			<tr>
				<th>预计利润：</th>
				<td><input class="easyui-numberbox" name="cyjlr" data-options="min:0,precision:2,required:'true'" />
				</td>
				<th>预计清算时间：</th>
				<td><input type="text" name="cyjqssj" class="easyui-datebox" data-options="required:'true'" style="width:150px" />
				</td>
			</tr>
		</table>
	</form>
</div>