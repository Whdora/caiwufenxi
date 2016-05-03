<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
function ajaxFileUpload()  
{  
      
    $("#loading")  
    .ajaxStart(function(){  
        $(this).show();  
    })//开始上传文件时显示一个图片  
    .ajaxComplete(function(){  
        $(this).hide();  
    });//文件上传完成将图片隐藏起来  
      
    $.ajaxFileUpload  
    (  
        {  
            url:'uploadFileAction!upload.action',//用于文件上传的服务器端请求地址  
            secureuri:false,//一般设置为false  
            fileElementId:'file',//文件上传空间的id属性  <</span>input type="file" id="file" name="file" />  
            dataType: 'text',//返回值类型 一般设置为json  
            success: function (d,status)  //服务器成功响应处理函数  
            {  
            	var json=$.parseJSON(d);
               if (json.state){
            	   $('#upload_filepath').val(json.url);
            	   $('#upload_filename').val(json.filename).select();
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
	<img id="loading " src="${pageContext.request.contextPath}/js/loading.gif" style="display:none;" /><br />
	<table width="400" class="input_table">
		<tr>
			<th width="40">&nbsp;</th>
			<td width="360"><strong>点击浏览按钮选择文件，点击上传按钮上传文件！</strong>
			</td>
		</tr>
		<tr>
			<th width="40">&nbsp;</th>
			<td width="360">
				<div class="file-box">
					<input type='text' name='textfield' id='textfield' class='txt1' />
					 <input type='button' class='btn1' value='浏览...' /> 
					 <input type="file" name="file" class="file1" id="file" size="28" onchange="document.getElementById('textfield').value=this.value" /> 
					 <input type="button" name="submit" class="btn1" value="上传" onclick="return ajaxFileUpload();"/>
				</div></td>
		</tr>
	</table>
	<form id="download_add_form" method="post">
		<input type="hidden" name="userId" value="${sessionInfo.userId}" />
		<table width="400" class="input_table">
			<tr>
				<th width="100">文件链接：</th>
				<td><input type="text" id="upload_filepath" name="cfilepath" readonly="readonly" style="width:280px" />
				</td>
			</tr>
			<tr>
				<th width="100">文件名称：</th>
				<td width="300"><input type="text" id="upload_filename" name="cfilename" class="easyui-validatebox" data-options="required:'true',missingMessage:'请填写文件名称！'" style="width:280px" />
				</td>
			</tr>
		</table>
	</form>
</div>