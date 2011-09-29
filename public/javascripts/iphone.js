//  Highlights the button for the page the user is on

$('#beer_items_index').live( 'pageinit',function(event){
	$("a#footer-home").addClass("ui-btn-active");
});

$('#bars_index').live( 'pageinit',function(event){
	$("a#footer-bars").addClass("ui-btn-active");
});

$('#beers_index').live( 'pageinit',function(event){
	$("a#footer-beers").addClass("ui-btn-active");
});

$('#breweries_index').live( 'pageinit',function(event){
	$("a#footer-breweries").addClass("ui-btn-active");
});

// Capitalizes state abreviation on bars_edit and bars_new

$('#bars_new, #bars_edit').live( 'pageinit', function(){
	$('input#bar_state').bind( "change", function() {
		$(this).val($(this).val().toUpperCase());
	});
});