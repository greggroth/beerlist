$(document).ready () -> 
  #  Gets an array of beers the user has had and checks the appropiate boxes
  $('#beer_tracker > a').click ->
    console.log("Clicked")
    $('#beer_tracker').html("You've had it!")