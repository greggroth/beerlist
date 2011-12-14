$(document).ready () ->	
  #  Gets an array of beers the user has had and checks the appropiate boxes
  $.getJSON '/beer_tracks', (data) ->
    console.log(data)
    $('.beer_tracking_checkbox').each (index) ->
      if $.inArray( parseInt($(this).attr('data-beer')), data ) != -1
        $(this).attr("checked", "checked")
        
  $('form.rating_ballot').each ->
    checkedId = $(this).children('input:checked').attr('id')
    $(this).children('label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright')
  
  $('form.rating_ballot > label').live 'hover', (e) ->
    if e.type == "mouseenter"
      $(this).prevAll().andSelf().addClass('glow')
    else
      $(this).siblings().andSelf().removeClass('glow')

  $('form.rating_ballot > label').live 'click', () ->
    $(this).siblings().removeClass("bright")
    $(this).prevAll().andSelf().addClass("bright")
    
  $('a#close-popup').live 'click', () ->
    $('div#rating-popup-container').empty()

  $('form.rating_ballot').live 'change', () -> 
    $(this).submit()
    
  $('.beer_tracking_checkbox').live 'change', (e) ->
    bar = $(e.target).attr('data-bar')
    beer = $(e.target).attr('data-beer')
    token = $('meta[name=csrf-token]').attr('content')
    
    $.post '/beer_tracks', { "authenticity_token": token, "beer_track" : { "bar_id": bar, "beer_id": beer } }
  
  return 