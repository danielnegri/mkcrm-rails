$(function() {
	$( "#called_at" ).datepicker({
		dateFormat: 'dd/mm/yy',
		defaultDate: "+1w",
		changeMonth: true,
		changeYear: false
	})
});


$(function() {
	$('#contact-call-form').dialog({
		autoOpen: false,
		height: 352,
		width: 450,
		show: "fade",
		hide: "fade",
		modal: true
	});
	
	$( "#add-contact-call" ).click(function() {
		$( '#contact-call-form' ).dialog( "open" );
		return false;
	});
	
	$( '#contact-call-form .datepicker' ).datepicker({
		dateFormat: 'dd/mm/yy',
		defaultDate: "+1w",
		changeMonth: true,
		changeYear: false,				
		onKeyUp: function() {
			this.value = this.value.replace(/[^0-9\/]/g,''); 	
		},
		onSelect: function( selectedDate ) {
			instance = $( this ).data( "datepicker" );
			date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );

			$("#" + this.id + "_1i").val(date.getFullYear());
			$("#" + this.id + "_2i").val(date.getMonth()+1);
			$("#" + this.id + "_3i").val(date.getDate());
		}
		
	});
	
	$(function() {
		$( "#contact-call-form .datepicker" ).datepicker({
			dateFormat: 'dd/mm/yy',
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: false,				
			onKeyUp: function() {
				this.value = this.value.replace(/[^0-9\/]/g,''); 	
			},
			onSelect: function( selectedDate ) {
				var instance = $( this ).data( "datepicker" ),
				date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );

				$("#" + this.id + "_1i").val(date.getFullYear());
				$("#" + this.id + "_2i").val(date.getMonth()+1);
				$("#" + this.id + "_3i").val(date.getDate());
			}
		})
	});	
	
	var updateFields = function() {
		var selectedDate = $( "#contact-call-form .datepicker" ).val();
		var instance = $( "#contact-call-form .datepicker" ).data( "datepicker" ),
			date = $.datepicker.parseDate(
				instance.settings.dateFormat ||
				$.datepicker._defaults.dateFormat,
				selectedDate, instance.settings );

		$("#contact_call_called_at" + "_1i").val(date.getFullYear());
		$("#contact_call_called_at" + "_2i").val(date.getMonth()+1);
		$("#contact_call_called_at" + "_3i").val(date.getDate());
	};
	
	$('.datepicker').change( updateFields );
	$('form').submit( updateFields );
});