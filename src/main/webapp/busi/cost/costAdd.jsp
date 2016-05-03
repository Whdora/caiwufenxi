<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function(){
	  $('#cost_file_input').combogrid({
		  url : '${pageContext.request.contextPath}/budgetAction!do_datagrid.action?cstate=3&deptId=${sessionInfo.deptId}',
          pagination : true,
          pageSize : 5,
          pageList : [5,10, 15, 20],
          border : true,
          fit: true,
          idField : 'cid',
          singleSelect : true,
          textField : 'fileNumber',
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
                      field : 'fileNumber',
                      align : "center",
                      width : 120,
                      sortable : true
                  },
                  {
                      title : '归属办法名称',
                      field : 'fileName',
                      align : "center",
                      width : 200
                  },
                  {
                	  title : '所属专业',
                      field : 'zrzxName',
                      align : "center",
                      width : 80 
                  },
                  {
                	  title : '所属项目',
                      field : 'projectName',
                      align : "center",
                      width : 100
                  },
                  {
                      title : '创建时间',
                      field : 'ccreatedate',
                      align : "center",
                      width : 150
                  }
              ]]
	  });
	  $('#cost_xingzhi').combobox({
		  onChange:function(){
			  var xz=$('#cost_xingzhi').combobox('getValue');
			  if (xz=="重点"){
				  $('#cost_file_tr').show();
			  }else{
				 $('#cost_file_input').combogrid('clear');
				 $('#cost_file_tr').hide();
			  };
		  }
	  });
	  $('#cost_lzfs').combobox({
		  onChange:function(){
			  var lzfs=$('#cost_lzfs').combobox('getValue');
			  if (lzfs=="转账"){
				  $('#cost_add_fx').html('方向：<input type="radio" name="cfx" checked="checked"  value="借"/>借<input type="radio" name="cfx"   value="贷"/>贷');
			  }else{
				 $('#cost_add_fx').html('');
			  };
		  }
	  });
	  $('#cost_add_deptid').val('${sessionInfo.deptId }');
	 $('#costAdd_kjkm').combotree({
		 url:'kjkmAction!do_treegrid.action',
		 panelHeight:430,
		 required:true,
		 cascadeCheck:false,
		 lines:true,
		 onBeforeSelect:function(node){
			 if (!$(this).tree('isLeaf',node.target)){
				 return false;
			 }
		 },
		 onClick:function(node){
			 if (!$(this).tree('isLeaf',node.target)){
				 $('#costAdd_kjkm').combo('showPanel');
			 }
		 }
	 }) ;
	 $('#costAdd_kind').combotree({
		 url:'kindAction!do_treegrid.action',
		 panelHeight:200,
		 required:true,
		 cascadeCheck:false,
		 lines:true,
		 onBeforeSelect:function(node){
			 if (!$(this).tree('isLeaf',node.target)){
				 return false;
			 }
		 },
		 onClick:function(node){
			 if (!$(this).tree('isLeaf',node.target)){
				 $('#costAdd_kind').combo('showPanel');
			 }
		 }
	 }) ;
  });
  
 </script>
<div align="center" style="padding:5px">
	<form id="cost_add_form" method="post">
		<input type="hidden" name="userId" value="${sessionInfo.userId}" />
		<input type="hidden" name="ciszd" value="2" /> 
		<table  class="input_table">
		<tr>
			<th width="100px">所属单位：</th>
			<td width="180px"><input  id="cost_add_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:155px"/></td>
			<th width="100">性质：</th>
		    <td width="180" >
		        <select id="cost_xingzhi" class="easyui-combobox" name="cxz" data-options="panelHeight:'auto',required:true" style="width:155px">  
				    <option selected="selected">重点</option> 
				    <option >正常</option>   
				</select>  
			</td>
		</tr>
		<tr>
			<th>入账属性：</th>
			<td>
				 <select  class="easyui-combobox" name="crzsx" data-options="panelHeight:'auto',required:true" style="width:155px">  
				    <option selected="selected">正常</option> 
				    <option >预提</option>   
				</select>  
			</td>
			<th>单证编号：</th>
			<td><input type="text" name="cbh" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写单证编号！'" style="width:155px" /></td>
		</tr>
		 <tr>
		    <th>列支方式：</th>
		    <td >
		    	<select id="cost_lzfs" class="easyui-combobox" name="clzfs" data-options="panelHeight:'auto',required:true" style="width:155px">  
				    <option selected="selected">现金</option>  
				    <option>银行</option>
				     <option>银行（市局付）</option>
				    <option>转账</option> 
				    <option>收款</option> 
				</select> 
		    </td>
		    <th>借贷方向：</th>
		  	<td>
		  		<input type="radio" name="cfx" checked="checked"  value="借"/>借<input type="radio" name="cfx"   value="贷"/>贷
		  	</td>
		  </tr>
		  <tr>
		    <th>事由(摘要)：</th>
		     <td colspan="3"><input type="text" name="cshiyou" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写事由（摘要）！'" style="width:440px" /></td>
		 </tr>
		 <tr>
		 	<th>会计科目：</th>
		    <td colspan="3">
		    	<input  name="subjectId" id="costAdd_kjkm"  style="width:440px"/>
		    </td>	
		 </tr>
		 <tr>
			<th>归类：</th>
		    <td>
		    	<input id="costAdd_kind" name="kindId"  />
		    </td> 
		 	<th>入账时间：</th>
		 	<td>
		 		<input type="text" name="cdate" class="easyui-datebox" data-options="required:'true'"  style="width:155px"/>
		 	</td>
		  </tr>
		  <tr>
		    <th>金额：</th>
		    <td><input class="easyui-numberbox" id="cost_input_amount" name="camount" data-options="precision:2,required:'true'" /></td>
		    <th >税金：</th>
		    <td >
		    	<input class="easyui-numberbox" id="cost_input_sj" name="csj" data-options="precision:2,required:'true'" />
		    </td>
		  </tr>
		  <tr>
		    <th>所属专业：</th>
		    <td>
		    	<input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'"  />
		    </td>
		    <th>归属项目：</th>
		    <td>
		    	<input class="easyui-combobox" name="projectId" data-options="url:'projectAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'"  />
		    </td>
		  </tr>
		   <tr id="cost_file_tr">
		    <th>成本预算：</th>
		    <td colspan="3"><input type="text" id="cost_file_input" name="budgetId"  style="width:440px" /></td>
		  </tr>
		  <tr>
		  	 <th>商品：</th>
		    <td>
		    	<input class="easyui-combobox" name="shangpinId" data-options="url:'shangpinAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'"  />
		    </td>
		  </tr>
		</table>
	</form>
</div>