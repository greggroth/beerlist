window.Application ||= {}

$(document).ready ->
	$('.itemlist tbody tr:nth-child(odd)').addClass('zebra')
	$('#user_bar a').hover(  
		-> 
			$(this).animate({paddingBottom: '+=15px'}, 200)
			return
		-> 
			$(this).animate({paddingBottom: '-=15px'}, 200)
			return
		)
		
	### Generate Charts for /bar_owner ###
	$('div.chart').each ->
		$.jqplot($(this).attr('id'), [$(this).metadata().chartdata], {
			title: 'Followers', 
			axes:{xaxis:{renderer:$.jqplot.DateAxisRenderer}},
			series:[{lineWidth: 4, showMarker: false}]
			})

	###  Manager_list ###
	$('.manager_list:not(.beeritems)').find('tr:nth-child(3n+1)').addClass('odd').hover (e) ->
		$(e.target).closest('tr').toggleClass("active")
	$('.manager_list').find('tbody tr.heading:odd').addClass('zebra')
	
	$('.manager_list').find('tr:not(.odd)').hide()
	$('.manager_list').find('tr:first-child').show()
	$('.manager_list').find('a').click (e) ->
		e.stopPropagation()
	$('.manager_list').find('div.follow_form').click (e) ->
		e.stopPropagation()
			
	###  Expanding Chartlist (some things are also handled in the above secion)  ###
	$('.manager_list').find('tr.odd').click -> \
    $(this).nextAll('tr.chart:first, tr.beeritems:first').toggle \
		$(this).find('.arrow').toggleClass('up')
		
  ###  Detail/Edit Links visible on hover ###
	$('a.action_link').hide()
	$('tr').hover ->
		$(this).find('a.action_link').toggle()
		
	###  Up/Down sort arrows ###
	$('#sorted_beer_item_list a').click ->
		$(this).parent('th').find('.arrow').toggleClass('asc current')
		
	###  format expanding itemlist function ###
	Application.format_expandable_itemlist('.expandable_itemlist')

	###  add notice for beer_item edit ###
	$('#beer_item_pouring_notice').hide()
	$('#beer_item_pouring').change ->
		if $(this).val() == 'pitcher'
			$('#beer_item_pouring_notice').show()
		else
			$('#beer_item_pouring_notice').hideide()
			
	###  Show/Hide Google Map              ###      
	$('#toggle-map-link a').click ->
		if $('#toggle-map-link a').html() == 'Hide Map'
			$('#toggle-map-link a').html('Show Map')
		else
			$('#toggle-map-link a').html('Hide Map')
		$('.map_container').toggle()

	###  Sorting Options ###
	$('#adv-searching').hide()
	$('#adv-searching-button').click ->
		$('div#adv-searching').toggle()

	return
	
	
Application.format_expandable_itemlist = (x) ->
	###  Expandable Itemlist ###
	$(x).find('tr:odd').addClass('odd').hover (e) -> \
		$(e.target).closest('tr').toggleClass("active"); \
		$(e.target).closest('tr').find('a.action_link').toggle()
		
	$(x).find('tbody tr:nth-child(4n+1)').addClass('zebra')
	
	$(x).find('tr:not(.odd)').hide()
	$(x).find('tr:first-child').show()
	$(x).find('a').click (e) ->
		e.stopPropagation()
	$(x).find('div.follow_form').click (e) ->
		e.stopPropagation()
	
	$(x).find('tr.odd').click ->
    $(this).closest('tr').next('tr').toggle()
   	if $(this).closest('tr').next('tr').is(':visible')
   		$('#itemdesc-' + $(this).closest('tr').attr('id')).children('div').css('border','solid thin #E8E8E8').html('loading...').load($(this).closest('tr').attr('item_url') + ' .itemlist')
	return
