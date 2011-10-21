$(document).ready () ->	
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
  return 