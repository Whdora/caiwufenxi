<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
$(function(){
	if('${sessionInfo.isLock()}'=='true'){
		lockWindow();
	}
});
function lockWindow(){
	var p = parent.sy.dialog({
		title : '已锁定',
		iconCls: 'icon-lock',
		href : '${pageContext.request.contextPath}/userAction!doNotNeedAuth_lock.action',
		width : 280,
		height : 160,
		closable : false,
		modal : true,
		buttons : [ {
			text : '解锁',
			iconCls: 'icon-key',
			handler : function() {
				var f = p.find('form');
				f.form('submit', {
					url : '${pageContext.request.contextPath}/userAction!doNotNeedAuth_unlock.action',
					success : function(d) {
						var json = $.parseJSON(d);
						if (json.success) {
							p.dialog('close');
						}
						parent.sy.messagerShow({
							msg : json.msg,
							title : '提示'
						});
					}
				});
			}
		} ],
		onLoad : function() {
			f=p.find('form');
			f.form('load',{
				cid:'${sessionInfo.userId}',
				cusername:'${sessionInfo.loginName}'
			});
		}
	});
};
	function logout() {
		$('#sessionInfoDiv').html('');
		$.post('${pageContext.request.contextPath}/userAction!do_logout.action', function() {
			location.replace('${pageContext.request.contextPath}/');
		});
	};
	function userChangePwd() {
		var p = parent.sy.dialog({
			title : '修改用户密码',
			iconCls: 'icon-edit',
			href : '${pageContext.request.contextPath}/userAction!doNotNeedAuth_userChangePwd.action',
			width : 300,
			height : 230,
			buttons : [ {
				text : '保存',
				iconCls: 'icon-save',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/userAction!doNotNeedAuth_editPwd.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								p.dialog('close');
							}
							parent.sy.messagerShow({
								msg : json.msg,
								title : '提示'
							});
						}
					});
				}
			} ],
			onLoad : function() {
				f=p.find('form');
				f.form('load',{
					cid:'${sessionInfo.userId}',
					cusername:'${sessionInfo.loginName}'
				});
			}
		});
	}
</script>
<h1>痛快科技财务分析系统</h1>
<div id="sessionInfoDiv" style="position: absolute;right: 5px;top:10px;overflow: hidden;">
	<c:if test="${sessionInfo.userId != null}"><strong>${sessionInfo.loginName}</strong>[${sessionInfo.deptName}]，欢迎你！您使用[<strong>${sessionInfo.ipAddress}</strong>]IP登录！</c:if>
</div>
<div style="position: absolute; right: 0px; bottom: 0px; ">
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'icon-theme'">更换皮肤</a> <a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'icon-controller'">控制面板</a> <a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_zxMenu',iconCls:'icon-system'">系统管理</a>
</div>
<div id="layout_north_pfMenu" style="width: 120px; display: none;">
	<div onclick="sy.changeTheme('default');">default</div>
	<div onclick="sy.changeTheme('gray');">gray</div>
	<div onclick="sy.changeTheme('metro');">metro</div>
	<div onclick="sy.changeTheme('black');">black</div>
	<div onclick="sy.changeTheme('cupertino');">cupertino</div>
	<div onclick="sy.changeTheme('dark-hive');">dark-hive</div>
	<div onclick="sy.changeTheme('pepper-grinder');">pepper-grinder</div>
	<div onclick="sy.changeTheme('sunny');">sunny</div>
	<div onclick="sy.changeTheme('bootstrap');">bootstrap</div>
</div>
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div onclick="userChangePwd();" data-options="iconCls:'icon-key'">修改密码</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'icon-theme'">
		<span>更换主题</span>
		<div style="width: 120px;">
			<div onclick="sy.changeTheme('default');">default</div>
			<div onclick="sy.changeTheme('gray');">gray</div>
			<div onclick="sy.changeTheme('metro');">metro</div>
			<div onclick="sy.changeTheme('black');">black</div>
			<div onclick="sy.changeTheme('cupertino');">cupertino</div>
			<div onclick="sy.changeTheme('dark-hive');">dark-hive</div>
			<div onclick="sy.changeTheme('pepper-grinder');">pepper-grinder</div>
			<div onclick="sy.changeTheme('sunny');">sunny</div>
			<div onclick="sy.changeTheme('bootstrap');">bootstrap</div>
		</div>
	</div>
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div onclick="lockWindow();" data-options="iconCls:'icon-lock'">锁定窗口</div>
	<div class="menu-sep"></div>
	<div onclick="logout();" data-options="iconCls:'icon-exit'">退出系统</div>
</div>
