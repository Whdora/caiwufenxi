<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
function file_edit_ajaxFileUpload()  
{  
   
    $.ajaxFileUpload  
    (  
        {  
            url:'uploadFileAction!upload.action',//用于文件上传的服务器端请求地址  
            secureuri:false,//一般设置为false  
            fileElementId:'file_edit',//文件上传空间的id属性  <</span>input type="file" id="file" name="file" />  
            dataType: 'text',//返回值类型 一般设置为json  
            success: function (d,status)  //服务器成功响应处理函数  
            {  
            	var json=$.parseJSON(d);
               if (json.state){
            	   $('#file_edit_path').val(json.url);
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
		<table  class="input_table">
			<tr>
				<th width="100">归属办法文件号：</th>
				<td ><input type="text" name="cfilenumber" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写归属办法文件号！'" style="width:250px" /></td>
			</tr>
			<tr>
				<th width="100">归属办法名称：</th>
				<td ><input type="text" name="cname" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写归属办法名称！'" style="width:250px" /></td>
			</tr>
			<tr>
				<th width="100">文件制定日期：</th>
				<td ><input type="text" name="cdate" class="easyui-datebox" data-options="required:'true'"  style="width:250px"/></td>
			</tr>
			<tr>
				<th width="100">考核开始日期：</th>
				<td ><input type="text" name="cstartdate" class="easyui-datebox" data-options="required:'true'"  style="width:250px"/></td>
			</tr>
			<tr>
				<th width="100">考核结束日期：</th>
				<td ><input type="text" name="cenddate" class="easyui-datebox" data-options="required:'true'"  style="width:250px"/></td>
			</tr>
			<tr>
				<th width="100">文件存储路径：</th>
				<td><input type="text" name="cfilepath" id="file_edit_path" class="easyui-validatebox" readonly="readonly" style="width:250px"/></td>
			</tr>
		</table>
	</form>
	<table class="input_table">
		<tr>
				<th width="100">上传文件：</th>
				<td >
					<div class="file-box">
						<input type='text' name='textfield' id='textfield_fileEdit' class='txt1' />
						 <input type='button' class='btn1' value='浏览...' /> 
						 <input type="file" name="file" class="file1" id="file_edit" size="28" onchange="document.getElementById('textfield_fileEdit').value=this.value" /> 
						 <input type="button" name="submit" class="btn1" value="上传" onclick="return file_edit_ajaxFileUpload();"/>
					</div>
				</td>
			</tr>
	</table>
</div>