<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	 $('#normalCostEdit_kjkm').combotree({
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
				 $('#normalCostEdit_kjkm').combo('showPanel');
			 }
		 }
	 }) ;
});
</script>
<div align="center" style="padding:5px">
		<form method="post">
		<input type="hidden" name="cid"  />
		<input type="hidden" name="cxz"  />
		<input type="hidden" name="crzsx"  />
		<table  class="input_table">
		 <tr>
		 <th width="100px">所属单位：</th>
			<td width="180px"><input  id="normal_cost_edit_deptid"  class="easyui-combotree" name="deptId" data-options="url:'deptAction!do_showDept.action?cid=${sessionInfo.deptId }',panelHeight:'auto',required:true"  style="width:155px"/></td>
		    <th width="100">列支方式：</th>
		    <td width="180">
		    	<select  class="easyui-combobox" name="clzfs" data-options="panelHeight:'auto',required:true" style="width:155px">  
				   <option selected="selected">现金</option>  
				    <option>银行</option>
				     <option>银行（市局付）</option>
				    <option>转账</option> 
				    <option>收款</option> 
				</select>  
		    </td>
		  </tr>
		  <tr>
		  		<th>借贷方向：</th>
			  	<td>
			  		<input type="radio" name="cfx" checked="checked"  value="借"/>借<input type="radio" name="cfx"   value="贷"/>贷
			  	</td>
			  	 <th>金额：</th>
		    	<td><input class="easyui-numberbox"  name="camount" data-options="precision:2,required:'true'" /></td>
		  </tr>
		  <tr>
		    <th>事由(摘要)：</th>
		    <td colspan="3" ><input type="text" name="cshiyou" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写事由（摘要）！'" style="width:440px" /></td>
		 </tr>
		 <tr>	
		 	<th>会计科目：</th>
		    <td colspan="3">
		    	<input id="normalCostEdit_kjkm" name="subjectId"   style="width:440px"/>
		    </td>
		  </tr>  
		  <tr>
		  	<th>单证编号：</th>
			<td><input type="text" name="cbh" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写单证编号！'" style="width:155px" /></td>
		 	<th>入账时间：</th>
		 	<td>
		 		<input type="text" name="cdate" class="easyui-datebox" data-options="required:'true'"  style="width:155px"/>
		 	</td>
		  </tr>
		  <tr>
		    <th>所属专业：</th>
		    <td>
		    	<input class="easyui-combobox" name="zrzxId" data-options="url:'zrzxAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'"  />
		    </td>
		    <th>商品：</th>
		    <td>
		    	<input class="easyui-combobox" name="shangpinId" data-options="url:'shangpinAction!do_combobox.action',panelHeight:'auto',required:true,valueField:'cid',textField:'cname'"  />
		    </td>
		  </tr>
		</table>
	</form>
</div>