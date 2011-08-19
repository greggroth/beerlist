$(document).ready ->
	$('#no-script').remove()
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

	###  Expanding Itemlist ###
	$('.expandable_itemlist').find('tr:odd').addClass('odd').hover (e) ->
		$(e.target).closest('tr').toggleClass("active")
	$('.manager_list:not(.beeritems)').find('tr:nth-child(3n+1)').addClass('odd').hover (e) ->
		$(e.target).closest('tr').toggleClass("active")
		
	$('.expandable_itemlist').find('tbody tr:nth-child(4n+1)').addClass('zebra')
	$('.manager_list').find('tbody tr.heading:odd').addClass('zebra')
	
	$('.expandable_itemlist, .manager_list').find('tr:not(.odd)').hide()
	$('.expandable_itemlist, .manager_list').find('tr:first-child').show()
	$('.expandable_itemlist, .manager_list').find('a').click (e) ->
		$(e.target).stopPropagation()
		
	$('.expandable_itemlist').find('tr.odd').click (e) ->
    $(e.target).closest('tr').next('tr').toggle()
   	if $(e.target).closest('tr').next('tr').is(':visible')
   		$('#itemdesc-' + $(e.target).closest('tr').attr('id')).children('div').css('border','solid thin #E8E8E8').html('loading...').load($(e.target).closest('tr').attr('item_url') + ' .itemlist').show()
	
	###  Expanding Chartlist (some things are also handled in the above secion)  ###
	$('.manager_list').find('tr.odd').click -> \
    $(this).nextAll('tr.chart:first, tr.beeritems:first').toggle \
		$(this).find('.arrow').toggleClass('up')

return
	
