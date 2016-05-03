$(function() {
	var $dialog = $('<div/>');
	var $formBody = $('#form-body');
	$dialog.dialog({
		height : 300,
		width : 500,
		content : $formBody.show(),
		noheader : true,
		buttons : [ {
			id : 'loginBtn',
			disabled : true,
			text : '登陆',
			handler : function() {
				$.post('userAction!do_login.action', $formBody.serialize(), function(rsp) {
					if (rsp.success) {
						window.location.href="layout/main.jsp";
					} else {
						$.messager.alert('提示', rsp.msg);
						$verifyInput.val('');
						$verifyImg.click();
					}
				}, 'JSON').error(function() {
					$.messager.alert('提示', '系统错误,请联系管理员！');
				});
			}
		} ]
	});
	$formBody.after($('#logo').show());
	var $verifyInput = $('<input class="verify-input" maxlength="4"/>');
	$verifyInput.keydown(function() {
		return $formBody.form('validate');
	}).keyup(function() {
		var target = this;
		if (target.value.length === 4) {
			$(target).blur();
			$.post('verifyCodeAction!do_verify.action', {
				code : this.value
			}, function(rsp) {
				if (rsp.success) {
					 $('#loginBtn').linkbutton('enable').click();
				} else {
					$(target).focus().val('');
					$verifyImg.click();
					$.messager.show({
						msg : rsp.msg,
						title : '提示'
					});
				}
			}, 'JSON').error(function() {
				$(target).focus().val('');
				$verifyImg.click();
			});
		}
	});
	var $verifyImg = $('<img src="public/yzm.jsp" class="verify-img"/>');
	$verifyImg.on('click', function() {
		$(this).attr('src', 'public/yzm.jsp?t=' + new Date().getTime());
	});
	$('.dialog-button').prepend($verifyInput).prepend($verifyImg);
	$(window).resize(function() {
		$dialog.dialog('center');
	});
	$('#cusername').focus();
});