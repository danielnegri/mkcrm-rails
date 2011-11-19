$(function() {
	// Contacts
	$("#contacts .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#contacts_search input").keyup(function() {
		value = $("#search").val();	
		$.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script");	
	});
});

