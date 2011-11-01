$(document).ready ->
  $('div#new-beer-from-beer-item').hide()
  $('select#beer_item_beer_id').prepend('<option value="new">New Beer</option>').change ->
    $('div#new-beer-from-beer-item').toggle()