<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
 $(function(){
	 $('#auditEdit_csj').blur(function(){
		 var csj=$('#auditEdit_csj').val();
		 var sjqs=$('#auditEdit_sjqs').val();
		 var yjfy=$('#auditEdit_yjfy').val();
		 $('#auditEdit_fycy').numberbox('setValue',sjqs-yjfy); 
		 $('#auditEdit_total').numberbox('setValue',parseFloat(sjqs)+parseFloat(csj)); 
	 });
 });
 
 function audit_edit_ajaxFileUpload()  
 {  
    
     $.ajaxFileUpload  
     (  
         {  
             url:'uploadFileAction!upload.action',//用于文件上传的服务器端请求地址  
             secureuri:false,//一般设置为false  
             fileElementId:'audit_edit_file',//文件上传空间的id属性  <</span>input type="file" id="file" name="file" />  
             dataType: 'text',//返回值类型 一般设置为json  
             success: function (d,status)  //服务器成功响应处理函数  
             {  
             	var json=$.parseJSON(d);
                if (json.state){
             	   $('#audit_edit_filepath').val(json.url);
             	   $('#audit_edit_filename').val(json.filename);
                }
                parent.parent.sy.messagerShow(
                        {
                            msg : json.msg,
                            title : '提示'
                        });
             },  
             error: function (data, status, e)//服务器响应失败处理函数  
             {  
                 alert(e);  
             }  
         }  
     );  
     return false;  

 }  
</script>
<div align="center" style="padding:5px">
	<form method="post">
		<input type="hidden" name="cid" />
		<table width="560" class="input_table">
		<tr>
			<th>实际清算(不含税)：</th>
				<td><input  id="auditEdit_sjqs" name="csjfy"  class="easyui-numberbox" data-options="min:0,precision:2,required:'true'" style="width:150px"/>
				</td>
			<th>税金：</th>
			<td><input class="easyui-numberbox" data-options="min:0,precision:2,required:'true'" name="csj" id="auditEdit_csj" style="width:150px" />
			</td>
		</tr>
		 <tr>
			<th>清算与预计差异：</th>
			<td><input class="easyui-numberbox" data-options="precision:2" name="cfycy"  id="auditEdit_fycy" readonly="readonly" style="width:150px" />
			</td>
			<th>实际清算时间：</th>
			<td><input type="text" name="csjqssj" id="auditEdit_sjqssj" class="easyui-datebox" data-options="required:'true'" style="width:150px" />
			</td>
		</tr>
		<tr>
			<th>总费用：</th>
			<td colspan="3"><input class="easyui-numberbox" data-options="min:0,precision:2" name="ctotal" id="auditEdit_total" readonly="readonly" style="width:430px" /></td>
		</tr>
		 <tr>
		    <th>单位名称：</th>
		    <td >
		    	<input type="text" name="deptName" readonly="readonly" style="width:150px" />
		    </td>
		    <th >创建日期：</th>
		    <td >
		    	<input type="text" name="ccreatedate" readonly="readonly" style="width:150px" />
		    </td>
		  </tr>
		 <tr>
				<th width="130">所属专业：</th>
				<td width="150"><input type="text" name="zrzxName" readonly="readonly" style="width:150px" /></td>
				<th width="130">归属项目：</th>
				<td width="150"><input type="text" name="projectName" readonly="readonly" style="width:150px" /></td>
			</tr>
			<tr>
				<th>预计业务量收：</th>
				<td><input type="text" name="cyjywls" readonly="readonly" style="width:150px" />
				</td>
				<th>预计费用(不含税)：</th>
				<td><input type="text" name="cyjfy" id="auditEdit_yjfy" readonly="readonly" style="width:150px" />
				</td>
			</tr>
			<tr>
				<th>预计利润：</th>
				<td><input type="text"  name="cyjlr" readonly="readonly" style="width:150px" />
				</td>
				<th>预计清算时间：</th>
				<td><input type="text" name="cyjqssj"  readonly="readonly" style="width:150px" />
				</td>
			</tr>
		   <tr>
		    <th>归属办法字号：</th>
		    <td>
		    	<input type="text" name="fileNumber" readonly="readonly" style="width:150px" />
		    </td>
		    <th>归属办法名称：</th>
		    <td>
		    	<input type="text" name="fileName"  readonly="readonly" style="width:150px" />
		    </td>
		  </tr>
		  <tr>
		    <th>考核开始时间：</th>
		    <td>
		    	<input type="text" name="startdate" readonly="readonly" style="width:150px" />
		    </td>
		    <th>考核结束时间：</th>
		    <td>
		    	<input type="text" name="enddate"  readonly="readonly"  style="width:150px" />
		    </td>
		  </tr>
		   <tr >
		    <th>清算费用文件名：</th>
		    <td colspan="3"><input name="cauditfilename"  id="audit_edit_filename" style="width:430px"></td>
		  </tr>
		  <tr >
		    <th>清算文件路径：</th>
		    <td colspan="3"><input name="cauditfilepath" id="audit_edit_filepath" readonly="readonly" style="width:430px"></td>
		  </tr>
		</table>
	</form>
	<table class="input_table">
		<tr>
				<th width="100">上传清算文件：</th>
				<td >
					<div class="file-box">
						<input type='text' name='textfield' id='audit_edit_textfield' class='txt1' />
						 <input type='button' class='btn1' value='浏览...' /> 
						 <input type="file" name="file" class="file1" id="audit_edit_file" size="28" onchange="document.getElementById('audit_edit_textfield').value=this.value" /> 
						 <input type="button" name="submit" class="btn1" value="上传" onclick="return audit_edit_ajaxFileUpload();"/>
					</div>
				</td>
			</tr>
	</table>
</div>