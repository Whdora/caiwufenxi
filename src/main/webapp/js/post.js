$(function(){
$.extend($.fn.tree.methods,{
	getCheckedExt: function(jq){
		var checked = $(jq).tree("getChecked");
		var checkbox2 = $(jq).find("span.tree-checkbox2").parent();
		$.each(checkbox2,function(){
			var node = $.extend({}, $.data(this, "tree-node"), {
				target : this
			});
			checked.push(node);
		});
		return checked;
	},
	getSolidExt:function(jq){
		var checked =[];
		var checkbox2 = $(jq).find("span.tree-checkbox2").parent();
		$.each(checkbox2,function(){
			var node = $.extend({}, $.data(this, "tree-node"), {
				target : this
			});
			checked.push(node);
		});
		return checked;
	}
});
});