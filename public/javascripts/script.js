$(document).ready(function() {
	// alert($('#itemlist tbody tr:even').length + ' elements!');
	$('#no-script').remove();
//  Alternations colors for table row backgrounds
	$('.itemlist tbody tr:nth-child(odd)').addClass('zebra');
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
	/*
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
	*/
	
// Animations for links in the header
	
	$('#user_bar a').hover(function() {
		  $(this).animate({paddingBottom: '+=15px'}, 200);
		}, function() {
		  $(this).animate({paddingBottom: '-=15px'}, 200);
		});
	
// Show details (Brewery Page)
	/*
	$('<p>Click on a row to see more details</p>').insertBefore('.expandable_itemlist');
	
	$('.itemlist.expandable_itemlist tbody tr').click(function() {
		var url = $(this).attr('id') + " .itemlist";
		$('.itemlist tbody > tr').fadeTo(500,1);        // get all of the rows back to full opacity
		
		alert($(this).next().is('tr#brew-row'));
		
		if ($(this).next().is('tr#brew-row')) {         // Clicked to Close
			$('.itemlist tbody > #brew-row').remove().fadeOut("fast");
			$(this).removeClass('bordered');
		} else {                                        // Clicked to Open
			// $(this).addClass('zebra');
			$('.itemlist tbody #brew-row').remove().fadeOut("fast");
			$('<tr id="brew-row"><td colspan="6" class="brew-desc"></td></tr>').insertAfter(this);
			$('.itemlist tbody tr:not(#brew-row)').not(this).fadeTo(500,0.2);
			$('.brew-desc').html('loading...').load(url);
		}
	});
	*/

	$('#expanding_brewery_list').jExpand();
	$('#expanding_followed_bars_list').jExpand();
	$('#expanding_all_bars_list').jExpand();
		
	});