$(document).ready () -> 
  #  Gets an array of beers the user has had and checks the appropiate boxes
  $('a#had').click ->
    $('#beer_tracker').html("You've had it!")
  $('a#unhad').click ->
    $('#beer_tracker').html("Removed from your beers")