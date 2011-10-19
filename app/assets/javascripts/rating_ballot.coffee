$('form.rating_ballot').each ->
  checkedId = $(this).children('input:checked').attr('id')
  $(this).children('label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright')

$(document).ready () ->	
  $('form.rating_ballot > label').hover \
    ( -> $(this).prevAll().andSelf().addClass('glow')), \
    ( -> $(this).siblings().andSelf().removeClass('glow'))
  
  $('form.rating_ballot > label').click () ->
    $(this).siblings().removeClass("bright")
    $(this).prevAll().andSelf().addClass("bright")
  
  $('form.rating_ballot').change () -> 
    $(this).submit()
  
  
  return 