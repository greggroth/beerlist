/* DO NOT MODIFY. This file was compiled Wed, 14 Dec 2011 20:50:17 GMT from
 * /Users/Greggory/Programing/beerlist/app/assets/javascripts/beers.coffee
 */


  $(document).ready(function() {
    $('a#had').click(function() {
      return $('#beer_tracker').html("You've had it!");
    });
    return $('a#unhad').click(function() {
      return $('#beer_tracker').html("Removed from your beers");
    });
  });
