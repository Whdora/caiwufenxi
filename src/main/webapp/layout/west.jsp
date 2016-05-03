<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
	var ctrlTree;
	$(function() {
		ctrlTree = $('#ctrlTree').tree({
			url : '${pageContext.request.contextPath}/menuAction!do_UserMenus.action?userId='+'${sessionInfo.userId}',
			lines : true,
			onClick : function(node) {
				addTab(node);
			},
			onDblClick : function(node) {
				if (node.state == 'closed') {
					$(this).tree('expand', node.target);
				} else {
					$(this).tree('collapse', node.target);
				}
			}
		});

	});
</script>
		<ul id="ctrlTree" style="margin-top: 5px;margin-left:5px;"></ul>
