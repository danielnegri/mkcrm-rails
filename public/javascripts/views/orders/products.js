$(function() {	
	// Products for Orders
	$("#products .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#products_search input").keyup(function() {
		$.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
	});	
	
	$("#products .shortcuts a").live("click", function() {
		$.getScript(this.href);
		return false;
	});	
});

function add_product(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g");
	$(link).up().insert({
		before: content.replace(regexp, new_id)
	});
}



