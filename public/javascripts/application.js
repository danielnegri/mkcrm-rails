$(function() {	
	// Application
	$('#reminder_header_bar_link,  #reminder_header_bar_icon_link').click(function() {
		$('#reminders_panel').toggleClass('hidden');
		return false;
	});
		
	// Events
	$("#events .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#events_search #search").keyup(function() {
		value = $("#search").val();	
		$.get($("#events_search").attr("action"), $("#events_search").serialize(), null, "script");	
	});
	
	$("#events_search #start_at").change(function() {
		value = $("#start_at").val();	
		$.get($("#events_search").attr("action"), $("#events_search").serialize(), null, "script");	
	});	
	
	// Profiles
	$("#profiles .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#profiles_search input").keyup(function() {
		value = $("#search").val();	
		$.get($("#profiles_search").attr("action"), $("#profiles_search").serialize(), null, "script");	
	});
	
	// Reminders
	$("#reminders .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	
	$("#reminders_search #search").keyup(function() {
		value = $("#search").val();	
		$.get($("#reminders_search").attr("action"), $("#reminders_search").serialize(), null, "script");	
	});
	
	$("#reminders_search #scheduled_at").change(function() {
		value = $("#scheduled_at").val();	
		$.get($("#reminders_search").attr("action"), $("#reminders_search").serialize(), null, "script");	
	});
	
		
	// Datetime Picker
	$.datepicker.setDefaults( $.datepicker.regional[ "pt-BR" ] );	
	
	// Prevent double click
	$('form').submit(function(){
	    $('input[type=submit]', this).attr('disabled', 'disabled');
	});	
});



