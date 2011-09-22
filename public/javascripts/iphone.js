$.jQTouch({
	statusBar: 'black-translucent'
});

$(document).ready(function() {
	var loading_message;
	loarding_message = '<p id="loading-message">Loading...</p>'
	
	$('a.button_bars_index').live('click', function() {
		$('div#bars_index_container').html(loarding_message).load("/bars");
	});
	
	$('a.button_beers_index').live('click', function() {
		$('div#beers_index_container').html(loarding_message).load("/beers");
	});
	
	$('a.button_beer_items_show').live('click', function() {
		var id;
		id = $(this).attr('bi-id');
		$('div#beer_items_show_container').html(loarding_message).load('/beer_items/' + id);
	})
	
	$('a.button_beers_show').live('click', function() {
		var id;
		id = $(this).attr('beer-id');
		$('div#beers_show .toolbar h1').html($(this).attr('beer-name'));
		$('div#beers_show_container').html(loarding_message).load('/beers/' + id);   //  Replace Title with Beer Name
	})
	
	$('a.button_bars_show').live('click', function() {
		var id;
		id = $(this).attr('bar-id');
		$('div#bars_show .toolbar h1').html($(this).attr('bar-name'));
		$('div#bars_show_container').html(loarding_message).load('/bars/' + id);     //  Replace Title with Bar Name
	})
	
	$('a.button_breweries_show').live('click', function() {
		var id;
		id = $(this).attr('brewery-id');
		$('div#breweries_show .toolbar h1').html($(this).attr('brewery-name'));
		$('div#breweries_show_container').html(loarding_message).load('/breweries/' + id);     //  Replace Title with brewery Name
	})
});