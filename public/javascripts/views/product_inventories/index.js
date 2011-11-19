$(function() {	
	// Product Inventories
	$("#product_inventories .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#product_inventories_search input").keyup(function() {
		$.get($("#product_inventories_search").attr("action"), $("#product_inventories_search").serialize(), null, "script");
	});	
});



