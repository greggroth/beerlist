var jQT = new $.jQTouch();

$(document).ready(function() {
	var loading_message;
	loarding_message = '<p id="loading-message">Loading...</p>';
	
	$('a.back').live('click', function() {
		jQT.goBack();
	});
	
	$('a.home').live('click', function() {
		jQT.goTo('#beer_items_index', 'dissolve');
	});
	
	$("a.button_bars_index").live("click", function() {
		$("div#bars_index_container").html(loarding_message).load("/bars");
		jQT.goTo('#bars_index', 'slideleft');
	});
	
	$("a.button_beers_index").live("click", function() {
		$("div#beers_index_container").html(loarding_message).load("/beers");
		jQT.goTo('#beers_index', 'slideleft');
	});
	
	$("a.button_beer_items_show").live("click", function() {
		var id;
		id = $(this).attr("bi-id");
		$("div#beer_items_show_container").html(loarding_message).load("/beer_items/" + id);
		jQT.goTo('#beer_items_show', 'slideleft');
	});
	
	$("a.button_beers_show").live("click", function() {
		var id;
		id = $(this).attr("beer-id");
		$("div#beers_show .toolbar h1").html($(this).attr("beer-name"));
		$("div#beers_show_container").html(loarding_message).load("/beers/" + id);   //  Replace Title with Beer Name
		jQT.goTo('#beers_show', 'slideleft');
	});
	
	$("a.button_bars_show").live("click", function() {
		var id;
		id = $(this).attr("bar-id");
		$("div#bars_show .toolbar h1").html($(this).attr("bar-name"));
		$("div#bars_show_container").html(loarding_message).load("/bars/" + id);     //  Replace Title with Bar Name
		jQT.goTo('#bars_show', 'slideleft');
	});
	
	$("a.button_breweries_show").live("click", function() {
		var id;
		id = $(this).attr("brewery-id");
		$("div#breweries_show .toolbar h1").html($(this).attr("brewery-name"));
		$("div#breweries_show_container").html(loarding_message).load("/breweries/" + id);     //  Replace Title with brewery Name
		jQT.goTo('#breweries_show', 'slideleft');
	});
});