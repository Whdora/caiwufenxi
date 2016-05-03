<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" charset="utf-8">
	var centerTabs;
	var tabsMenu;
	$(function() {
		tabsMenu = $('#tabsMenu').menu(
				{
					onClick : function(item) {
						var curTabTitle = $(this).data('tabTitle');
						var type = $(item.target).attr('type');

						if (type === 'refresh') {
							refreshTab(curTabTitle);
							return;
						}

						if (type === 'close') {
							var t = centerTabs.tabs('getTab', curTabTitle);
							if (t.panel('options').closable) {
								centerTabs.tabs('close', curTabTitle);
							}
							return;
						}

						var allTabs = centerTabs.tabs('tabs');
						var closeTabsTitle = [];

						$.each(allTabs, function() {
							var opt = $(this).panel('options');
							if (opt.closable && opt.title != curTabTitle
									&& type === 'closeOther') {
								closeTabsTitle.push(opt.title);
							} else if (opt.closable && type === 'closeAll') {
								closeTabsTitle.push(opt.title);
							}
						});

						for ( var i = 0; i < closeTabsTitle.length; i++) {
							centerTabs.tabs('close', closeTabsTitle[i]);
						}
					}
				});

		centerTabs = $('#centerTabs')
				.tabs(
						{
							fit : true,
							border : false,
							onContextMenu : function(e, title) {
								e.preventDefault();
								tabsMenu.menu('show', {
									left : e.pageX,
									top : e.pageY
								}).data('tabTitle', title);
							},
							tools : [
									{
										iconCls : 'icon-reload',
										handler : function() {
											var href = $('#centerTabs')
													.tabs('getSelected').panel(
															'options').href;
											if (href) {/*说明tab是以href方式引入的目标页面*/
												var index = $(
														'#centerTabs')
														.tabs(
																'getTabIndex',
																$(
																		'#centerTabs')
																		.tabs(
																				'getSelected'));
												$('#centerTabs').tabs(
														'getTab', index).panel(
														'refresh');
											} else {/*说明tab是以content方式引入的目标页面*/
												var panel = $(
														'#centerTabs')
														.tabs('getSelected')
														.panel('panel');
												var frame = panel
														.find('iframe');
												try {
													if (frame.length > 0) {
														for ( var i = 0; i < frame.length; i++) {
															frame[i].contentWindow.document
																	.write('');
															frame[i].contentWindow
																	.close();
															frame[i].src = frame[i].src;
														}
														if ($.browser.msie) {
															CollectGarbage();
														}
													}
												} catch (e) {
												}
											}
										}
									},
									{
										iconCls : 'icon-no',
										handler : function() {
											var index = $('#centerTabs')
													.tabs(
															'getTabIndex',
															$(
																	'#centerTabs')
																	.tabs(
																			'getSelected'));
											var tab = $('#centerTabs')
													.tabs('getTab', index);
											if (tab.panel('options').closable) {
												$('#centerTabs').tabs(
														'close', index);
											} else {
												$.messager
														.alert(
																'提示',
																'['
																		+ tab
																				.panel('options').title
																		+ ']不可以被关闭',
																'error');
											}
										}
									} ]
						});
	});
	function addTab(node) {
		if (centerTabs.tabs('exists', node.text)) {
			centerTabs.tabs('select', node.text);
		} else {
			if (node.attributes.url && node.attributes.url.length > 0) {
				centerTabs.tabs('add', {
					title : node.text,
					closable : true,
					iconCls : node.iconCls,
					href : node.attributes.url
				});
			} 
		}
	}
	function refreshTab(title) {
		var tab = centerTabs.tabs('getTab', title);
		centerTabs.tabs('update', {
			tab : tab,
			options : tab.panel('options')
		});
	}
</script>
<div id="centerTabs" >
	<div title="首页" data-options="border:false" style="overflow: hidden;">
					<iframe src="${pageContext.request.contextPath}/layout/portal/index.jsp" frameborder="0" style="border: 0; width: 100%; height: 98%;"></iframe>
				</div>
</div>
<div id="tabsMenu" style="width: 120px;display:none;">
	<div type="refresh">刷新</div>
	<div class="menu-sep"></div>
	<div type="close">关闭</div>
	<div type="closeOther">关闭其他</div>
	<div type="closeAll">关闭所有</div>
</div>