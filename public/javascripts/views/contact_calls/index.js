$(function() {
	// Contact Calls
	$("#contact_calls .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#contact_calls_search #search").keyup(function() {
		value = $("#search").val();	
		$.get($("#contact_calls_search").attr("action"), $("#contact_calls_search").serialize(), null, "script");	
	});
	
	$("#contact_calls_search #called_at").change(function() {
		value = $("#called_at").val();	
		$.get($("#contact_calls_search").attr("action"), $("#contact_calls_search").serialize(), null, "script");	
	});
});