$(document).ready(function() {
	// alert($('#itemlist tbody tr:even').length + ' elements!');
	$('#no-script').remove();
//  Alternations colors for table row backgrounds
	$('.itemlist tbody tr:even').addClass('zebra');
// TEST BUTTON STUFFS
 /*
	$('<input type="button" value="Hide" id="toggleButton">').insertBefore('#disclaimer');
	$('#toggleButton').click(function() {
	 	$('#disclaimer').slideToggle();
		if ($('#disclaimer').is(':visible')) {
			// $('#disclaimer').fadeOut('fast');
			$(this).val('Hide');
		} else {
			// $('#disclaimer').fadeIn('fast');
			$(this).val('Show');
		}})
	 //$('#disclaimer').animate({'backgroundColor':'#ff0000'}, 2000);
 */
 
// Bars Index (_list.html.erb) for hide/show tables
	$('#followingBars-toggleButton').click(function() {
		$('#followed-bars').slideToggle();
		if ($('#followed-bars').is(':visible')) {
			// $('#disclamer').fadeOut('fast');
			$(this).val('Hide');
		} else {
			// $('#disclamer').fadeIn('fast');
			$(this).val('Show');
		}})
	$('#allBars-toggleButton').click(function() {
		$('#all-bars').slideToggle();
		if ($('#all-bars').is(':visible')) {
			// $('#disclamer').fadeOut('fast');
			$(this).val('Hide');
		} else {
			// $('#disclamer').fadeIn('fast');
			$(this).val('Show');
		}})
	
// Animations for links in the header
	
	$('#user_bar a').hover(function() {
		  $(this).animate({paddingBottom: '+=15px'}, 200);
		}, function() {
		  $(this).animate({paddingBottom: '-=15px'}, 200);
		});
	
// Show details
	$('#brewery_itemlist.itemlist tbody tr').click(function() {
		var url = $(this).attr('id') + " .itemlist";
		//alert($(this).next().is('tr#brew-row'))
		if ($(this).next().is('tr#brew-row')) {
			$('.itemlist tbody > #brew-row').remove().fadeOut("fast");
		} else {
			$('.itemlist tbody > .brew-desc').remove().fadeOut("fast");
			$('<tr id="brew-row"><td colspan="5" class="brew-desc"></td></tr>').insertAfter(this);
			$('.brew-desc').html('loading...').load(url);
		}
	});
		
	});