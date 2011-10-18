$ () ->
	checkedId = $('form.rating_ballot > input:checked').attr('id')
	$('form.rating_ballot > label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright')
	console.log(checkedId)

$(document).ready () ->	
	$('form.rating_ballot > label').hover \
		( -> $(this).prevAll().andSelf().addClass('glow')), \
		( -> $(this).siblings().andSelf().removeClass('glow'))
	
	$('form.rating_ballot > label').click -> \
		$(this).siblings().removeClass("bright") \
		$(this).prevAll().andSelf().addClass("bright")

  $('form.rating_ballot').change -> 
    $('form.rating_ballot').submit()