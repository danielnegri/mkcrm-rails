$(function() {
	$( "#search" ).autocomplete({
		minLength: 1,
		source: function( request, response ) {
			$.ajax({
				url: "/products.json",
				dataType: "json",
				data: {
					search: request.term
				},
				success: function( data ) {
					response( $.map( data, function( item ) {
						return {
							id: item.product.id,
							label: item.product.name,
							value: item.product.name
						}
					}));
				}
			});
		},
		select: function(event, ui) {
			$('#product_inventory_product_id').val(ui.item.id);
			$.getScript('/product_inventories/new?product_id=' + ui.item.id);
			return false;
		},		

	});
	
	
	
});